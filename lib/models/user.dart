import 'package:cloud_firestore/cloud_firestore.dart';

class AdminUserModel{
  String uid;
  String name;
  String email;
  String contactEmail;
  String phoneNumber;
  String group;
  bool isActive;

  AdminUserModel({
    this.uid,
    this.name,
    this.email,
    this.contactEmail,
    this.phoneNumber,
    this.group,
    this.isActive
  });

  factory AdminUserModel.fromSnapshot(DocumentSnapshot snap){
    return AdminUserModel(
      uid: snap.id,
      name: snap.get("name"),
      email: snap.get("email"),
      contactEmail: snap.get("contactEmail"),
      phoneNumber: snap.get("phoneNumber"),
      group: snap.get("group"),
      isActive: snap.get("isActive"),
    );
  }

  factory AdminUserModel.fromSnapData(DocumentSnapshot snap){
    Map data = snap.data();
    return AdminUserModel(
      uid: snap.id,
      name: data["name"],
      email: data["email"],
      contactEmail: data["contactEmail"],
      phoneNumber: data["phoneNumber"],
      group: data["group"],
      isActive: data["isActive"],
    );
  }
}


