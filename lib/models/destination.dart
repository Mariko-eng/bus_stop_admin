import 'package:cloud_firestore/cloud_firestore.dart';

class Destination {
  final String id;
  final String name;

  Destination({this.id, this.name});

  factory Destination.fromSnapshot(DocumentSnapshot snap) {
    Map data = snap.data();
    return Destination(
        id: snap.id,
        name: data["name"] ?? ""
    );
  }
}

Future getDestinations() async {
  var results =
      await FirebaseFirestore.instance.collection("destinations").get();
  return results.docs.map((doc) => Destination.fromSnapshot(doc)).toList();
}

Stream<List<Destination>> getAllDestinations() {
  return FirebaseFirestore.instance
      .collection('destinations')
      .snapshots()
      .map((snap) {
    return snap.docs.map((doc) => Destination.fromSnapshot(doc)).toList();
  });
}

Future<bool> addDestinations({String name}) async {
  try {
    var results =
        await FirebaseFirestore.instance.collection("destinations").get();
    List<Destination> dests =
        results.docs.map((doc) => Destination.fromSnapshot(doc)).toList();
    for (int i = 0; i < dests.length; i++) {
      if (name.trim() == dests[i].name.trim()) {
        return false;
      }
    }
    await FirebaseFirestore.instance.collection("destinations").add({
      "name": name,
    });
    return true;
  } catch (e) {
    return false;
  }
}

Future<bool> updateDestination({String destId,String name}) async {
  try {
    await FirebaseFirestore.instance.collection("destinations").doc(destId).update({
      "name": name,
    });
    return true;
  } catch (e) {
    return false;
  }
}

Future<bool> deleteDestination({String destId}) async {
  try {
    await FirebaseFirestore.instance.collection("destinations").doc(destId).delete();
    return true;
  } catch (e) {
    return false;
  }
}

