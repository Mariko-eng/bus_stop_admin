import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

import 'Notifications.dart';

class Trip {
  final String id;
  final DocumentReference arrivalLocation;
  final DocumentReference departureLocation;
  final DocumentReference company;
  final DateTime departureTime;
  final DateTime arrivalTime;
  final int totalSeats;
  final int occupiedSeats;
  final int price;
  final int totalOrdinarySeats;
  final int occupiedOrdinarySeats;
  final int priceOrdinary;
  final int totalVipSeats;
  final int occupiedVipSeats;
  final int priceVip;
  final String tripNumber;
  final String tripType;
  Map<String, dynamic> companyData;
  Map<String, dynamic> arrival;
  Map<String, dynamic> departure;

  Trip(
      {this.id,
      this.arrivalLocation,
      this.departureLocation,
      this.company,
      this.departureTime,
      this.arrivalTime,
      this.totalSeats,
      this.occupiedSeats,
      this.price,
      this.totalOrdinarySeats,
      this.occupiedOrdinarySeats,
      this.priceOrdinary,
      this.totalVipSeats,
      this.occupiedVipSeats,
      this.priceVip,
      this.tripNumber,
      this.tripType});

  Future<Trip> setCompanyData(BuildContext context) async {
    DocumentSnapshot companySnapshot = await company.get();
    companyData = {'id': companySnapshot.id}..addAll(companySnapshot.data());

    DocumentSnapshot arrivalSnapshot = await arrivalLocation.get();
    arrival = {'id': arrivalSnapshot.id}..addAll(arrivalSnapshot.data());

    DocumentSnapshot departureSnapshot = await departureLocation.get();
    departure = {'id': departureSnapshot.id}..addAll(departureSnapshot.data());

    return this;
  }

  Map<String, dynamic> getCompanyData() {
    return companyData;
  }

  factory Trip.fromSnapshot(DocumentSnapshot snapshot) {
    Map data = snapshot.data();
    return Trip(
        id: snapshot.id,
        arrivalLocation: data['arrivalLocation'],
        departureLocation: data['departureLocation'],
        company: data['company'],
        departureTime: data['departureTime'].toDate(),
        arrivalTime: data['arrivalTime'].toDate(),
        totalSeats: data['totalSeats'],
        occupiedSeats: data['occupiedSeats'],
        price: data['price'],
        totalOrdinarySeats: data['totalOrdinarySeats'],
        occupiedOrdinarySeats: data['occupiedOrdinarySeats'],
        priceOrdinary: data['priceOrdinary'],
        totalVipSeats: data['totalVipSeats'],
        occupiedVipSeats: data['occupiedVipSeats'],
        priceVip: data['priceVip'],
        tripNumber: data['tripNumber'],
        tripType: data['tripType'] ?? "");
  }
}

Future<String> getRandomNumber() async {
  String num1 = randomNumeric(4);
  String num2 = randomNumeric(4);
  String num = "T" + num1 + num2;
  try {
    var res = await FirebaseFirestore.instance
        .collection('trips')
        .where("tripNumber", isEqualTo: num)
        .get();
    if (res.docs.isEmpty) {
      return num;
    } else {
      return getRandomNumber();
    }
  } catch (e) {
    print("Error While Checking For Ticket Number");
    return num;
  }
}

Future addTripOrdinaryOnly(
    {String arrivalLocationName,
    String arrivalLocationId,
    String departureLocationId,
    String departureLocationName,
    String companyId,
    DateTime departureTime,
    DateTime arrivalTime,
    int totalSeats,
    int occupiedSeats = 0,
    int price,
    int totalOrdinarySeats,
    int occupiedOrdinarySeats = 0,
    int priceOrdinary,
    int totalVipSeats = 0,
    int occupiedVipSeats = 0,
    int priceVip,
    String tripType}) async {
  try {
    DocumentSnapshot docArrival = await FirebaseFirestore.instance
        .collection("destinations")
        .doc(arrivalLocationId)
        .get();
    DocumentReference arrivalLocation = docArrival.reference;

    DocumentSnapshot docDeparture = await FirebaseFirestore.instance
        .collection("destinations")
        .doc(departureLocationId)
        .get();
    DocumentReference departureLocation = docDeparture.reference;

    DocumentSnapshot docCompany = await FirebaseFirestore.instance
        .collection("companies")
        .doc(companyId)
        .get();
    DocumentReference company = docCompany.reference;

    String num = await getRandomNumber();

    await FirebaseFirestore.instance.collection('trips').add({
      "arrivalLocation": arrivalLocation,
      "arrivalLocationId": arrivalLocationId,
      "arrivalLocationName": arrivalLocationName,
      "departureLocation": departureLocation,
      "departureLocationId": departureLocationId,
      "departureLocationName": departureLocationName,
      "company": company,
      "companyId": companyId,
      "departureTime": departureTime,
      "arrivalTime": arrivalTime,
      "totalSeats": totalSeats,
      "occupiedSeats": occupiedSeats,
      "price": price,
      "totalOrdinarySeats": totalOrdinarySeats,
      "occupiedOrdinarySeats": occupiedOrdinarySeats,
      "priceOrdinary": priceOrdinary,
      "totalVipSeats": totalVipSeats,
      "occupiedVipSeats": occupiedVipSeats,
      "priceVip": priceVip,
      "tripType": tripType,
      'tripNumber': num,
    });
    await addBusCompanyNotification(
      busCompanyId: companyId,
      title: "New Trip",
      body: departureLocationName.toUpperCase() + " To " + arrivalLocationName.toUpperCase()
    );
    return "success";
  } catch (e) {
    print(e);
    return null;
  }
}

Future addTripOrdinaryAndVIP(
    {String arrivalLocationName,
    String arrivalLocationId,
    String departureLocationId,
    String departureLocationName,
    String companyId,
    DateTime departureTime,
    DateTime arrivalTime,
    int totalSeats,
    int occupiedSeats = 0,
    int totalOrdinarySeats,
    int occupiedOrdinarySeats = 0,
    int totalVipSeats,
    int occupiedVipSeats = 0,
    int price,
    int priceVip,
    int priceOrdinary,
    String tripType}) async {
  try {
    DocumentSnapshot docArrival = await FirebaseFirestore.instance
        .collection("destinations")
        .doc(arrivalLocationId)
        .get();
    DocumentReference arrivalLocation = docArrival.reference;

    DocumentSnapshot docDeparture = await FirebaseFirestore.instance
        .collection("destinations")
        .doc(departureLocationId)
        .get();
    DocumentReference departureLocation = docDeparture.reference;

    DocumentSnapshot docCompany = await FirebaseFirestore.instance
        .collection("companies")
        .doc(companyId)
        .get();
    DocumentReference company = docCompany.reference;

    String num = await getRandomNumber();

    await FirebaseFirestore.instance.collection('trips').add({
      "arrivalLocation": arrivalLocation,
      "arrivalLocationId": arrivalLocationId,
      "arrivalLocationName": arrivalLocationName,
      "departureLocation": departureLocation,
      "departureLocationId": departureLocationId,
      "departureLocationName": departureLocationName,
      "company": company,
      "companyId": companyId,
      "departureTime": departureTime,
      "arrivalTime": arrivalTime,
      "totalSeats": totalSeats,
      "occupiedSeats": occupiedSeats,
      "price": price,
      "totalOrdinarySeats": totalOrdinarySeats,
      "occupiedOrdinarySeats": occupiedOrdinarySeats,
      "priceOrdinary": priceOrdinary,
      "totalVipSeats": totalVipSeats,
      "occupiedVipSeats": occupiedVipSeats,
      "priceVip": priceVip,
      "tripType": tripType,
      'tripNumber': num,
    });
    return "success";
  } catch (e) {
    print(e);
    return null;
  }
}

// Future updateTrip(
//     {String tripId,
//     String arrivalLocationId,
//     String departureLocationId,
//     String companyId,
//     DateTime departureTime,
//     DateTime arrivalTime,
//     int totalSeats,
//     int occupiedSeats = 0,
//     int price,
//     String tripType}) async {
//   try {
//     DocumentSnapshot docArrival = await FirebaseFirestore.instance
//         .collection("destinations")
//         .doc(arrivalLocationId)
//         .get();
//     DocumentReference arrivalLocation = docArrival.reference;
//
//     DocumentSnapshot docDeparture = await FirebaseFirestore.instance
//         .collection("destinations")
//         .doc(departureLocationId)
//         .get();
//     DocumentReference departureLocation = docDeparture.reference;
//
//     DocumentSnapshot docCompany = await FirebaseFirestore.instance
//         .collection("companies")
//         .doc(companyId)
//         .get();
//     DocumentReference company = docCompany.reference;
//
//     await FirebaseFirestore.instance.collection('trips').doc(tripId).update({
//       "arrivalLocation": arrivalLocation,
//       "arrivalLocationId": arrivalLocationId,
//       "departureLocation": departureLocation,
//       "departureLocationId": departureLocationId,
//       "company": company,
//       "companyId": companyId,
//       "departureTime": departureTime,
//       "arrivalTime": arrivalTime,
//       "totalSeats": totalSeats,
//       "occupiedSeats": occupiedSeats,
//       "price": price,
//       "tripType": tripType,
//       "isActive": true
//     });
//   } catch (e) {
//     print(e);
//   }
// }

Future deleteTrip({
  String tripId,
}) async {
  try {
    await FirebaseFirestore.instance.collection('trips').doc(tripId).delete();
  } catch (e) {
    print(e);
  }
}

Stream<List<Trip>> getActiveTripsForBusCompany({String companyId}) {
  DateTime now = DateTime.now();
  DateTime yesterday =
      DateTime(now.year, now.month, now.day - 1, now.hour, now.minute);

  return FirebaseFirestore.instance
      .collection('trips')
      .where('departureTime', isGreaterThanOrEqualTo: yesterday)
      .where('companyId', isEqualTo: companyId)
      .orderBy('departureTime')
      .snapshots()
      .map((snap) {
    return snap.docs.map((doc) => Trip.fromSnapshot(doc)).toList();
  });
}

Stream<List<Trip>> getNonActiveTripsForBusCompany({String companyId}) {
  DateTime now = DateTime.now();
  DateTime yesterday =
      DateTime(now.year, now.month, now.day - 1, now.hour, now.minute);

  return FirebaseFirestore.instance
      .collection('trips')
      .where('departureTime', isLessThanOrEqualTo: yesterday)
      .where('companyId', isEqualTo: companyId)
      .orderBy('departureTime')
      .snapshots()
      .map((snap) {
    return snap.docs.map((doc) => Trip.fromSnapshot(doc)).toList();
  });
}

Stream<List<Trip>> getAllTripsForBusCompany({String companyId}) {
  return FirebaseFirestore.instance
      .collection('trips')
      .where('companyId', isEqualTo: companyId)
      .orderBy('departureTime')
      .snapshots()
      .map((snap) {
    return snap.docs.map((doc) => Trip.fromSnapshot(doc)).toList();
  });
}

Stream<List<Trip>> get activeTrips {
  DateTime now = DateTime.now();
  DateTime yesterday =
      DateTime(now.year, now.month, now.day - 1, now.hour, now.minute);

  return FirebaseFirestore.instance
      .collection('trips')
      .where('departureTime', isGreaterThanOrEqualTo: yesterday)
      .orderBy('departureTime')
      .snapshots()
      .map((snap) {
    return snap.docs.map((doc) => Trip.fromSnapshot(doc)).toList();
  });
}

Stream<List<Trip>> get allTrips {
  return FirebaseFirestore.instance
      .collection('trips')
      .orderBy('departureTime')
      .snapshots()
      .map((snap) {
    return snap.docs.map((doc) => Trip.fromSnapshot(doc)).toList();
  });
}
