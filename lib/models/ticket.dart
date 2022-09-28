import 'package:bus_stop_develop_admin/models/Notifications.dart';
import 'package:bus_stop_develop_admin/models/trip.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final CollectionReference tripsCollection =
    FirebaseFirestore.instance.collection('trips');

class TripTicket {
  final String ticketId;
  final String departureLocation;
  final String arrivalLocation;
  final int numberOfTickets;
  final int total;
  final int amountPaid;
  final String userId;
  final String paymentStatus;
  final bool paymentSuccessFul;
  final String paymentTransactionId;
  final String paymentTxRef;
  final String status;
  final String ticketType;
  final String ticketNumber;
  final DocumentReference tripRef;
  final String tripId;
  Trip trip;
  Timestamp createdAt;

  TripTicket(
      {this.ticketId,
      this.departureLocation,
      this.arrivalLocation,
      this.numberOfTickets,
      this.total,
      this.amountPaid,
      this.ticketType,
      this.ticketNumber,
      this.userId,
      this.status,
      this.paymentStatus,
      this.paymentSuccessFul,
      this.paymentTransactionId,
      this.paymentTxRef,
      this.tripRef,
      this.tripId,
      this.createdAt});

  Future<TripTicket> setTripData(BuildContext context) async {
    DocumentSnapshot snapshot = await tripRef.get();

    trip = Trip(
      id: snapshot.id,
      arrivalLocation: snapshot.get('arrivalLocation'),
      departureLocation: snapshot.get('departureLocation'),
      company: snapshot.get('company'),
      departureTime: snapshot.get('departureTime').toDate(),
      arrivalTime: snapshot.get('arrivalTime').toDate(),
      totalSeats: snapshot.get('totalSeats'),
      occupiedSeats: snapshot.get('occupiedSeats'),
      price: snapshot.get('price'),
      totalOrdinarySeats: snapshot.get('totalOrdinarySeats'),
      occupiedOrdinarySeats: snapshot.get('occupiedOrdinarySeats'),
      priceOrdinary: snapshot.get('priceOrdinary'),
      totalVipSeats: snapshot.get('totalVipSeats'),
      occupiedVipSeats: snapshot.get('occupiedVipSeats'),
      priceVip: snapshot.get('priceVip'),
      tripType: snapshot.get('tripType'),
      tripNumber: snapshot.get('tripNumber'),
    );

    return this;
  }

  factory TripTicket.fromSnapshot(DocumentSnapshot snapshot) {
    Map data = snapshot.data();
    return TripTicket(
        ticketId: snapshot.id,
        departureLocation: data['departureLocation'],
        arrivalLocation: data['arrivalLocation'],
        numberOfTickets: data['numberOfTickets'],
        total: data['total'],
        amountPaid: data['amountPaid'],
        tripRef: data['trip'],
        ticketType: data['ticketType'] ?? "",
        ticketNumber: data['ticketNumber'],
        tripId: data['tripId'],
        userId: data['userId'] ?? "",
        status: data['status'] ?? "",
        paymentStatus: data['paymentStatus'],
        paymentSuccessFul: data['paymentSuccessFul'],
        paymentTransactionId: data['paymentTransactionId'],
        paymentTxRef: data['paymentTxRef'],
        createdAt: data['createdAt']);
  }
}

Stream<List<TripTicket>> getMyBusCompanyTicketsForATrip({String tripId}) {
  return FirebaseFirestore.instance
      .collection("tickets")
      .where("tripId", isEqualTo: tripId)
      .snapshots()
      .map((snap) {
    return snap.docs.map((doc) => TripTicket.fromSnapshot(doc)).toList();
  });
}

Stream<List<TripTicket>> getMyBusCompanyTickets({String companyId}) {
  return FirebaseFirestore.instance
      .collection("tickets")
      .where("companyId", isEqualTo: companyId)
      .snapshots()
      .map((snap) {
    return snap.docs.map((doc) => TripTicket.fromSnapshot(doc)).toList();
  });
}

Stream<List<TripTicket>> getMyBusCompanyActiveTickets(
    {String companyId, String tripId}) {
  if (tripId == "All Tickets") {
    return FirebaseFirestore.instance
        .collection("tickets")
        .where("companyId", isEqualTo: companyId)
        .where("status", isEqualTo: "pending")
        .snapshots()
        .map((snap) {
      return snap.docs.map((doc) => TripTicket.fromSnapshot(doc)).toList();
    });
  } else {
    return FirebaseFirestore.instance
        .collection("tickets")
        .where("companyId", isEqualTo: companyId)
        .where("tripId", isEqualTo: tripId)
        .where("status", isEqualTo: "pending")
        .snapshots()
        .map((snap) {
      return snap.docs.map((doc) => TripTicket.fromSnapshot(doc)).toList();
    });
  }
}

Stream<List<TripTicket>> getMyBusCompanyNonActiveTickets(
    {String companyId, String tripId}) {
  if (tripId == "All Tickets") {
    return FirebaseFirestore.instance
        .collection("tickets")
        .where("companyId", isEqualTo: companyId)
        .where("status", whereIn: ["used", "cancelled"])
        .snapshots()
        .map((snap) {
          return snap.docs.map((doc) => TripTicket.fromSnapshot(doc)).toList();
        });
  } else {
    return FirebaseFirestore.instance
        .collection("tickets")
        .where("companyId", isEqualTo: companyId)
        .where("tripId", isEqualTo: tripId)
        .where("status", whereIn: ["used", "cancelled"])
        .snapshots()
        .map((snap) {
          return snap.docs.map((doc) => TripTicket.fromSnapshot(doc)).toList();
        });
  }
}

Stream<List<TripTicket>> getAllTickets() {
  return FirebaseFirestore.instance
      .collection("tickets")
      .snapshots()
      .map((snap) {
    return snap.docs.map((doc) => TripTicket.fromSnapshot(doc)).toList();
  });
}

Future<TripTicket> searchTicketByNumber({String ticketNumber}) async {
  try {
    var res = await FirebaseFirestore.instance
        .collection("tickets")
        .where("ticketNumber", isEqualTo: ticketNumber)
        .get();
    return TripTicket.fromSnapshot(res.docs.first);
  } catch (e) {
    print(e.toString());
    return null;
  }
}

Future<bool> updateTicketUsed(
    {String ticketId,
    String ticketNo,
    String clientId,
    String companyId}) async {
  try {
    await FirebaseFirestore.instance
        .collection("tickets")
        .doc(ticketId)
        .update({"status": "used"});
    await addClientNotification(
        clientId: clientId,
        busCompanyId: companyId,
        title: "Ticket Update",
        body: "Ticket " + ticketNo + " Has Been Used Successfully");
    return true;
  } catch (e) {
    print(e.toString());
    return false;
  }
}

Future<bool> updateTicketPending({String ticketId}) async {
  try {
    await FirebaseFirestore.instance
        .collection("tickets")
        .doc(ticketId)
        .update({"status": "pending"});
    return true;
  } catch (e) {
    print(e.toString());
    return false;
  }
}

Future<bool> updateTicketCancelled({String ticketId}) async {
  try {
    await FirebaseFirestore.instance
        .collection("tickets")
        .doc(ticketId)
        .update({"status": "cancelled"});
    return true;
  } catch (e) {
    print(e.toString());
    return false;
  }
}

Future<bool> assignTicketToAnotherTrip(
    {String ticketId, Trip trip, int numberOfTickets}) async {
  try {
    await FirebaseFirestore.instance
        .collection("tickets")
        .doc(ticketId)
        .update({
      'trip': tripsCollection.doc(trip.id),
      'tripId': trip.id,
      'departureLocation': trip.departure['name'],
      'arrivalLocation': trip.arrival['name'],
    });

    DocumentReference tripRef = tripsCollection.doc(trip.id);
    await tripRef
        .update({'occupiedSeats': FieldValue.increment(numberOfTickets)});
    return true;
  } catch (e) {
    print(e.toString());
    return false;
  }
}
