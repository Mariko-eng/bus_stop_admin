import 'package:bus_stop_develop_admin/models/userBusAdminModel.dart';
import 'package:bus_stop_develop_admin/views/shared/loading.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BusCompanyNew extends StatefulWidget {
  const BusCompanyNew({Key key}) : super(key: key);

  @override
  _NewBusCompanyState createState() => _NewBusCompanyState();
}

class _NewBusCompanyState extends State<BusCompanyNew> {
  final _nameController = TextEditingController();
  final _contactEmailController = TextEditingController();
  final _accountEmailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _phoneHotLineController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Scaffold(
      body: Loading(),
    )
        : Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.grey[200],
          iconTheme: const IconThemeData(color: Color(0xff62020a)),
          title: const Text(
            "Add Bus Company",
            style: TextStyle(color: Color(0xff62020a)),
          ),
        ),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFieldContainer(
                  child: TextField(
                    controller: _nameController,
                    keyboardType: TextInputType.name,
                    style: const TextStyle(fontSize: 20),
                    cursorColor: Colors.red,
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.people_outline,
                        color: Color(0xff62020a),
                      ),
                      hintText: "Company Name",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                TextFieldContainer(
                  child: TextField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    style: const TextStyle(fontSize: 20),
                    cursorColor: Colors.red,
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.people_outline,
                        color: Color(0xff62020a),
                      ),
                      hintText: "Company Phone Number",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                TextFieldContainer(
                  child: TextField(
                    controller: _phoneHotLineController,
                    keyboardType: TextInputType.phone,
                    style: const TextStyle(fontSize: 20),
                    cursorColor: Colors.red,
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.people_outline,
                        color: Color(0xff62020a),
                      ),
                      hintText: "Company HotLine",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                TextFieldContainer(
                  child: TextField(
                    controller: _contactEmailController,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(fontSize: 20),
                    cursorColor: Colors.red,
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.people_outline,
                        color: Color(0xff62020a),
                      ),
                      hintText: "Company Contact Email",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                TextFieldContainer(
                  child: TextField(
                    controller: _accountEmailController,
                    keyboardType: TextInputType.emailAddress,
                    style: const TextStyle(fontSize: 20),
                    cursorColor: Colors.red,
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.people_outline,
                        color: Color(0xff62020a),
                      ),
                      hintText: "Account Email",
                      border: InputBorder.none,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30, vertical: 10),
                  child: GestureDetector(
                    onTap: () async{
                      final bool isValidContactEmail =
                      EmailValidator.validate(_contactEmailController.text.trim());
                      final bool isValidAccountEmail =
                      EmailValidator.validate(_accountEmailController.text.trim());

                      if (_nameController.text.isEmpty) {
                         Get.snackbar("Failed",
                            "Input Company Name",
                             colorText: Colors.white,
                             backgroundColor: Colors.purpleAccent);
                         return;
                      } else if (_phoneController.text.isEmpty) {
                         Get.snackbar(
                            "Failed", "Input Contact Person Phone Number",
                             colorText: Colors.white,
                             backgroundColor: Colors.purpleAccent);
                         return;
                      } else if (_phoneHotLineController
                          .text.isEmpty) {
                         Get.snackbar(
                            "Failed", "Input Company Hotline Number",
                             colorText: Colors.white,
                             backgroundColor: Colors.purpleAccent);
                         return;
                      } else if (!isValidContactEmail) {
                         Get.snackbar(
                            "Failed", "Input/Wrong Contact Person Email",
                            colorText: Colors.white,
                            backgroundColor: Colors.purpleAccent);
                         return;
                      }else if (!isValidAccountEmail) {
                         Get.snackbar(
                            "Failed", "Input/Wrong Account Email",
                             colorText: Colors.white,
                             backgroundColor: Colors.purpleAccent);
                         return;
                      } else {
                          setState(() {
                            isLoading = true;
                          });
                          bool result = await createBusAdminAccount(
                            name: _nameController.text.trim(),
                            contactEmail: _contactEmailController.text.trim(),
                            accountEmail: _accountEmailController.text.trim(),
                            phone: _phoneController.text.trim(),
                            hotline: _phoneHotLineController.text.trim(),
                          );
                          if (result == false) {
                            setState(() {
                              isLoading = false;
                            });
                            Get.snackbar(
                                "Failed To Added Bus Company", "Try Again",
                                backgroundColor: Colors.purpleAccent);
                          } else {
                            setState(() {
                              isLoading = false;
                            });
                            Get.back();
                            Get.snackbar("Success", "Added Bus Company",
                                backgroundColor: Colors.greenAccent);
                          }
                        }
                    },
                    child: Container(
                        alignment: Alignment.center,
                        height: 62,
                        decoration: BoxDecoration(
                            color: const Color(0xff62020a),
                            borderRadius:
                            BorderRadius.circular(20.0)),
                        child: const Text(
                          "Add Bus Company",
                          style: TextStyle(
                              fontSize: 20, color: Colors.white),
                        )),
                  ),
                ),
              ],
            ),
          ),
        )
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
      width: size.width * 0.9,
      height: 60,
      decoration: BoxDecoration(
        color: const Color(0xffe5e5e5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}

