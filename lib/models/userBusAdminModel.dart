import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:random_string/random_string.dart';

class BusAdminModel{
  String uid;
  String name;
  String contactEmail;
  String phoneNumber;
  String hotLine;
  String logo;

  BusAdminModel({this.uid,this.name,this.contactEmail,this.phoneNumber,this.hotLine,this.logo});

  factory BusAdminModel.fromSnapshot(DocumentSnapshot snap){
    return BusAdminModel(
      uid: snap.id,
      name: snap.get("name"),
      contactEmail: snap.get("contactEmail"),
      phoneNumber: snap.get("phoneNumber"),
      hotLine: snap.get("hotLine") ?? "",
      logo: snap.get("logo"),
    );
  }
}

Future<bool> createBusAdminAccount(
    {String name,
      String accountEmail,
      String contactEmail,
      String phone,
      String hotline}) async {
  if (name.trim().length < 3) {
    return false;
  }
  if (phone.trim().length < 10) {
    return false;
  }
  FirebaseApp busApp = await Firebase.initializeApp(
      name: 'bus', options: Firebase.app().options);
  FirebaseAuth authCreateNewAccount = FirebaseAuth.instanceFor(app: busApp);

  try {
    String pass = "bustop_";
    String randomCode = randomNumeric(6);
    String password = pass + randomCode;

    UserCredential result = await authCreateNewAccount
        .createUserWithEmailAndPassword(email: accountEmail, password: password);

    if (result.user != null) {
      await FirebaseFirestore.instance
          .collection("admin_accounts")
          .doc(result.user.uid)
          .set({
        "name": name,
        "email": accountEmail,
        "contactEmail": contactEmail,
        "phoneNumber": phone,
        "password": password,
        "isActive": true,
        "group": "bus_admin",
      });
      await FirebaseFirestore.instance
          .collection("companies")
          .doc(result.user.uid)
          .set({
        "name": name,
        "email": accountEmail,
        "contactEmail": contactEmail,
        "phoneNumber": phone,
        "hotLine": hotline,
        "logo": "",
        "parks": [],
        "parksLocations": [],
      });
      await busApp.delete();
      return true;
    }
  } catch (e) {
    String err = e.toString();
    if (kDebugMode) {
      print(err);
    }
    await busApp.delete();
    return false;
  }
}

Future deleteBusCompanyAccount({String email, String password}) async {
  FirebaseApp busApp = await Firebase.initializeApp(
      name: 'busCompany', options: Firebase.app().options);
  FirebaseAuth authCourierApp = FirebaseAuth.instanceFor(app: busApp);
  try {
    UserCredential result = await authCourierApp.signInWithEmailAndPassword(
        email: email, password: password);
    await FirebaseFirestore.instance
        .collection("companies")
        .doc(result.user.uid)
        .delete();
    await result.user.delete();
    await busApp.delete();
    return "Success";
  } catch (e) {
    String err = e.toString();
    print("Error");
    print(err);
    await busApp.delete();
    return null;
  }
}