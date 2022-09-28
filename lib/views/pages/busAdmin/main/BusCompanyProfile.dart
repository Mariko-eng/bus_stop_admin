import 'package:bus_stop_develop_admin/models/busCompany.dart';
import 'package:bus_stop_develop_admin/models/user.dart';
import 'package:flutter/material.dart';

class BusCompanyProfile extends StatefulWidget {
  final AdminUserModel user;
  const BusCompanyProfile({Key key, this.user}) : super(key: key);

  @override
  _BusCompanyProfileState createState() => _BusCompanyProfileState();
}

class _BusCompanyProfileState extends State<BusCompanyProfile> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getBusCompanyProfile(userId: widget.user.uid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
          }
          if (snapshot.hasData) {
            BusCompany data = snapshot.data;
            return Card(
              child: Column(
                children: [
                  Container(
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: const Color(0xff62020a),
                          borderRadius: BorderRadius.circular(10)),
                      child: Text("Bus Company Profile",
                        style: TextStyle(color: Colors.yellow[200]),
                      )
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text("Name"), Text(data.name)],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text("Account Email"), Text(data.email)],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Contact Email"),
                        Text(data.contactEmail)
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text("Phone"), Text(data.phoneNumber)],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text("HotLine"), Text(data.hotLine)],
                    ),
                  ),
                ],
              ),
            );
          }else{
            return Container();
          }


        //   return ListView(
        //   children: [
        //     Text("Profile"),
        //     FutureBuilder(
        //         future: getBusCompanyProfile(userId: widget.user.uid),
        //         builder: (context, snapshot) {
        //           if (snapshot.hasError) {
        //             print(snapshot.error);
        //           }
        //           if (snapshot.hasData) {
        //             BusCompany data = snapshot.data;
        //             return Card(
        //               child: Column(
        //                 children: [
        //                   SizedBox(
        //                     height: 20,
        //                   ),
        //                   Padding(
        //                     padding: const EdgeInsets.symmetric(horizontal: 20),
        //                     child: Row(
        //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                       children: [Text("Name"), Text(data.name)],
        //                     ),
        //                   ),
        //                   SizedBox(
        //                     height: 10,
        //                   ),
        //                   Padding(
        //                     padding: const EdgeInsets.symmetric(horizontal: 20),
        //                     child: Row(
        //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                       children: [Text("Account Email"), Text(data.email)],
        //                     ),
        //                   ),
        //                   SizedBox(
        //                     height: 10,
        //                   ),
        //                   Padding(
        //                     padding: const EdgeInsets.symmetric(horizontal: 20),
        //                     child: Row(
        //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                       children: [
        //                         Text("Contact Email"),
        //                         Text(data.contactEmail)
        //                       ],
        //                     ),
        //                   ),
        //                   SizedBox(
        //                     height: 10,
        //                   ),
        //                   Padding(
        //                     padding: const EdgeInsets.symmetric(horizontal: 20),
        //                     child: Row(
        //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                       children: [Text("Phone"), Text(data.phoneNumber)],
        //                     ),
        //                   ),
        //                   const SizedBox(
        //                     height: 10,
        //                   ),
        //                   Padding(
        //                     padding: const EdgeInsets.symmetric(horizontal: 20),
        //                     child: Row(
        //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                       children: [Text("HotLine"), Text(data.hotLine)],
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             );
        //           } else {
        //             return Scaffold(
        //               body: Container(),
        //             );
        //           }
        //         })
        //   ],
        // );
      }
    );
    // return FutureBuilder(
    //     future: getBusCompanyProfile(userId: widget.user.uid),
    //     builder: (context, snapshot) {
    //       if (snapshot.hasError) {
    //         print(snapshot.error);
    //       }
    //       if (snapshot.hasData) {
    //         BusCompany data = snapshot.data;
    //         return Scaffold(
    //           appBar: AppBar(
    //             title: const Text("Profile"),
    //           ),
    //           body: Card(
    //             child: Column(
    //               children: [
    //                 SizedBox(height: 20,),
    //                 Padding(
    //                   padding: const EdgeInsets.symmetric(horizontal: 20),
    //                   child: Row(
    //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                     children: [
    //                       Text("Name"),
    //                       Text(data.name)
    //                     ],
    //                   ),
    //                 ),
    //                 SizedBox(height: 10,),
    //                 Padding(
    //                   padding: const EdgeInsets.symmetric(horizontal: 20),
    //                   child: Row(
    //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                     children: [
    //                       Text("Account Email"),
    //                       Text(data.email)
    //                     ],
    //                   ),
    //                 ),
    //                 SizedBox(height: 10,),
    //                 Padding(
    //                   padding: const EdgeInsets.symmetric(horizontal: 20),
    //                   child: Row(
    //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                     children: [
    //                       Text("Contact Email"),
    //                       Text(data.contactEmail)
    //                     ],
    //                   ),
    //                 ),
    //                 SizedBox(height: 10,),
    //                 Padding(
    //                   padding: const EdgeInsets.symmetric(horizontal: 20),
    //                   child: Row(
    //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                     children: [
    //                       Text("Phone"),
    //                       Text(data.phoneNumber)
    //                     ],
    //                   ),
    //                 ),
    //                 const SizedBox(height: 10,),
    //                 Padding(
    //                   padding: const EdgeInsets.symmetric(horizontal: 20),
    //                   child: Row(
    //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                     children: [
    //                       Text("HotLine"),
    //                       Text(data.hotLine)
    //                     ],
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         );
    //       } else {
    //         return Scaffold(
    //           body: Container(),
    //         );
    //       }
    //     });
  }
}
