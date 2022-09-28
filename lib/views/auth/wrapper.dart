import 'package:bus_stop_develop_admin/controllers/authProvider.dart';
import 'package:bus_stop_develop_admin/views/auth/login.dart';
import 'package:bus_stop_develop_admin/views/pages/dashboardBusAdmin.dart';
import 'package:bus_stop_develop_admin/views/pages/dashboardSuperAdmin.dart';
import 'package:bus_stop_develop_admin/views/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    if (userProvider.isLoading) {
      return Loading();
    } else {
      if (userProvider.userModel == null) {
        return const LoginScreen();
      } else {
        if(!userProvider.userModel.isActive){
          userProvider.signOut();
        }else{
          if(userProvider.userModel.group == "bus_admin"){
            return DashboardBusAdmin(user: userProvider.userModel,);
          }else{
            return DashboardSuperAdmin(user: userProvider.userModel,);
          }
        }
        return Container();
      }
    }
  }
}
