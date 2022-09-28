import 'package:bus_stop_develop_admin/models/trip.dart';
import 'package:bus_stop_develop_admin/models/user.dart';
import 'package:bus_stop_develop_admin/views/pages/busAdmin/BusTripsTickets.dart';
import 'package:bus_stop_develop_admin/views/pages/busAdmin/TripsViewEdit.dart';
import 'package:bus_stop_develop_admin/views/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BusTripsActive extends StatefulWidget {
  final AdminUserModel user;
  const BusTripsActive({Key key,this.user}) : super(key: key);

  @override
  _BusTripsActiveState createState() => _BusTripsActiveState();
}

class _BusTripsActiveState extends State<BusTripsActive> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: getActiveTripsForBusCompany(companyId: widget.user.uid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
          }
          if (snapshot.hasData) {
            List<Trip> trips = snapshot.data;
            if (trips.isEmpty) {
              return Center(
                child: Text(
                  "No Available Trips!".toUpperCase(),
                  style: const TextStyle(color: Color(0xff62020a)),
                ),
              );
            }
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5),
                          child: Card(
                            child: ListTile(
                              onTap: () {
                                _openBottomSheet(trip: trip);
                              },
                              leading: trip.tripType == "Ordinary" ? Text(
                                  trip.price.toString() + " SHS") :
                                  Column(
                                    children: [
                                      Text(
                                          trip.priceOrdinary.toString() + " SHS"),
                                      Text(
                                          trip.priceVip.toString() + " SHS",
                                      style: TextStyle(
                                        color: Colors.blue[900]
                                      ),
                                      )
                                    ],
                                  ),
                              title: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(trip.departure['name'],
                                      style: TextStyle(fontSize: 14,color: Colors.green),
                                      ),
                                      Icon(Icons.arrow_right_alt,color: Colors.red,),
                                      Text(trip.arrival['name'],
                                          style: TextStyle(fontSize: 14,color: Color(0xff62020a))
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text("(",
                                      style: TextStyle(fontSize: 12),
                                      ),
                                      Text(
                                          dateToStringNew(trip.departureTime) + "/" +
                                        dateToTime(trip.departureTime),
                                      style: TextStyle(
                                        fontSize: 10,
                                          color: Colors.green),
                                      ),
                                      Icon(Icons.arrow_right_alt,color: Colors.red,),
                                      Text(dateToTime(trip.arrivalTime),
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xff62020a)),
                                      ),
                                      const Text(")",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              trailing:
                              trip.tripType == "Ordinary" ?
                              Text(trip.tripType.toString()) :
                              const Text("Ord-X-VIP"),
                            ),
                          ),
                        );
                    }
                  },
                ));
          }
          return Container();
        });
  }

  void _openBottomSheet({ Trip trip }) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return _getDestOptions(trip: trip);
        });
  }

  Widget _getDestOptions({ Trip trip }) {
    final options = [
      "View Tickets",
      "View/Edit Trip",
    ];
    return Container(
      height: 200,
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      color: Colors.white,
      child: ListView(
        children: options
            .map((option) => ListTile(
          onTap: () => {
            if(option == "View Tickets"){
              Navigator.of(context).pop(),
              Get.to(() => BusCompanyTripsTickets(
                user: widget.user,
                trip: trip,
              ))
            },
            if(option == "View/Edit Trip"){
              Navigator.of(context).pop(),
            Get.to(() => TripsViewEdit(
              user: widget.user,
              trip: trip,
            ))
            },
          },
          title: Column(
            children: [
              Text(
                option,
                textAlign: TextAlign.start,
                style: TextStyle(color: Color(0xFFE4191D)),
              ),
              SizedBox(height: 4),
              Divider(height: 1)
            ],
          ),
        ))
            .toList(),
      ),
    );
  }
}
