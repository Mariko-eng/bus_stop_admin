import 'package:bus_stop_develop_admin/models/busCompany.dart';
import 'package:bus_stop_develop_admin/views/pages/superAdmin/bus_company/BusCompanyDestinations.dart';
import 'package:bus_stop_develop_admin/views/pages/superAdmin/bus_company/BusCompanyNew.dart';
import 'package:bus_stop_develop_admin/views/pages/superAdmin/bus_company/BusCompanyTrips.dart';
import 'package:bus_stop_develop_admin/views/pages/superAdmin/bus_company/BuscompanyTickets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BusCompanyList extends StatefulWidget {
  const BusCompanyList({Key key}) : super(key: key);

  @override
  _BusCompanyListState createState() => _BusCompanyListState();
}

class _BusCompanyListState extends State<BusCompanyList> {

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
          Text("All Bus Companies".toUpperCase(),
            style: TextStyle(color: Colors.red[900]),)
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red[900],
          onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const BusCompanyNew()));
          },
          child: Icon(Icons.add_box)
      ),
      body: StreamBuilder(
        stream: getAllBusCompanies(),
        builder: (context, snapshot){
          if(snapshot.hasError){
            if (kDebugMode) {
              print(snapshot.error);
            }
          }
          if(snapshot.hasData){
            List<BusCompany> data = snapshot.data;
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, int index){
                    return ListTile(
                      onTap: (){
                        _openBottomSheet( company: data[index]);
                      },
                      leading: const Icon(Icons.arrow_right_sharp),
                      title: Text(data[index].name),
                    );
                  }),
            );
          }else{
            return Container();
          }
        },
      ),
    );
  }

  void _openBottomSheet({ BusCompany company }) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return _getTicketOptions(company: company);
        });
  }

  Widget _getTicketOptions({ BusCompany company }) {
    final options = [
      "View Bus Trips",
      "View Bus Tickets",
      "View/Edit Destinations",
      "View/Edit Bus Company"
    ];
    return Container(
      height: 250,
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      color: Colors.white,
      child: ListView(
        children: options
            .map((option) => ListTile(
          onTap: () => {
            if(option == "View Bus Trips"){
              Navigator.of(context).pop(),
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BusCompanyTrips(
                        company: company,
                      )
                  ))
            },
            if(option == "View Bus Tickets"){
              Navigator.of(context).pop(),
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                      BusCompanyTickets(company: company,)
                  ))
            },
            if(option == "View/Edit Destinations"){
              Navigator.of(context).pop(),
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BusCompanyDestinations(
                        company: company,
                      )))
            }
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
