import 'package:bus_stop_develop_admin/models/ticket.dart';
import 'package:bus_stop_develop_admin/models/user.dart';
import 'package:bus_stop_develop_admin/views/pages/busAdmin/TicketTile.dart';
import 'package:bus_stop_develop_admin/views/shared/loading.dart';
import 'package:flutter/material.dart';

class TicketNumberVerify extends StatefulWidget {
  final AdminUserModel user;
  const TicketNumberVerify({Key key,this.user}) : super(key: key);

  @override
  _TicketNumberVerifyState createState() => _TicketNumberVerifyState();
}

class _TicketNumberVerifyState extends State<TicketNumberVerify> {
  final TextEditingController _searchCtr = TextEditingController();

  TripTicket tripTicket;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffdfdfd),
      appBar: AppBar(
        backgroundColor: Color(0xfffdfdfd),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Enter Ticket Number",
          style: TextStyle(color: Color(0xffE4181D)),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
              width: 20,
              height: 25,
              child: Image.asset(
                'assets/images/back_arrow.png',
              )),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10,),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                      height: 50,
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: TextField(
                        controller: _searchCtr,
                        decoration:  InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40),
                              borderSide: const BorderSide(
                                color: Colors.red
                              )
                            ),
                            prefixIcon: const Icon(
                              Icons.search,
                              color: Colors.blueGrey,
                            ),
                            labelText: "Enter Ticket Number"),
                      ),
                    ),
                    GestureDetector(
                    onTap: () async{
                      if(_searchCtr.text.trim().length > 4){
                        TripTicket res = await searchTicketByNumber(ticketNumber: _searchCtr.text.trim());
                        setState(() {
                          tripTicket = res;
                        });
                      }
                    },
                      child: Container(
                        height: 50,
                        width: 60,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Text("Search",style: TextStyle(color: Colors.white),),
                      ),
                    )
                  ],
                ),
              ),
              tripTicket == null ?
              Container(
                margin: EdgeInsets.only(top: 10),
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child: Text("No Ticket!, Search Again",
                style: TextStyle(color: Colors.red[900]),
                ),
              ) :
              FutureBuilder(
                future: tripTicket.setTripData(context),
                // ignore: missing_return
                builder: (context, snapshot) {
                  TripTicket ticket = snapshot.data;
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                        return const Loading();
                      return Container();
                    case ConnectionState.none:
                      return const Text(
                        'No Ticket',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color(0xFFE4191D), fontSize: 20.0),
                      );
                    case ConnectionState.active:
                      return const Text('Searching... ');
                    case ConnectionState.done:
                      return TicketTile(
                          user: widget.user, tripTicket: ticket);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
