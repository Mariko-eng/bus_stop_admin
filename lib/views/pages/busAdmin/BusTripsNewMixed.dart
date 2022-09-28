import 'package:bus_stop_develop_admin/models/destination.dart';
import 'package:bus_stop_develop_admin/models/user.dart';
import 'package:bus_stop_develop_admin/views/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../models/trip.dart';

class BusTripsNewMixed extends StatefulWidget {
  final AdminUserModel user;
  final String tripType;

  const BusTripsNewMixed({Key key, this.tripType, this.user}) : super(key: key);

  @override
  _BusTripsNewMixedState createState() => _BusTripsNewMixedState();
}

class _BusTripsNewMixedState extends State<BusTripsNewMixed> {
  final _arrivalController = TextEditingController();
  final _arrivalIdController = TextEditingController();
  final _departureController = TextEditingController();
  final _departureIdController = TextEditingController();
  final _departureTimeController = TextEditingController();
  final _arrivalTimeController = TextEditingController();
  final _priceOrdinaryController = TextEditingController();
  final _totalSeatsOrdinaryController = TextEditingController();
  final _priceVIPController = TextEditingController();
  final _totalSeatsVIPController = TextEditingController();

  DateTime departureTime;
  DateTime arrivalTime;

  // int seats = 0;
  // int price = 0;
  int seatsOrdinary = 0;
  int seatsVIP = 0;
  int priceOrdinary = 0;
  int priceVIP = 0;

  bool isLoading = false;

  bool isTripHavingVIP = false;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Scaffold(
            body: Loading(),
          )
        : Scaffold(
            appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.grey[200],
                iconTheme: IconThemeData(color: Color(0xff62020a)),
                title: const Text(
                  "Add New Trip",
                  style: TextStyle(color: Color(0xff62020a)),
                )),
            body: FutureBuilder(
              future: getDestinations(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error);
                }
                if (snapshot.hasData) {
                  List<Destination> destinations = snapshot.data;
                  // print(destinations);
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFieldContainer(
                            child: TextField(
                              controller: _departureController,
                              readOnly: true,
                              style: const TextStyle(fontSize: 20),
                              cursorColor: Colors.red,
                              decoration: const InputDecoration(
                                icon: Icon(
                                  Icons.location_history_sharp,
                                  color: Color(0xff62020a),
                                ),
                                hintText: "Source",
                                border: InputBorder.none,
                              ),
                              onTap: () {
                                _showDestinations(context, destinations, true);
                              },
                            ),
                          ),
                          TextFieldContainer(
                            child: TextField(
                              controller: _arrivalController,
                              readOnly: true,
                              style: const TextStyle(fontSize: 20),
                              cursorColor: Colors.red,
                              decoration: const InputDecoration(
                                icon: Icon(
                                  Icons.location_history,
                                  color: Color(0xff62020a),
                                ),
                                hintText: "Destination",
                                border: InputBorder.none,
                              ),
                              onTap: () {
                                _showDestinations(context, destinations, false);
                              },
                            ),
                          ),
                          TextFieldContainer(
                            child: TextField(
                              controller: _departureTimeController,
                              readOnly: true,
                              style: const TextStyle(fontSize: 20),
                              cursorColor: Colors.red,
                              decoration: const InputDecoration(
                                icon: Icon(
                                  Icons.calendar_today,
                                  color: Color(0xff62020a),
                                ),
                                hintText: "Departure Time",
                                border: InputBorder.none,
                              ),
                              onTap: () {
                                _dateTimePickerWidget(context, true);
                              },
                            ),
                          ),
                          TextFieldContainer(
                            child: TextField(
                              controller: _arrivalTimeController,
                              readOnly: true,
                              style: const TextStyle(fontSize: 20),
                              cursorColor: Colors.red,
                              decoration: const InputDecoration(
                                icon: Icon(
                                  Icons.today_rounded,
                                  color: Color(0xff62020a),
                                ),
                                hintText: "Arrival Time",
                                border: InputBorder.none,
                              ),
                              onTap: () {
                                _dateTimePickerWidget(context, false);
                              },
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Radio(
                                        value: false,
                                        groupValue: isTripHavingVIP,
                                        onChanged: (val) {
                                          setState(() {
                                            isTripHavingVIP = false;
                                          });
                                        }),
                                    const Text(
                                      "ONLY ORDINARY",
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 30.0,
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    Radio(
                                      value: true,
                                      groupValue: isTripHavingVIP,
                                      onChanged: (val) {
                                        setState(() {
                                          isTripHavingVIP = true;
                                        });
                                      },
                                    ),
                                    const Text(
                                      "ORDINARY + VIP",
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          !isTripHavingVIP
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextFieldContainer2(
                                        child: TextField(
                                          controller:
                                              _totalSeatsOrdinaryController,
                                          keyboardType: TextInputType.number,
                                          style: const TextStyle(fontSize: 17),
                                          cursorColor: Colors.red,
                                          decoration: const InputDecoration(
                                            icon: Icon(
                                              Icons.people_outline,
                                              color: Color(0xff62020a),
                                            ),
                                            labelText: "Total Seats",
                                            labelStyle: TextStyle(
                                                fontSize: 14
                                            ),
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                      TextFieldContainer2(
                                        child: TextField(
                                          keyboardType: TextInputType.number,
                                          controller: _priceOrdinaryController,
                                          style: const TextStyle(fontSize: 17),
                                          cursorColor: Colors.red,
                                          decoration: const InputDecoration(
                                            icon: Icon(
                                              Icons.money_off,
                                              color: Color(0xff62020a),
                                            ),
                                            labelText: "Price",
                                            labelStyle: TextStyle(
                                                fontSize: 14
                                            ),
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Container(),
                          isTripHavingVIP
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextFieldContainer2(
                                        child: TextField(
                                          controller:
                                              _totalSeatsOrdinaryController,
                                          keyboardType: TextInputType.number,
                                          style: const TextStyle(fontSize: 17),
                                          cursorColor: Colors.red,
                                          decoration: const InputDecoration(
                                            icon: Icon(
                                              Icons.people_outline,
                                              color: Color(0xff62020a),
                                            ),
                                            labelText: "Seats (Ordinary)",
                                            labelStyle: TextStyle(
                                                fontSize: 14
                                            ),
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                      TextFieldContainer2(
                                        child: TextField(
                                          keyboardType: TextInputType.number,
                                          controller: _priceOrdinaryController,
                                          style: const TextStyle(fontSize: 17),
                                          cursorColor: Colors.red,
                                          decoration: const InputDecoration(
                                            icon: Icon(
                                              Icons.money_off,
                                              color: Color(0xff62020a),
                                            ),
                                            labelText: "Price (Ordinary)",
                                            labelStyle: TextStyle(
                                                fontSize: 14
                                            ),
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Container(),
                          isTripHavingVIP
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextFieldContainer2(
                                        child: TextField(
                                          controller:
                                              _totalSeatsVIPController,
                                          keyboardType: TextInputType.number,
                                          style: const TextStyle(fontSize: 17),
                                          cursorColor: Colors.red,
                                          decoration: const InputDecoration(
                                            icon: Icon(
                                              Icons.people_outline,
                                              color: Color(0xff62020a),
                                            ),
                                            labelText: "Seats (VIP)",
                                            labelStyle: TextStyle(
                                                fontSize: 14
                                            ),
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                      TextFieldContainer2(
                                        child: TextField(
                                          keyboardType: TextInputType.number,
                                          controller: _priceVIPController,
                                          style: const TextStyle(fontSize: 17),
                                          cursorColor: Colors.red,
                                          decoration: const InputDecoration(
                                            icon: Icon(
                                              Icons.money_off,
                                              color: Color(0xff62020a),
                                            ),
                                            labelText: "Price (VIP)",
                                            labelStyle: TextStyle(
                                              fontSize: 14
                                            ),
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Container(),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            child: GestureDetector(
                              onTap: () async {
                                if (_departureIdController.text.isEmpty) {
                                  Get.snackbar("Failed",
                                      "Select Source/ Departure Location",
                                      backgroundColor: Colors.purpleAccent);
                                } else if (_arrivalIdController.text.isEmpty) {
                                  Get.snackbar(
                                      "Failed", "Select Destination Location",
                                      backgroundColor: Colors.purpleAccent);
                                } else if (_departureTimeController
                                    .text.isEmpty) {
                                  Get.snackbar(
                                      "Failed", "Select Departure Time",
                                      backgroundColor: Colors.purpleAccent);
                                } else if (_arrivalTimeController
                                    .text.isEmpty) {
                                  Get.snackbar("Failed", "Select Arrival Time",
                                      backgroundColor: Colors.purpleAccent);
                                } else if (isTripHavingVIP){
                                  _addOrdinaryXVIPTrip();
                                }else{
                                  _addOrdinaryTrip();
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
                                    "Add Trip",
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ));
    }

  _addOrdinaryTrip() async {
      try {
        int s = int.parse(
            _totalSeatsOrdinaryController.text);
        if (s <= 0) {
          Get.snackbar("Failed",
              "Number Of Seats Should Be Greater Than 0",
              backgroundColor: Colors.purpleAccent);
          return;
        } else {
          setState(() {
            seatsOrdinary = s;
          });
        }
      } catch (e) {
        Get.snackbar(
            "Failed", "Input Number Of Seats",
            backgroundColor: Colors.purpleAccent);
        return;
      }
      try {
        int p = int.parse(
            _priceOrdinaryController.text);
        if (p <= 1000) {
          Get.snackbar("Failed",
              "Price Should Be Greater Than 1000",
              backgroundColor: Colors.purpleAccent);
          return;
        } else {
          setState(() {
            priceOrdinary = p;
          });
        }
      } catch (e) {
        Get.snackbar("Failed", "Input Price",
            backgroundColor: Colors.purpleAccent);
        return;
      }
      setState(() {
        isLoading = true;
      });
      var result = await addTripOrdinaryOnly(
          companyId: widget.user.uid,
          departureLocationName: _departureController.text,
          departureLocationId: _departureIdController.text,
          arrivalLocationName: _arrivalController.text,
          arrivalLocationId: _arrivalIdController.text,
          departureTime: departureTime,
          arrivalTime: arrivalTime,
          totalSeats: seatsOrdinary,
          price: priceOrdinary,
          totalOrdinarySeats: seatsOrdinary,
          priceOrdinary: priceOrdinary,
          tripType: "Ordinary"
      );
      if (result == null) {
        setState(() {
          isLoading = false;
        });
        Get.snackbar(
            "Failed To Added Trip", "Try Again",
            backgroundColor: Colors.purpleAccent);
      } else {
        setState(() {
          isLoading = false;
        });
        Get.back();
        Get.snackbar("Success", "Added Trip",
            backgroundColor: Colors.greenAccent);
      }
  }

  _addOrdinaryXVIPTrip() async{
      try {
        int s = int.parse(
            _totalSeatsOrdinaryController.text);
        if (s <= 0) {
          Get.snackbar("Failed",
              "Ordinary Number Of Seats Should Be Greater Than 0",
              backgroundColor: Colors.purpleAccent);
          return;
        } else {
          setState(() {
            seatsOrdinary = s;
          });
        }
      } catch (e) {
        Get.snackbar(
            "Failed", "Input Ordinary Number Of Seats",
            backgroundColor: Colors.purpleAccent);
        return;
      }
      try {
        int p = int.parse(
            _priceOrdinaryController.text);
        if (p <= 1000) {
          Get.snackbar("Failed",
              "Ordinary Price Should Be Greater Than 1000",
              backgroundColor: Colors.purpleAccent);
          return;
        } else {
          setState(() {
            priceOrdinary = p;
          });
        }
      } catch (e) {
        Get.snackbar("Failed", "Input Price Of Ordinary",
            backgroundColor: Colors.purpleAccent);
        return;
      }
      try {
        int s = int.parse(
            _totalSeatsVIPController.text);
        if (s <= 0) {
          Get.snackbar("Failed",
              "VIP Number Of Seats Should Be Greater Than 0",
              backgroundColor: Colors.purpleAccent);
          return;
        } else {
          setState(() {
            seatsVIP = s;
          });
        }
      } catch (e) {
        Get.snackbar(
            "Failed", "Input VIP Number Of Seats",
            backgroundColor: Colors.purpleAccent);
        return;
      }
      try {
        int p = int.parse(
            _priceVIPController.text);
        if (p <= 1000) {
          Get.snackbar("Failed",
              "VIP Price Should Be Greater Than 1000",
              backgroundColor: Colors.purpleAccent);
          return;
        } else {
          setState(() {
            priceVIP = p;
          });
        }
      } catch (e) {
        Get.snackbar("Failed", "Input Price Of VIP",
            backgroundColor: Colors.purpleAccent);
        return;
      }
      setState(() {
        isLoading = true;
      });
      var result = await addTripOrdinaryAndVIP(
          companyId: widget.user.uid,
          departureLocationName: _departureController
              .text,
          departureLocationId: _departureIdController
              .text,
          arrivalLocationName: _arrivalController
              .text,
          arrivalLocationId: _arrivalIdController
              .text,
          departureTime: departureTime,
          arrivalTime: arrivalTime,
          totalSeats: seatsOrdinary + seatsVIP,
          price: 0,
          totalOrdinarySeats: seatsOrdinary,
          priceOrdinary: priceOrdinary,
          totalVipSeats: seatsVIP,
          priceVip: priceVIP,
          tripType: "Ordinary-X-VIP"
      );
      if (result == null) {
        setState(() {
          isLoading = false;
        });
        Get.snackbar(
            "Failed To Added Trip", "Try Again",
            backgroundColor: Colors.purpleAccent);
      } else {
        setState(() {
          isLoading = false;
        });
        Get.back();
        Get.snackbar("Success", "Added Trip",
            backgroundColor: Colors.greenAccent);
      }
  }


  _dateTimePickerWidget(BuildContext context, bool isDeparture) {
    return DatePicker.showDatePicker(
      context,
      dateFormat: 'dd MMMM yyyy HH:mm',
      initialDateTime: DateTime.now(),
      minDateTime: DateTime(DateTime.now().year),
      maxDateTime: DateTime(DateTime.now().year + 1),
      onMonthChangeStartWithFirstDate: true,
      onConfirm: (dateTime, List<int> index) {
        DateTime selectedDate = dateTime;
        if (isDeparture) {
          setState(() {
            departureTime = selectedDate.toUtc();
            _departureTimeController.text =
                DateFormat('dd-MMM-yyyy - HH:mm').format(selectedDate);
          });
        } else {
          setState(() {
            arrivalTime = selectedDate.toUtc();
            _arrivalTimeController.text =
                DateFormat('dd-MMM-yyyy - HH:mm').format(selectedDate);
          });
        }
      },
    );
  }

  Future<void> _showDestinations(
      BuildContext context, List<Destination> data, bool isDeparture) async {
    List sr = [];
    return await showDialog(
        context: context,
        builder: (context) {
          final TextEditingController _ctr = TextEditingController();
          return StatefulBuilder(
              builder: (context, setState) => AlertDialog(
                    content: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: LayoutBuilder(
                        builder: (ctx, constraints) {
                          return Column(
                            children: [
                              Container(
                                height: 50,
                                width: constraints.maxWidth,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                        child: TextField(
                                      decoration: const InputDecoration(
                                          hintText: "Search Here",
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.red)),
                                          enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.red))),
                                      controller: _ctr,
                                      onChanged: (val) {
                                        List l = [];
                                        setState(() {
                                          if (_ctr.text.isNotEmpty) {
                                            // data.add(_ctr.text);
                                            for (int i = 0;
                                                i < data.length;
                                                i++) {
                                              if (data[i]
                                                  .name
                                                  .toLowerCase()
                                                  .contains(_ctr.text
                                                      .toLowerCase())) {
                                                l.add(data[i]);
                                              }
                                            }
                                            sr = l;
                                            // print(l);
                                          } else {
                                            sr = l;
                                          }
                                        });
                                      },
                                    )),
                                    const Icon(Icons.search)
                                  ],
                                ),
                              ),
                              Container(
                                  height: constraints.maxHeight * 0.8,
                                  width: constraints.maxWidth,
                                  color: Colors.grey[200],
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 5),
                                  child: sr.isNotEmpty
                                      ? ListView.builder(
                                          itemCount: sr.length,
                                          itemBuilder: (context1, int i) =>
                                              GestureDetector(
                                                onTap: () {
                                                  if (isDeparture) {
                                                    setState(() {
                                                      _departureController
                                                          .text = sr[i].name;
                                                      _departureIdController
                                                          .text = sr[i].id;
                                                    });
                                                  } else {
                                                    setState(() {
                                                      _arrivalController.text =
                                                          sr[i].name;
                                                      _arrivalIdController
                                                          .text = sr[i].id;
                                                    });
                                                  }
                                                  Navigator.of(context).pop();
                                                },
                                                child: Row(
                                                  children: [
                                                    const Icon(
                                                        Icons.arrow_right),
                                                    Text(sr[i].name),
                                                  ],
                                                ),
                                              ))
                                      : ListView.builder(
                                          itemCount: data.length,
                                          itemBuilder: (context1, int i) =>
                                              GestureDetector(
                                                onTap: () {
                                                  if (isDeparture) {
                                                    setState(() {
                                                      _departureController
                                                          .text = data[i].name;
                                                      _departureIdController
                                                          .text = data[i].id;
                                                    });
                                                  } else {
                                                    setState(() {
                                                      _arrivalController.text =
                                                          data[i].name;
                                                      _arrivalIdController
                                                          .text = data[i].id;
                                                    });
                                                  }
                                                  Navigator.of(context).pop();
                                                },
                                                child: Row(
                                                  children: [
                                                    const Icon(
                                                        Icons.arrow_right),
                                                    Text(data[i].name),
                                                  ],
                                                ),
                                              ))),
                            ],
                          );
                        },
                      ),
                    ),
                    actions: [],
                  ));
        });
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

class TextFieldContainer2 extends StatelessWidget {
  final Widget child;

  const TextFieldContainer2({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      width: size.width * 0.45,
      height: 60,
      decoration: BoxDecoration(
        color: const Color(0xffe5e5e5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}
