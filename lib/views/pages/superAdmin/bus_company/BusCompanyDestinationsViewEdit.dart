import 'dart:async';
import 'package:bus_stop_develop_admin/models/busCompany.dart';
import 'package:bus_stop_develop_admin/models/destination.dart';
import 'package:bus_stop_develop_admin/models/parksLocations.dart';
import 'package:bus_stop_develop_admin/views/pages/superAdmin/bus_company/BusCompanyDestinationsMapNew.dart';
import 'package:bus_stop_develop_admin/views/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BusCompanyDestinationsViewEdit extends StatefulWidget {
  final ParkLocations data;
  final BusCompany company;

  const BusCompanyDestinationsViewEdit({Key key, this.company,this.data}) : super(key: key);

  @override
  _BusCompanyDestinationsViewEditState createState() =>
      _BusCompanyDestinationsViewEditState();
}

class _BusCompanyDestinationsViewEditState extends State<BusCompanyDestinationsViewEdit> {
  final _destController = TextEditingController();
  final _destIdController = TextEditingController();
  final _parkNameController = TextEditingController();
  final _coordinatesController = TextEditingController();

  LatLng packCoordinates;

  getXC (LatLng value){
    setState(() {
      packCoordinates = value;
      _coordinatesController.text = "(" + value.latitude.toString() +"  ,  "+ value.longitude.toString() + ")";
    });
  }

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      _destController.text= widget.data.destinationName;
      _destIdController.text= widget.data.destinationId;
      _parkNameController.text= widget.data.parkLocationName;
      _coordinatesController.text = "("
          + widget.data.positionLat.toString()
          +"  ,  "
          + widget.data.positionLng.toString() + ")";

    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Scaffold(
      body: Loading(),
    )
        : Scaffold(
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.grey[200],
            iconTheme: IconThemeData(color: Color(0xff62020a)),
            title: const Text(
              "Edit Destination/Park",
              style: TextStyle(color: Color(0xff62020a)),
            )),
        body: FutureBuilder(
          future: getDestinations(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
            }
            if (snapshot.hasData) {
              List<Destination> destinations = snapshot.data;
              // print(destinations);
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFieldContainer(
                        child: TextField(
                          controller: _destController,
                          readOnly: true,
                          style: const TextStyle(fontSize: 20),
                          cursorColor: Colors.red,
                          decoration: const InputDecoration(
                            icon: Icon(
                              Icons.location_history_sharp,
                              color: Color(0xff62020a),
                            ),
                            hintText: "Destination",
                            border: InputBorder.none,
                          ),
                          onTap: () {
                            showDestinations(context, destinations);
                          },
                        ),
                      ),
                      TextFieldContainer(
                        child: TextField(
                          controller: _parkNameController,
                          readOnly: false,
                          style: const TextStyle(fontSize: 20),
                          cursorColor: Colors.red,
                          decoration: const InputDecoration(
                            icon: Icon(
                              Icons.location_history,
                              color: Color(0xff62020a),
                            ),
                            hintText: "Park Name",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      TextFieldContainer(
                        child: TextField(
                          controller: _coordinatesController,
                          readOnly: true,
                          style: const TextStyle(fontSize: 12),
                          cursorColor: Colors.red,
                          decoration: const InputDecoration(
                            icon: Icon(
                              Icons.location_history_sharp,
                              color: Color(0xff62020a),
                            ),
                            hintText: "Choose Park Coordinates",
                            border: InputBorder.none,
                          ),
                          onTap: () {
                            Get.to(() => BusCompanyDestinationsMapNew(
                              getCoordinates: getXC,
                            ));
                            // showMap(context);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        child: GestureDetector(
                          child: Container(
                              alignment: Alignment.center,
                              height: 62,
                              decoration: BoxDecoration(
                                  color: Colors.green[900],
                                  borderRadius:
                                  BorderRadius.circular(20.0)),
                              child: const Text(
                                "Update Destination/Park",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              )),
                        ),
                      ),
                      const SizedBox(height: 5,),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        child: GestureDetector(
                          child: Container(
                              alignment: Alignment.center,
                              height: 62,
                              decoration: BoxDecoration(
                                  color: Colors.red[900],
                                  borderRadius:
                                  BorderRadius.circular(20.0)),
                              child: const Text(
                                "Delete Destination/Park",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
        ));
  }

  Future<void> showDestinations(
      BuildContext context, List<Destination> data) async {
    List sr = [];
    return await showDialog(
        context: context,
        builder: (context) {
          final TextEditingController _ctr = TextEditingController();
          return StatefulBuilder(
              builder: (context, setState) => AlertDialog(
                content: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: LayoutBuilder(
                    builder: (ctx, constraints) {
                      return Column(
                        children: [
                          Container(
                            height: 50,
                            width: constraints.maxWidth,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                    child: TextField(
                                      decoration: const InputDecoration(
                                          hintText: "Search Here",
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.red)),
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.red))),
                                      controller: _ctr,
                                      onChanged: (val) {
                                        List l = [];
                                        setState(() {
                                          if (_ctr.text.isNotEmpty) {
                                            // data.add(_ctr.text);
                                            for (int i = 0;
                                            i < data.length;
                                            i++) {
                                              if (data[i]
                                                  .name
                                                  .toLowerCase()
                                                  .contains(_ctr.text
                                                  .toLowerCase())) {
                                                l.add(data[i]);
                                              }
                                            }
                                            sr = l;
                                            // print(l);
                                          } else {
                                            sr = l;
                                          }
                                        });
                                      },
                                    )),
                                const Icon(Icons.search)
                              ],
                            ),
                          ),
                          Container(
                              height: constraints.maxHeight * 0.8,
                              width: constraints.maxWidth,
                              color: Colors.grey[200],
                              padding:
                              const EdgeInsets.symmetric(horizontal: 5),
                              child: sr.isNotEmpty
                                  ? ListView.builder(
                                  itemCount: sr.length,
                                  itemBuilder: (context1, int i) =>
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _destController.text =
                                                sr[i].name;
                                            _destIdController.text =
                                                sr[i].id;
                                          });
                                          Navigator.of(context).pop();
                                        },
                                        child: Row(
                                          children: [
                                            const Icon(
                                                Icons.arrow_right),
                                            Text(sr[i].name),
                                          ],
                                        ),
                                      ))
                                  : ListView.builder(
                                  itemCount: data.length,
                                  itemBuilder: (context1, int i) =>
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _destController.text =
                                                data[i].name;
                                            _destIdController.text =
                                                data[i].id;
                                          });
                                          Navigator.of(context).pop();
                                        },
                                        child: Row(
                                          children: [
                                            const Icon(
                                                Icons.arrow_right),
                                            Text(data[i].name),
                                          ],
                                        ),
                                      ))),
                        ],
                      );
                    },
                  ),
                ),
                actions: [],
              ));
        });
  }
}

class TextFieldContainer extends StatelessWidget {
  final Widget child;

  const TextFieldContainer({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      width: size.width * 0.9,
      height: 60,
      decoration: BoxDecoration(
        color: const Color(0xffe5e5e5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}

