import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:random_string/random_string.dart';

class SuperAdminUserModel{
  String uid;
  String name;
  String email;
  String contactEmail;
  String phoneNumber;
  String hotLine;
  String group;
  bool isActive;

  SuperAdminUserModel({
    this.uid,
    this.name,
    this.email,
    this.contactEmail,
    this.phoneNumber,
    this.hotLine,
    this.group,
    this.isActive
  });

  factory SuperAdminUserModel.fromSnapData(DocumentSnapshot snap){
    Map data = snap.data();
    return SuperAdminUserModel(
      uid: snap.id,
      name: data["name"],
      email: data["email"],
      contactEmail: data["contactEmail"],
      phoneNumber: data["phoneNumber"],
      hotLine: data["hotLine"],
      group: data["group"],
      isActive: data["isActive"],
    );
  }
}


Stream<List<SuperAdminUserModel>> getAdminAccounts() {
  return FirebaseFirestore.instance
      .collection('admin_accounts')
      .where("group",isEqualTo: "super_bus_admin")
      .snapshots()
      .map((snap) {
    return snap.docs.map((doc) => SuperAdminUserModel.fromSnapData(doc)).toList();
  });
}


Future<bool> createSuperBusAdminAccount(
    {String name,
      String phone,
      String accountEmail,
      String contactEmail,
      String hotLine
    }) async {
  if (name.trim().length < 3) {
    return null;
  }
  if (phone.trim().length < 10) {
    return null;
  }
  FirebaseApp superAdminApp = await Firebase.initializeApp(
      name: 'superAdmin', options: Firebase.app().options);
  FirebaseAuth authCreateNewAccount = FirebaseAuth.instanceFor(app: superAdminApp);

  try {
    String pass = "busstopadmin";
    String randomCode = randomNumeric(5);
    String password = pass + randomCode;

    UserCredential result = await authCreateNewAccount
        .createUserWithEmailAndPassword(email: accountEmail, password: password);

    if (result.user != null) {
      await FirebaseFirestore.instance
          .collection("admin_accounts").doc(result.user.uid).set(
          {
            "name": name,
            "email": accountEmail,
            "contactEmail": contactEmail,
            "phoneNumber": phone,
            "hotLine": hotLine,
            "password": password,
            "isActive": true,
            "group": "super_bus_admin"
          }
      );
      await superAdminApp.delete();
      return true;
    }
  } catch (e) {
    String err = e.toString();
    if (kDebugMode) {
      print(err);
    }
    await superAdminApp.delete();
    return false;
  }
}