// import 'package:bus_stop_develop_admin/models/user.dart';
// import 'package:bus_stop_develop_admin/views/pages/busAdmin/BusCompanyProfile.dart';
// import 'package:bus_stop_develop_admin/views/pages/busAdmin/BusParkLocations.dart';
// import 'package:bus_stop_develop_admin/views/pages/busAdmin/TicketNumberVerify.dart';
// import 'package:bus_stop_develop_admin/views/pages/busAdmin/TicketScanVerify.dart';
// import 'package:bus_stop_develop_admin/views/pages/busAdmin/TicketsList.dart';
// import 'package:bus_stop_develop_admin/views/pages/busAdmin/TripNew.dart';
// import 'package:bus_stop_develop_admin/views/pages/busAdmin/TripsList.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class DashboardBusAdmin extends StatefulWidget {
//   final AdminUserModel user;
//   const DashboardBusAdmin({Key key, this.user}) : super(key: key);
//
//   @override
//   _DashboardBusAdminState createState() => _DashboardBusAdminState();
// }
//
// class _DashboardBusAdminState extends State<DashboardBusAdmin> {
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(80),
//         child: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     GestureDetector(
//                     onTap: (){
//                       FirebaseAuth.instance.signOut();
//                     },
//                       child: const Icon(
//                         Icons.menu,
//                         color: Colors.red,
//                         size: 40,
//                       ),
//                     ),
//                     SizedBox(
//                       width: 40,
//                         height: 40,
//                         child: Image.asset('assets/images/image6.png'))
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [Text(widget.user.name.toUpperCase())],
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 width: MediaQuery.of(context).size.width,
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: GestureDetector(
//                         onTap: () {
//                           Get.to(() => TripList(user: widget.user,));
//                         },
//                         child: Container(
//                           height: 150,
//                           alignment: Alignment.center,
//                           decoration: BoxDecoration(
//                               color: Colors.red,
//                               borderRadius: BorderRadius.circular(10)),
//                           child: const Text(
//                             "Trips",
//                             style: TextStyle(color: Colors.white70),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       width: 5,
//                     ),
//                     Expanded(
//                       child: GestureDetector(
//                       onTap: (){
//                         Get.to(() => MyBusCompanyTickets(user: widget.user,));
//                       },
//                         child: Container(
//                           height: 150,
//                           alignment: Alignment.center,
//                           decoration: BoxDecoration(
//                               color: Colors.red,
//                               borderRadius: BorderRadius.circular(10)),
//                           child: Text(
//                             "Tickets",
//                             style: TextStyle(color: Colors.white70),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Column(
//                 children: [
//                   Container(
//                     height: 50,
//                     padding: EdgeInsets.all(8.0),
//                     decoration: BoxDecoration(
//                         color: Colors.grey[200],
//                         borderRadius: BorderRadius.circular(10)),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: const [
//                         Text(
//                           "Actions",
//                           style: TextStyle(color: Colors.red),
//                         ),
//                         Icon(
//                           Icons.arrow_drop_down_circle_outlined,
//                           color: Colors.red,
//                         )
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   GestureDetector(
//                     onTap: (){
//                       Get.to(() => TicketNumberVerify(
//                         user: widget.user,
//                       ));
//                     },
//                     child: Row(
//                       children: const [
//                         Icon(
//                           Icons.arrow_right,
//                           size: 10,
//                         ),
//                         SizedBox(
//                           width: 10,
//                         ),
//                         Text("Verify Ticket Number"),
//                         Icon(
//                           Icons.check,
//                           color: Colors.red,
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 5,
//                   ),
//                   GestureDetector(
//                     onTap: (){
//                       Get.to(() => TicketScanVerify(
//                         user: widget.user,
//                       ));
//                     },
//                     child: Row(
//                       children: const [
//                         Icon(
//                           Icons.arrow_right,
//                           size: 10,
//                         ),
//                         SizedBox(
//                           width: 10,
//                         ),
//                         Text("Scan Ticket Card"),
//                         Icon(
//                           Icons.receipt,
//                           color: Colors.red,
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 5,
//                   ),
//                   GestureDetector(
//                     onTap: (){
//                       Get.to(() => TripNew(
//                         user: widget.user,
//                         isOrdinary: true,
//                       ));
//                     },
//                     child: Row(
//                       children: const [
//                         Icon(
//                           Icons.arrow_right,
//                           size: 10,
//                         ),
//                         SizedBox(
//                           width: 10,
//                         ),
//                         Text("Add Trips"),
//                         Text(
//                           "(Ordinary)",
//                           style: TextStyle(color: Color(0xff62020a)),
//                         ),
//                         Icon(
//                           Icons.add,
//                           color: Colors.red,
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   GestureDetector(
//                     onTap: (){
//                       Get.to(() => TripNew(
//                         user: widget.user,
//                         isOrdinary: false,
//                       ));
//                     },
//                     child: Row(
//                       children: const [
//                         Icon(
//                           Icons.arrow_right,
//                           size: 10,
//                         ),
//                         SizedBox(
//                           width: 10,
//                         ),
//                         Text("Add Trips"),
//                         Text(
//                           "(VIP)",
//                           style: TextStyle(color: Color(0xff62020a)),
//                         ),
//                         Icon(
//                           Icons.add,
//                           color: Colors.red,
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   GestureDetector(
//                     onTap: (){
//                       Get.to(() => BusParkLocations(user: widget.user,));
//                     },
//                     child: Row(
//                       children: const [
//                         Icon(
//                           Icons.arrow_right,
//                           size: 10,
//                         ),
//                         SizedBox(
//                           width: 10,
//                         ),
//                         Text("Add Destinations/Bus Parks"),
//                         Icon(
//                           Icons.add,
//                           color: Colors.red,
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 5,
//                   ),
//                   Row(
//                     children: const [
//                       Icon(
//                         Icons.arrow_right,
//                         size: 10,
//                       ),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Text("View Notifications"),
//                       Icon(
//                         Icons.notifications,
//                         color: Colors.red,
//                       ),
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 5,
//                   ),
//                   GestureDetector(
//                   onTap: (){
//                     Get.to(() => BusCompanyProfile(user: widget.user,));
//                   },
//                     child: Row(
//                       children: const [
//                         Icon(
//                           Icons.arrow_right,
//                           size: 10,
//                         ),
//                         SizedBox(
//                           width: 10,
//                         ),
//                         Text("Company Support/Help Lines"),
//                         Icon(
//                           Icons.phone,
//                           color: Colors.red,
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 5,
//                   ),
//                   Row(
//                     children: const [
//                       Icon(
//                         Icons.arrow_right,
//                         size: 10,
//                       ),
//                       SizedBox(
//                         width: 10,
//                       ),
//                       Text("Ask For Help"),
//                       Icon(
//                         Icons.help,
//                         color: Colors.red,
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               SizedBox(height: 10),
//               Container(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       height: 50,
//                       padding: EdgeInsets.all(8.0),
//                       decoration: BoxDecoration(
//                           color: Colors.grey[200],
//                           borderRadius: BorderRadius.circular(10)),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: const [
//                           Text(
//                             "Latest Trips",
//                             style: TextStyle(color: Colors.red),
//                           ),
//                           Icon(
//                             Icons.arrow_drop_down_circle_outlined,
//                             color: Colors.red,
//                           )
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 10),
//                       child: Column(
//                         children: [
//                           Text(
//                             "None yet!",
//                             style: TextStyle(color: Colors.grey),
//                           ),
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               SizedBox(height: 20),
//               Container(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       height: 50,
//                       padding: EdgeInsets.all(8.0),
//                       decoration: BoxDecoration(
//                           color: Colors.grey[200],
//                           borderRadius: BorderRadius.circular(10)),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             "Latest Tickets",
//                             style: TextStyle(color: Colors.red),
//                           ),
//                           Icon(
//                             Icons.arrow_drop_down_circle_outlined,
//                             color: Colors.red,
//                           )
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 10),
//                       child: Column(
//                         children: [
//                           Text(
//                             "None yet!",
//                             style: TextStyle(color: Colors.grey),
//                           ),
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:bus_stop_develop_admin/models/user.dart';
import 'package:bus_stop_develop_admin/views/pages/HomeBusAdmin.dart';
import 'package:bus_stop_develop_admin/views/pages/busAdmin/main/BusCompanyProfile.dart';
import 'package:bus_stop_develop_admin/views/pages/busAdmin/main/Notifications.dart';
import 'package:bus_stop_develop_admin/views/pages/busAdmin/main/TicketScanVerify.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DashboardBusAdmin extends StatefulWidget {
  final AdminUserModel user;
  const DashboardBusAdmin({Key key, this.user}) : super(key: key);

  @override
  _DashboardAdminState createState() => _DashboardAdminState();
}

class _DashboardAdminState extends State<DashboardBusAdmin> {
  int selectedIndex = 0;

  _setSelectedIndex(int index){
    setState(() {
      selectedIndex = index;
    });
  }

  final List<Widget> _widgets = [];

  @override
  void initState() {
    super.initState();
    _widgets.add(HomeBusAdmin(user: widget.user,));
    _widgets.add(TicketScanVerify(user: widget.user,));
    _widgets.add(BusCompanyNotifications(user: widget.user,));
    _widgets.add(BusCompanyProfile(user: widget.user,));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffeecea),
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                color: Colors.white,
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width:55,height:45,
                            child: Image.asset("assets/images/image6.png")),
                        Text(widget.user.name.toUpperCase(),
                          style: TextStyle(
                              color: Color(0xff62020a)
                          ),
                        )
                      ],
                    ),
                    GestureDetector(
                    onTap: (){
                      FirebaseAuth.instance.signOut();
                    },
                      child: Row(
                        children: [
                          Icon(Icons.logout,
                              color: Colors.yellow[900]
                          ),
                          Text("Logout",
                          style: TextStyle(
                            color: Colors.yellow[900]
                          ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                      horizontal: 10),
                  child: _widgets[selectedIndex],
                  // child: HomeBusAdmin(
                  //   user: widget.user,
                  // ),
                ),
                // child: ListView(
                //   children: [
                //
                //   ],
                // ),
              ),
            ],
          ),
        )
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: const Color(0xfffeecea),
        color: const Color(0xff62020a),
        onTap: _setSelectedIndex,
        items: [
          Icon(
            Icons.home,
            color: Colors.yellow[100],
          ),
          Icon(
            Icons.qr_code_scanner,
            color: Colors.yellow[100],
          ),
          Icon(
            Icons.notifications,
            color: Colors.yellow[100],
          ),
          Icon(
            Icons.settings,
            color: Colors.yellow[100],
          ),
        ],
      ),
    );
  }
}