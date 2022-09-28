import 'package:cloud_firestore/cloud_firestore.dart';

class TripNumbers {
  final String tripId;
  final String tripNumber;
  final String arrivalLocationName;
  final String departureLocationName;

  TripNumbers({this.tripId,
    this.tripNumber,
    this.arrivalLocationName,
    this.departureLocationName,
  });

  factory TripNumbers.fromSnapshot(DocumentSnapshot snap) {
    Map data = snap.data();
    return TripNumbers(
        tripId: snap.id,
        tripNumber: data["tripNumber"],
        arrivalLocationName: data["arrivalLocationName"],
        departureLocationName: data["departureLocationName"],
    );
  }
}


Future<List<TripNumbers>> getAllTripsNumbersForBusCompany({String companyId}) async{
  DateTime now = DateTime.now();
  DateTime yesterday = DateTime(now.year, now.month, now.day - 1, now.hour, now.minute);
  var results = await  FirebaseFirestore.instance.collection('trips')
      .where('companyId', isEqualTo: companyId)
      .where('departureTime', isGreaterThanOrEqualTo: yesterday)
      .orderBy('departureTime').get();
  return results.docs.map((doc) => TripNumbers.fromSnapshot(doc)).toList();

}