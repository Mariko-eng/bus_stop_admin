// import 'package:bus_stop_develop_admin/models/trip.dart';
// import 'package:bus_stop_develop_admin/models/user.dart';
// import 'package:bus_stop_develop_admin/views/pages/busAdmin/TripNew.dart';
// import 'package:bus_stop_develop_admin/views/pages/busAdmin/TripsViewEdit.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class TripList extends StatefulWidget {
//   final AdminUserModel user;
//
//   const TripList({Key key, this.user}) : super(key: key);
//
//   @override
//   _TripListState createState() => _TripListState();
// }
//
// class _TripListState extends State<TripList> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           elevation: 0,
//           backgroundColor: Colors.grey[200],
//           iconTheme: IconThemeData(color: Color(0xff62020a)),
//           title: const Text(
//             "My Trips",
//             style: TextStyle(color: Color(0xff62020a)),
//           )),
//       floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
//       floatingActionButton: FloatingActionButton(
//           backgroundColor: Colors.red[900],
//           onPressed: (){
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => TripNew(user: widget.user,)));
//           },
//           child: Icon(Icons.add_box)
//       ),
//       body: StreamBuilder(
//         stream: getAllTripsForBusCompany(companyId: widget.user.uid),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             print(snapshot.error);
//           }
//           if (snapshot.hasData) {
//             List<Trip> trips = snapshot.data;
//             if (trips.isEmpty) {
//               return Center(
//                 child: Text(
//                   "No Available Trips!".toUpperCase(),
//                   style: const TextStyle(color: Color(0xff62020a)),
//                 ),
//               );
//             }
//             return ListView.builder(
//                 itemCount: trips.length,
//                 itemBuilder: (context, int index) => FutureBuilder(
//                       future: trips[index].setCompanyData(context),
//                       // ignore: missing_return
//                       builder: (context, snapshot) {
//                         Trip trip = snapshot.data;
//                         switch (snapshot.connectionState) {
//                           case ConnectionState.waiting:
//                             if (index == 0) {
//                               return Container();
//                             }
//                             return Container();
//                           case ConnectionState.none:
//                             return Container();
//                           case ConnectionState.active:
//                             return Text('Searching... ');
//                           case ConnectionState.done:
//                             return trip == null
//                                 ? Container()
//                                 : Padding(
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 5, vertical: 5),
//                                     child: Card(
//                                       child: ListTile(
//                                         onTap: () {
//                                           Get.to(() => TripsViewEdit(
//                                                 user: widget.user,
//                                                 trip: trip,
//                                               ));
//                                         },
//                                         leading: Text(
//                                             trip.price.toString() + " SHS"),
//                                         title: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Row(
//                                               children: [
//                                                 Container(
//                                                     width: 50,
//                                                     child: Text("From :",
//                                                         style: TextStyle(
//                                                             fontSize: 10,
//                                                             color:
//                                                                 Colors.red))),
//                                                 Text(trip.departure['name']),
//                                               ],
//                                             ),
//                                             Row(
//                                               children: [
//                                                 Container(
//                                                     width: 50,
//                                                     child: Text("To :",
//                                                         style: TextStyle(
//                                                             fontSize: 10,
//                                                             color:
//                                                                 Colors.red))),
//                                                 Text(trip.arrival['name']),
//                                               ],
//                                             )
//                                           ],
//                                         ),
//                                         trailing:
//                                             Text(trip.ticketType.toString()),
//                                       ),
//                                     ),
//                                   );
//                         }
//                       },
//                     ));
//           }
//           return Container();
//         },
//       ),
//     );
//   }
// }
