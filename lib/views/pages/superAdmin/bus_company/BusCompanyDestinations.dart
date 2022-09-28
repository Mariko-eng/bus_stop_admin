import 'package:bus_stop_develop_admin/models/busCompany.dart';
import 'package:bus_stop_develop_admin/models/parksLocations.dart';
import 'package:bus_stop_develop_admin/views/pages/superAdmin/bus_company/BusCompanyDestinationsMapView.dart';
import 'package:bus_stop_develop_admin/views/pages/superAdmin/bus_company/BusCompanyDestinationsNew.dart';
import 'package:bus_stop_develop_admin/views/pages/superAdmin/bus_company/BusCompanyDestinationsViewEdit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BusCompanyDestinations extends StatefulWidget {
  final BusCompany company;
  const BusCompanyDestinations({Key key,this.company}) : super(key: key);

  @override
  _BusCompanyDestinationsState createState() => _BusCompanyDestinationsState();
}

class _BusCompanyDestinationsState extends State<BusCompanyDestinations> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color(0xfffdfdfd),
          elevation: 0,
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: SizedBox(
                width: 20,height: 25,
                child: Image.asset('assets/images/back_arrow.png',)),
          ),
          title:
          Text(widget.company.name + " Destinations".toUpperCase(),
            style: TextStyle(color: Colors.red[900]),)
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red[900],
          onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BusCompanyDestinationsNew(company: widget.company,)));
          },
          child: Icon(Icons.add_box)
      ),
      body: StreamBuilder(
        stream: getBusCompanyDestinations(companyId: widget.company.uid),
        builder: (context, snapshot){
          if(snapshot.hasError){
            if (kDebugMode) {
              print(snapshot.error);
            }
          }
          if(snapshot.hasData){
            List<ParkLocations> data = snapshot.data;
            if(data.isEmpty){
              return const Center(
                child: Text("No Destination Yet!",
                style: TextStyle(color: Colors.red),
                ),
              );
            }
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, int index){
                    return ListTile(
                      onTap: (){
                        _openBottomSheet(parkLocation:data[index]);
                      },
                      leading: const Icon(Icons.arrow_right_sharp),
                      title: Text(data[index].destinationName),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(data[index].parkLocationName),
                          Text(
                            "(" + data[index].positionLat.toString() + " , " + data[index].positionLng.toString() + ")"
                          )
                        ],
                      ),
                    );
                  }),
            );
          }else{
            // print("Here2");
            return Container();
          }
        },
      ),
    );
  }

  void _openBottomSheet({ ParkLocations parkLocation }) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return _getDestOptions(parkLocation: parkLocation);
        });
  }

  Widget _getDestOptions({ ParkLocations parkLocation }) {
    final options = [
      "Go To Map",
      "View/Edit Destination/Parks",
    ];
    return Container(
      height: 140,
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      color: Colors.white,
      child: ListView(
        children: options
            .map((option) => ListTile(
          onTap: () => {
            if(option == "Go To Map"){
              Navigator.of(context).pop(),
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BusCompanyDestinationsMapView(
                        data: parkLocation,
                      )
                  ))
            },
            if(option == "View/Edit Destination/Parks"){
              Navigator.of(context).pop(),
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          BusCompanyDestinationsViewEdit(
                            company: widget.company,
                            data: parkLocation,
                          )
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
