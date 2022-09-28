import 'dart:async';
import 'package:bus_stop_develop_admin/models/placesModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

class BusCompanyDestinationsMapNew extends StatefulWidget {
  final Function getCoordinates;
  const BusCompanyDestinationsMapNew({Key key,this.getCoordinates}) : super(key: key);

  @override
  _BusCompanyDestinationsMapNewState createState() => _BusCompanyDestinationsMapNewState();
}

class _BusCompanyDestinationsMapNewState extends State<BusCompanyDestinationsMapNew> {
  final Completer<GoogleMapController> _controller = Completer();
  final _destController = TextEditingController();

  static const CameraPosition _kGooglePlex = CameraPosition(
    tilt: 30,
    target: LatLng(0.3476, 32.5825),
    zoom: 15.4746,
  );

  LatLng startLocation = LatLng(0.3476, 32.5825);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Cordinates"),
      ),
      body:  LayoutBuilder(
        builder: (ctx, constraints) {
          return Column(
            children: [
              // Container(
              //   height: 50,
              //   width: constraints.maxWidth,
              //   child: TextField(
              //     controller: _destController,
              //     minLines: 1,
              //     decoration: const InputDecoration(
              //         prefixIcon: Icon(Icons.my_location_sharp),
              //         suffixIcon: Icon(Icons.search_sharp),
              //         labelText: "Pick Up Location",
              //         enabledBorder: OutlineInputBorder(),
              //         focusedBorder: OutlineInputBorder()),
              //     readOnly: true,
              //     onTap: () async {
              //       Prediction p1 = await PlacesAutocomplete.show(
              //           context: context,
              //           apiKey:
              //           "AIzaSyCFrgs8XmPhssP4bMmfyDyrQxcPE7oiQlo",
              //           mode: Mode.overlay,
              //           // Mode.fullscreen
              //           components: [
              //             new Component(Component.country, "ug")
              //           ]);
              //       if (p1 != null) {
              //         Place _place = await _getPickUpAddressCoordinates(p1.placeId);
              //         setState(() {
              //           startLocation = LatLng(_place.geometry.location.lat, _place.geometry.location.lng);
              //           widget.getCoordinates(LatLng(_place.geometry.location.lat, _place.geometry.location.lng));
              //           _destController.text = _place.name;
              //         });
              //         Get.back();
              //       }
              //     },
              //   ),
              // ),
              Container(
                height: constraints.maxHeight * 1.0,
                width: constraints.maxWidth,
                color: Colors.grey[200],
                padding: const EdgeInsets.symmetric(horizontal: 1),
                child: GoogleMap(
                  mapType: MapType.normal,
                  indoorViewEnabled: true,
                  initialCameraPosition: _kGooglePlex,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  onTap: (LatLng val) {
                    print(val.latitude);
                    print(val.longitude);
                    setState(() {
                      startLocation = val;
                      widget.getCoordinates(val);
                      Get.back();
                    });
                  },
                  markers: Set<Marker>.of(
                    <Marker>[
                      Marker(
                        markerId: MarkerId("destination"),
                        infoWindow: InfoWindow(title: "destination"),
                        icon: BitmapDescriptor.defaultMarkerWithHue(
                            BitmapDescriptor.hueGreen),
                        position: startLocation,
                        draggable: true,
                        onDragEnd: (LatLng val) async {
                          print(val.latitude);
                          print(val.longitude);
                          setState(() {
                            startLocation = val;
                          });
                        },
                      ),
                    ],
                  ),

                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<Place> _getPickUpAddressCoordinates(String placeID) async {
    PlacesService _placeService = PlacesService();
    Place address = await _placeService.getPlace(placeID);
    return address;
  }
}

