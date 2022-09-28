import 'package:bus_stop_develop_admin/models/destination.dart';
import 'package:bus_stop_develop_admin/views/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllDestinationsNew extends StatefulWidget {
  const AllDestinationsNew({Key key}) : super(key: key);

  @override
  _DestinationNewState createState() => _DestinationNewState();
}

class _DestinationNewState extends State<AllDestinationsNew> {
  final _nameController = TextEditingController();

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
            "Add Destination",
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
                      hintText: "Destination Name",
                      border: InputBorder.none,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30, vertical: 10),
                  child: GestureDetector(
                    onTap: () async {
                      if (_nameController.text.isEmpty) {
                         Get.snackbar("Failed",
                            "Destination Name Is Empty",
                             colorText: Colors.white,
                             backgroundColor: Colors.purpleAccent);
                      } else if (_nameController.text.trim().length < 3 ){
                         Get.snackbar("Failed",
                            "Destination Name Is Very Short",
                             colorText: Colors.white,
                             backgroundColor: Colors.purpleAccent);
                      } else {
                        setState(() {
                          isLoading = true;
                        });
                        bool result = await addDestinations(name: _nameController.text.trim().toUpperCase());
                        if (result == false) {
                          setState(() {
                            isLoading = false;
                          });
                           Get.snackbar(
                              "Failed To Added Destination Or Already Exists", "Try Again",
                               colorText: Colors.white,
                               backgroundColor: Colors.purpleAccent);
                        } else {
                          setState(() {
                            isLoading = false;
                          });
                          Get.back();
                          Get.snackbar("Success", "Added Destination",
                              colorText: Colors.white,
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
                          "Add Destination",
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

