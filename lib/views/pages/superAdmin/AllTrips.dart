import 'package:bus_stop_develop_admin/models/trip.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AllTrips extends StatefulWidget {
  const AllTrips({Key key}) : super(key: key);

  @override
  _TripsState createState() => _TripsState();
}

class _TripsState extends State<AllTrips> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Trips"),
      ),
      body: StreamBuilder(
        stream: allTrips,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            if (kDebugMode) {
              print(snapshot.error);
            }
          }
          if (snapshot.hasData) {
            List<Trip> trips = snapshot.data;
            return ListView.builder(
                itemCount: trips.length,
                itemBuilder: (context, int index) => FutureBuilder(
                  future: trips[index].setCompanyData(context),
                  // ignore: missing_return
                  builder: (context, snapshot) {
                    Trip trip = snapshot.data;
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        if (index == 0) {
                          return Container();
                        }
                        return Container();
                      case ConnectionState.none:
                        return Container();
                      case ConnectionState.active:
                        return Text('Searching... ');
                      case ConnectionState.done:
                        return trip == null
                            ? Container()
                            : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                          child: Card(
                            child: ListTile(
                              leading: Text(trip.price.toString() + " SHS"),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(trip.companyData['name'],style:TextStyle(fontSize: 10,color: Colors.blue[900])),
                                  Row(
                                    children: [
                                      Container(
                                          width: 50,
                                          child: Text("From :", style:TextStyle(fontSize: 10,color: Colors.red))),
                                      Text(trip.departure['name']),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                          width: 50,
                                          child: Text("To :", style:TextStyle(fontSize: 10, color: Colors.red))),
                                      Text(trip.arrival['name']),
                                    ],
                                  )
                                ],
                              ),
                              trailing: Text(trip.tripType.toString()),
                            ),
                          ),
                        );
                    }
                  },
                ));
          }
          return Container();
        },
      ),
    );
  }
}
