import 'package:bus_stop_develop_admin/models/user.dart';
import 'package:bus_stop_develop_admin/views/pages/busAdmin/BusTickets.dart';
import 'package:bus_stop_develop_admin/views/pages/busAdmin/BusTrips.dart';
import 'package:bus_stop_develop_admin/views/pages/busAdmin/BusTripsNewMixed.dart';
import 'package:bus_stop_develop_admin/views/pages/busAdmin/main/BusCompanyProfile.dart';
import 'package:bus_stop_develop_admin/views/pages/busAdmin/BusParkLocations.dart';
import 'package:bus_stop_develop_admin/views/pages/busAdmin/TicketNumberVerify.dart';
import 'package:bus_stop_develop_admin/views/pages/busAdmin/main/TicketScanVerify.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeBusAdmin extends StatefulWidget {
  final AdminUserModel user;
  const HomeBusAdmin({Key key, this.user}) : super(key: key);

  @override
  _HomeBusAdminState createState() => _HomeBusAdminState();
}

class _HomeBusAdminState extends State<HomeBusAdmin> {

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => BusTrips(user: widget.user,));
                  },
                  child: Container(
                    height: 150,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Color(0xff62020a),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Text(
                      "Trips",
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: (){
                    Get.to(() => BusCompanyTickets(user: widget.user,));
                  },
                  child: Container(
                    height: 150,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Color(0xff62020a),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      "Tickets",
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Column(
          children: [
            Container(
              height: 50,
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Actions",
                    style: TextStyle(color: Colors.red),
                  ),
                  Icon(
                    Icons.arrow_drop_down_circle_outlined,
                    color: Colors.red,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            GestureDetector(
              onTap: (){
                Get.to(() => TicketNumberVerify(
                  user: widget.user,
                ));
              },
              child: Row(
                children: const [
                  Icon(
                    Icons.arrow_right,
                    size: 10,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Verify Ticket Number"),
                  Icon(
                    Icons.check,
                    color: Colors.red,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            GestureDetector(
              onTap: (){
                Get.to(() => TicketScanVerify(
                  user: widget.user,
                ));
              },
              child: Row(
                children: const [
                  Icon(
                    Icons.arrow_right,
                    size: 10,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Scan Ticket Card"),
                  Icon(
                    Icons.receipt,
                    color: Colors.red,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            GestureDetector(
              onTap: (){
                Get.to(() => BusTripsNewMixed(
                  user: widget.user,
                ));
              },
              child: Row(
                children: const [
                  Icon(
                    Icons.arrow_right,
                    size: 10,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Add Trips"),
                  Text(
                    "(Ordinary)",
                    style: TextStyle(color: Color(0xff62020a)),
                  ),
                  Icon(
                    Icons.add,
                    color: Colors.red,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            GestureDetector(
              onTap: (){
                Get.to(() => BusTripsNewMixed(
                  user: widget.user,
                ));
              },
              child: Row(
                children: const [
                  Icon(
                    Icons.arrow_right,
                    size: 10,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Add Trips"),
                  Text(
                    "(VIP)",
                    style: TextStyle(color: Color(0xff62020a)),
                  ),
                  Icon(
                    Icons.add,
                    color: Colors.red,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            GestureDetector(
              onTap: (){
                Get.to(() => BusParkLocations(user: widget.user,));
              },
              child: Row(
                children: const [
                  Icon(
                    Icons.arrow_right,
                    size: 10,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Add Destinations/Bus Parks"),
                  Icon(
                    Icons.add,
                    color: Colors.red,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: const [
                Icon(
                  Icons.arrow_right,
                  size: 10,
                ),
                SizedBox(
                  width: 10,
                ),
                Text("View Notifications"),
                Icon(
                  Icons.notifications,
                  color: Colors.red,
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            GestureDetector(
              onTap: (){
                Get.to(() => BusCompanyProfile(user: widget.user,));
              },
              child: Row(
                children: const [
                  Icon(
                    Icons.arrow_right,
                    size: 10,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Company Support/Help Lines"),
                  Icon(
                    Icons.phone,
                    color: Colors.red,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              children: const [
                Icon(
                  Icons.arrow_right,
                  size: 10,
                ),
                SizedBox(
                  width: 10,
                ),
                Text("Ask For Help"),
                Icon(
                  Icons.help,
                  color: Colors.red,
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 10),
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 50,
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Latest Trips",
                      style: TextStyle(color: Colors.red),
                    ),
                    Icon(
                      Icons.arrow_drop_down_circle_outlined,
                      color: Colors.red,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Text(
                      "None yet!",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 20),
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 50,
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Latest Tickets",
                      style: TextStyle(color: Colors.red),
                    ),
                    Icon(
                      Icons.arrow_drop_down_circle_outlined,
                      color: Colors.red,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Text(
                      "None yet!",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );

    // return Scaffold(
    //   appBar: PreferredSize(
    //     preferredSize: const Size.fromHeight(80),
    //     child: SafeArea(
    //       child: Padding(
    //         padding: const EdgeInsets.all(8.0),
    //         child: Column(
    //           children: [
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: [
    //                 GestureDetector(
    //                   onTap: (){
    //                     FirebaseAuth.instance.signOut();
    //                   },
    //                   child: const Icon(
    //                     Icons.menu,
    //                     color: Colors.red,
    //                     size: 40,
    //                   ),
    //                 ),
    //                 SizedBox(
    //                     width: 40,
    //                     height: 40,
    //                     child: Image.asset('assets/images/image6.png'))
    //               ],
    //             ),
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: [Text(widget.user.name.toUpperCase())],
    //             )
    //           ],
    //         ),
    //       ),
    //     ),
    //   ),
    //   body: Padding(
    //     padding: const EdgeInsets.all(8.0),
    //     child: SingleChildScrollView(
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Container(
    //             width: MediaQuery.of(context).size.width,
    //             child: Row(
    //               children: [
    //                 Expanded(
    //                   child: GestureDetector(
    //                     onTap: () {
    //                       Get.to(() => TripList(user: widget.user,));
    //                     },
    //                     child: Container(
    //                       height: 150,
    //                       alignment: Alignment.center,
    //                       decoration: BoxDecoration(
    //                           color: Colors.red,
    //                           borderRadius: BorderRadius.circular(10)),
    //                       child: const Text(
    //                         "Trips",
    //                         style: TextStyle(color: Colors.white70),
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //                 const SizedBox(
    //                   width: 5,
    //                 ),
    //                 Expanded(
    //                   child: GestureDetector(
    //                     onTap: (){
    //                       Get.to(() => MyBusCompanyTickets(user: widget.user,));
    //                     },
    //                     child: Container(
    //                       height: 150,
    //                       alignment: Alignment.center,
    //                       decoration: BoxDecoration(
    //                           color: Colors.red,
    //                           borderRadius: BorderRadius.circular(10)),
    //                       child: Text(
    //                         "Tickets",
    //                         style: TextStyle(color: Colors.white70),
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //           SizedBox(
    //             height: 10,
    //           ),
    //           Column(
    //             children: [
    //               Container(
    //                 height: 50,
    //                 padding: EdgeInsets.all(8.0),
    //                 decoration: BoxDecoration(
    //                     color: Colors.grey[200],
    //                     borderRadius: BorderRadius.circular(10)),
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   children: const [
    //                     Text(
    //                       "Actions",
    //                       style: TextStyle(color: Colors.red),
    //                     ),
    //                     Icon(
    //                       Icons.arrow_drop_down_circle_outlined,
    //                       color: Colors.red,
    //                     )
    //                   ],
    //                 ),
    //               ),
    //               SizedBox(
    //                 height: 5,
    //               ),
    //               GestureDetector(
    //                 onTap: (){
    //                   Get.to(() => TicketNumberVerify(
    //                     user: widget.user,
    //                   ));
    //                 },
    //                 child: Row(
    //                   children: const [
    //                     Icon(
    //                       Icons.arrow_right,
    //                       size: 10,
    //                     ),
    //                     SizedBox(
    //                       width: 10,
    //                     ),
    //                     Text("Verify Ticket Number"),
    //                     Icon(
    //                       Icons.check,
    //                       color: Colors.red,
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //               const SizedBox(
    //                 height: 5,
    //               ),
    //               GestureDetector(
    //                 onTap: (){
    //                   Get.to(() => TicketScanVerify(
    //                     user: widget.user,
    //                   ));
    //                 },
    //                 child: Row(
    //                   children: const [
    //                     Icon(
    //                       Icons.arrow_right,
    //                       size: 10,
    //                     ),
    //                     SizedBox(
    //                       width: 10,
    //                     ),
    //                     Text("Scan Ticket Card"),
    //                     Icon(
    //                       Icons.receipt,
    //                       color: Colors.red,
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //               const SizedBox(
    //                 height: 5,
    //               ),
    //               GestureDetector(
    //                 onTap: (){
    //                   Get.to(() => TripNew(
    //                     user: widget.user,
    //                     isOrdinary: true,
    //                   ));
    //                 },
    //                 child: Row(
    //                   children: const [
    //                     Icon(
    //                       Icons.arrow_right,
    //                       size: 10,
    //                     ),
    //                     SizedBox(
    //                       width: 10,
    //                     ),
    //                     Text("Add Trips"),
    //                     Text(
    //                       "(Ordinary)",
    //                       style: TextStyle(color: Color(0xff62020a)),
    //                     ),
    //                     Icon(
    //                       Icons.add,
    //                       color: Colors.red,
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //               SizedBox(
    //                 height: 5,
    //               ),
    //               GestureDetector(
    //                 onTap: (){
    //                   Get.to(() => TripNew(
    //                     user: widget.user,
    //                     isOrdinary: false,
    //                   ));
    //                 },
    //                 child: Row(
    //                   children: const [
    //                     Icon(
    //                       Icons.arrow_right,
    //                       size: 10,
    //                     ),
    //                     SizedBox(
    //                       width: 10,
    //                     ),
    //                     Text("Add Trips"),
    //                     Text(
    //                       "(VIP)",
    //                       style: TextStyle(color: Color(0xff62020a)),
    //                     ),
    //                     Icon(
    //                       Icons.add,
    //                       color: Colors.red,
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //               SizedBox(
    //                 height: 5,
    //               ),
    //               GestureDetector(
    //                 onTap: (){
    //                   Get.to(() => BusParkLocations(user: widget.user,));
    //                 },
    //                 child: Row(
    //                   children: const [
    //                     Icon(
    //                       Icons.arrow_right,
    //                       size: 10,
    //                     ),
    //                     SizedBox(
    //                       width: 10,
    //                     ),
    //                     Text("Add Destinations/Bus Parks"),
    //                     Icon(
    //                       Icons.add,
    //                       color: Colors.red,
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //               const SizedBox(
    //                 height: 5,
    //               ),
    //               Row(
    //                 children: const [
    //                   Icon(
    //                     Icons.arrow_right,
    //                     size: 10,
    //                   ),
    //                   SizedBox(
    //                     width: 10,
    //                   ),
    //                   Text("View Notifications"),
    //                   Icon(
    //                     Icons.notifications,
    //                     color: Colors.red,
    //                   ),
    //                 ],
    //               ),
    //               const SizedBox(
    //                 height: 5,
    //               ),
    //               GestureDetector(
    //                 onTap: (){
    //                   Get.to(() => BusCompanyProfile(user: widget.user,));
    //                 },
    //                 child: Row(
    //                   children: const [
    //                     Icon(
    //                       Icons.arrow_right,
    //                       size: 10,
    //                     ),
    //                     SizedBox(
    //                       width: 10,
    //                     ),
    //                     Text("Company Support/Help Lines"),
    //                     Icon(
    //                       Icons.phone,
    //                       color: Colors.red,
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //               const SizedBox(
    //                 height: 5,
    //               ),
    //               Row(
    //                 children: const [
    //                   Icon(
    //                     Icons.arrow_right,
    //                     size: 10,
    //                   ),
    //                   SizedBox(
    //                     width: 10,
    //                   ),
    //                   Text("Ask For Help"),
    //                   Icon(
    //                     Icons.help,
    //                     color: Colors.red,
    //                   ),
    //                 ],
    //               ),
    //             ],
    //           ),
    //           SizedBox(height: 10),
    //           Container(
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Container(
    //                   height: 50,
    //                   padding: EdgeInsets.all(8.0),
    //                   decoration: BoxDecoration(
    //                       color: Colors.grey[200],
    //                       borderRadius: BorderRadius.circular(10)),
    //                   child: Row(
    //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                     children: const [
    //                       Text(
    //                         "Latest Trips",
    //                         style: TextStyle(color: Colors.red),
    //                       ),
    //                       Icon(
    //                         Icons.arrow_drop_down_circle_outlined,
    //                         color: Colors.red,
    //                       )
    //                     ],
    //                   ),
    //                 ),
    //                 Padding(
    //                   padding: const EdgeInsets.symmetric(horizontal: 10),
    //                   child: Column(
    //                     children: [
    //                       Text(
    //                         "None yet!",
    //                         style: TextStyle(color: Colors.grey),
    //                       ),
    //                     ],
    //                   ),
    //                 )
    //               ],
    //             ),
    //           ),
    //           SizedBox(height: 20),
    //           Container(
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Container(
    //                   height: 50,
    //                   padding: EdgeInsets.all(8.0),
    //                   decoration: BoxDecoration(
    //                       color: Colors.grey[200],
    //                       borderRadius: BorderRadius.circular(10)),
    //                   child: Row(
    //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                     children: [
    //                       Text(
    //                         "Latest Tickets",
    //                         style: TextStyle(color: Colors.red),
    //                       ),
    //                       Icon(
    //                         Icons.arrow_drop_down_circle_outlined,
    //                         color: Colors.red,
    //                       )
    //                     ],
    //                   ),
    //                 ),
    //                 Padding(
    //                   padding: const EdgeInsets.symmetric(horizontal: 10),
    //                   child: Column(
    //                     children: [
    //                       Text(
    //                         "None yet!",
    //                         style: TextStyle(color: Colors.grey),
    //                       ),
    //                     ],
    //                   ),
    //                 )
    //               ],
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}