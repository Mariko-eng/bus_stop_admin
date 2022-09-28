import 'package:bus_stop_develop_admin/controllers/authProvider.dart';
import 'package:bus_stop_develop_admin/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:email_validator/email_validator.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    UserProvider _userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.55,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Center(
                    child: Image.asset(
                  'assets/images/image12.png',
                )),
              ),
              decoration: const BoxDecoration(
                  color: Color(0xff62020a),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(50),
                    bottomRight: Radius.circular(50),
                  )),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.45,
              width: MediaQuery.of(context).size.width,
              color: const Color(0xffffffff),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 40,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    // color: const Color(0xffe5e5e5),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text("Bus Stopper".toUpperCase(),
                  style: const TextStyle(
                    fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff62020a)),
                  ),
                ),
                TextFieldContainer(
                  child: TextField(
                    controller: _emailController,
                    style: const TextStyle(fontSize: 20),
                    cursorColor: Colors.red,
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.email,
                        color: Color(0xff62020a),
                      ),
                      hintText: "Email",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                TextFieldContainer(
                  child: TextField(
                    controller: _passwordController,
                    style: const TextStyle(fontSize: 20),
                    cursorColor: Colors.red,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: "Password",
                      icon: Icon(
                        Icons.lock,
                        color: Color(0xff62020a),
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: GestureDetector(
                    onTap: () async {
                      final bool isValid =
                          EmailValidator.validate(_emailController.text.trim());
                      if (!isValid) {
                        Get.snackbar("Incorrect Email", "Try Again");
                      } else if (_passwordController.text.trim().length < 7) {
                        Get.snackbar("Incorrect Email", "Try Again");
                      } else {
                        await _userProvider.signIn(_emailController.text.trim(),
                            _passwordController.text.trim());
                      }
                    },
                    child: Container(
                        alignment: Alignment.center,
                        height: 62,
                        decoration: BoxDecoration(
                            color: const Color(0xff62020a),
                            borderRadius: BorderRadius.circular(20.0)),
                        child: const Text(
                          "Sign in",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        )),
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

class TextFieldContainer extends StatelessWidget {
  final Widget child;

  const TextFieldContainer({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      width: size.width * 0.8,
      height: 60,
      decoration: BoxDecoration(
        color: const Color(0xffe5e5e5),
        borderRadius: BorderRadius.circular(15),
      ),
      child: child,
    );
  }
}
