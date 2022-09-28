import 'package:cloud_firestore/cloud_firestore.dart';

class UserClientModel{
  String uid;
  String email;
  String phone;
  String name;

  UserClientModel({
    this.uid,
    this.email,
    this.phone,
    this.name,
});

  factory UserClientModel.fromSnapShot(DocumentSnapshot snapshot){
    Map data = snapshot.data();
    return UserClientModel(
      uid: snapshot.id,
      name: data["username"],
      email: data["email"],
      phone: data["phoneNumber"]
    );
  }
}

Stream<List<UserClientModel>> getAllClients() {
  return FirebaseFirestore.instance.collection("clients")
      .snapshots()
      .map((snap) {
        return snap.docs.map((doc) => UserClientModel.fromSnapShot(doc)).toList();
  });
}