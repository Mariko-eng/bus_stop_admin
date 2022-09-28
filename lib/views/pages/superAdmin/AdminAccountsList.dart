import 'package:bus_stop_develop_admin/models/userSuperAdminModel.dart';
import 'package:bus_stop_develop_admin/views/pages/superAdmin/AdminAccountsNew.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AdminAccountsList extends StatefulWidget {
  const AdminAccountsList({Key key}) : super(key: key);

  @override
  _AdminAccountsListState createState() => _AdminAccountsListState();
}

class _AdminAccountsListState extends State<AdminAccountsList> {
  @override
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
          Text("Super Admin Accounts".toUpperCase(),
            style: TextStyle(color: Colors.red[900]),)
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red[900],
          onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AdminAccountsNew()));
          },
          child: Icon(Icons.add_box)
      ),
      body: StreamBuilder(
        stream: getAdminAccounts(),
        builder: (context, snapshot){
          if(snapshot.hasError){
            if (kDebugMode) {
              print(snapshot.error);
            }
          }
          if(snapshot.hasData){
            List<SuperAdminUserModel> data = snapshot.data;
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, int index){
                    return ListTile(
                      onTap: (){
                        _openBottomSheet( user: data[index]);
                      },
                      leading: const Icon(Icons.arrow_right_sharp),
                      title: Text(data[index].name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(data[index].email),
                          Text(data[index].phoneNumber),
                          data[index].hotLine == null ? Container() : Text(data[index].hotLine)
                        ],
                      ),
                      trailing: Icon(Icons.phone,color: Colors.green,),
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

  void _openBottomSheet({ SuperAdminUserModel user }) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return _getTicketOptions(user: user);
        });
  }

  Widget _getTicketOptions({ SuperAdminUserModel user }) {
    final options = [
      "View/Edit Account",
    ];
    return Container(
      height: 100,
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      color: Colors.white,
      child: ListView(
        children: options
            .map((option) => ListTile(
          onTap: () => {
            if(option == "View/Edit Account"){
              Navigator.of(context).pop(),
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => BusCompanyTrips(
              //           company: company,
              //         )
              //     ))
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
