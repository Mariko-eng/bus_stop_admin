import 'package:bus_stop_develop_admin/models/Notifications.dart';
import 'package:bus_stop_develop_admin/views/shared/utils.dart';
import 'package:flutter/material.dart';
import 'package:bus_stop_develop_admin/models/user.dart';

class BusCompanyNotifications extends StatefulWidget {
  final AdminUserModel user;
  const BusCompanyNotifications({Key key,this.user}) : super(key: key);

  @override
  _BusCompanyNotificationsState createState() => _BusCompanyNotificationsState();
}

class _BusCompanyNotificationsState extends State<BusCompanyNotifications> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: const Color(0xff62020a),
                borderRadius: BorderRadius.circular(10)),
            child: Text("Notifications",
            style: TextStyle(color: Colors.yellow[200]),
            )
        ),
        StreamBuilder(
          stream: getBusCompanyNotifications(companyId: widget.user.uid),
            builder: (context,snapshot){
            if(snapshot.hasError){
              print(snapshot.error);
            }
            if(snapshot.hasData){
            List<Notifications> data = snapshot.data;
            if(data.isEmpty){
              return const Center(
                child: Text("No Notifications Yet"),
              );
            }
            return Expanded(
              child: ListView.builder(
                itemCount: data.length,
                  itemBuilder: (context,int index){
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(data[index].title.toUpperCase(),
                          style: TextStyle(color: Colors.blue[900]),
                          ),
                          SizedBox(height: 10,),
                          Text(data[index].body),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                dateToString(
                                  data[index].dateCreated),
                                style: TextStyle(color: Colors.blue[300]),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
              }),
            );
            }
            else{
              return Container();
            }
          }
            )
      ],
    );
  }
}
