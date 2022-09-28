import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

class MapSc extends StatefulWidget {
  const MapSc({Key key}) : super(key: key);

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<MapSc> {

  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    tilt: 30,
    target: LatLng(0.3476, 32.5825),
    zoom: 15.4746,
  );

  LatLng startLocation = LatLng(0.3476, 32.5825);

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  LayoutBuilder(
        builder: (ctx, constraints) {
          return Column(
            children: [
              // Container(
              //   height: 50,
              //   width: constraints.maxWidth,
              //   child: TextField(
              //     minLines: 1,
              //     decoration: InputDecoration(
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
              //       // if (p1 != null) {
              //       //   Place _place = await _getPickUpAddressCoordinates(p1.placeId);
              //       //   setState(() {
              //       //     startLocation = LatLng(_place.geometry.location.lat, _place.geometry.location.lng);
              //       //     _coordinatesController.text = "Latitude: " + _place.geometry.location.lat.toString() + "  Longitude: "+  _place.geometry.location.lng.toString();
              //       //     _destController.text = _place.name;
              //       //   });
              //       // }
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
                  markers: Set<Marker>.of(
                    <Marker>[
                      Marker(
                        markerId: MarkerId("destination"),
                        infoWindow: InfoWindow(title: "destination"),
                        icon: BitmapDescriptor.defaultMarkerWithHue(
                            BitmapDescriptor.hueGreen),
                        position: startLocation,
                        draggable: true,
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
}
