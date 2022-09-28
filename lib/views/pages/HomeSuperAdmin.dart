// import 'package:flutter/material.dart';
//
// class HomeSuperAdmin extends StatefulWidget {
//   const HomeSuperAdmin({Key key}) : super(key: key);
//
//   @override
//   _HomeSuperAdminState createState() => _HomeSuperAdminState();
// }
//
// class _HomeSuperAdminState extends State<HomeSuperAdmin> {
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

import 'package:bus_stop_develop_admin/models/user.dart';
import 'package:bus_stop_develop_admin/views/pages/superAdmin/AdminAccountsList.dart';
import 'package:bus_stop_develop_admin/views/pages/superAdmin/AllClients.dart';
import 'package:bus_stop_develop_admin/views/pages/superAdmin/AllDestinationsList.dart';
import 'package:bus_stop_develop_admin/views/pages/superAdmin/AllNotifications.dart';
import 'package:bus_stop_develop_admin/views/pages/superAdmin/AllTickets.dart';
import 'package:bus_stop_develop_admin/views/pages/superAdmin/AllTrips.dart';
import 'package:bus_stop_develop_admin/views/pages/superAdmin/SettingsScreen.dart';
import 'package:bus_stop_develop_admin/views/pages/superAdmin/bus_company/BusCompanyList.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeSuperAdmin extends StatefulWidget {
  final AdminUserModel user;
  const HomeSuperAdmin({Key key,this.user}) : super(key: key);

  @override
  _HomeSuperAdminState createState() => _HomeSuperAdminState();
}

class _HomeSuperAdminState extends State<HomeSuperAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Icon(Icons.menu,
                      color:Colors.red,
                      size: 40,
                    ),
                    Icon(Icons.pages,
                      color:Colors.red,
                      size: 40,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        "ADMINISTRATOR".toUpperCase()
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          Get.to(() => const BusCompanyList());
                        },
                        child: Container(
                          height: 150,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: const Text("Bus Companies",
                            style: TextStyle(color: Colors.white70),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5,),
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          Get.to(() => const AllDestinationsList());
                        },
                        child: Container(
                          height: 150,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: const Text("Destinations",
                            style: TextStyle(color: Colors.white70),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10,),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          Get.to(() => const AllTrips());
                        },
                        child: Container(
                          height: 150,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: const Text("Trips",
                            style: TextStyle(color: Colors.white70),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5,),
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          Get.to(() => const AllTickets());
                        },
                        child: Container(
                          height: 150,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Text("Tickets",
                            style: TextStyle(color: Colors.white70),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Column(
                children: [
                  Container(
                    height: 50,
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Actions",
                          style: TextStyle(color: Colors.red),
                        ),
                        Icon(Icons.arrow_drop_down_circle_outlined,
                          color: Colors.red,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 5,),
                  GestureDetector(
                    onTap: (){
                      Get.to(() => const BusCompanyList());
                    },
                    child: Row(
                      children: const [
                        Icon(Icons.arrow_right,size: 10,),
                        SizedBox(width: 10,),
                        Text("Add Bus Company"),
                        Icon(Icons.people,color: Colors.red,),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5,),
                  GestureDetector(
                    onTap: (){
                      Get.to(() => const AllDestinationsList());
                    },
                    child: Row(
                      children: const [
                        Icon(Icons.arrow_right,size: 10,),
                        SizedBox(width: 10,),
                        Text("Add Destinations"),
                        Icon(Icons.location_searching,color: Colors.red,),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5,),
                  GestureDetector(
                    onTap: (){
                      Get.to(() => const AllClients());
                    },
                    child: Row(
                      children: const [
                        Icon(Icons.arrow_right,size: 10,),
                        SizedBox(width: 10,),
                        Text("Registered Clients"),
                        Icon(Icons.people,color: Colors.red,),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5,),
                  GestureDetector(
                    onTap: (){
                      Get.to(() => const AdminAccountsList());
                    },
                    child: Row(
                      children: const [
                        Icon(Icons.arrow_right,size: 10,),
                        SizedBox(width: 10,),
                        Text("Admin Accounts"),
                        Icon(Icons.people_alt_outlined,color: Colors.red,),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5,),
                  GestureDetector(
                    onTap: (){
                      Get.to(() => const AllSuperAdminNotifications());
                    },
                    child: Row(
                      children: const [
                        Icon(Icons.arrow_right,size: 10,),
                        SizedBox(width: 10,),
                        Text("Notifications"),
                        Icon(Icons.notifications,color: Colors.red,),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5,),
                  GestureDetector(
                    onTap: (){
                      Get.to(() => const SettingsScreen());
                    },
                    child: Row(
                      children: const [
                        Icon(Icons.arrow_right,size: 10,),
                        SizedBox(width: 10,),
                        Text("Company Settings/Support"),
                        Icon(Icons.settings,color: Colors.red,),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height:10),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 50,
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Latest Notificatione",
                            style: TextStyle(color: Colors.red),
                          ),
                          Icon(Icons.arrow_drop_down_circle_outlined,
                            color: Colors.red,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          Text("None yet!",style: TextStyle(color: Colors.grey),),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

