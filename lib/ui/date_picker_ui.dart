import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qube_health_assignment/common/strings.dart';
import 'package:qube_health_assignment/ui/feelings_history/page/user_feelings_history.dart';

///this class is responsible to pik a date from user and
///look up for the relative details for that that particular date
class DatePickerUi extends StatefulWidget {
  const DatePickerUi({Key? key}) : super(key: key);

  @override
  State<DatePickerUi> createState() => _DatePickerUiState();
}

class _DatePickerUiState extends State<DatePickerUi> {
  final TextEditingController _textEditingControllerDate =
      TextEditingController();
  String date = "";
  DateTime selectedDate = DateTime.now();
  var connectivityResult;

  @override
  void initState() {
    checkUserConnection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text(
            Strings.enterDate,
            style: TextStyle(
                fontSize: 24.0,
                fontFamily: 'SF-Pro-Rounded',
                color: Colors.black,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.normal),
          ),
        ),
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: _textEditingControllerDate,
                  decoration: InputDecoration(
                    filled: true,
                    labelText: Strings.labelTextValue,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6.0),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6.0),
                      borderSide: BorderSide(color: Colors.grey.shade700),
                    ),
                    labelStyle: TextStyle(
                        color: Colors.grey.shade900,
                        fontFamily: "SF-Pro_rounded"),
                    hintStyle: const TextStyle(fontFamily: 'SF-Pro-Rounded'),
                  ),
                  onTap: () {
                    _selectDate(context);
                  },
                  enabled: true,
                  autofocus: false,
                  enableSuggestions: false,
                  readOnly: true,
                ),
              ),
              TextButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: const BorderSide(color: Colors.grey)))),
                onPressed: () async {
                  if (connectivityResult == ConnectivityResult.mobile ||
                      connectivityResult == ConnectivityResult.wifi) {
                    if (_textEditingControllerDate.text.isNotEmpty) {
                      Get.to(UserFeelingsHistory(
                        enteredDate: _textEditingControllerDate.text,
                      ));
                      FocusScope.of(context).unfocus();
                      _textEditingControllerDate.clear();
                    } else {
                      Get.snackbar('Date Missing', 'Enter date to proceed');
                    }
                  } else {
                    Get.snackbar('Internet Unavailable',
                        'Connect to the Internet to proceed');
                  }
                },
                child: const Text(
                  'Search History',
                  style: TextStyle(
                      fontSize: 14.0,
                      fontFamily: 'SF-Pro-Rounded',
                      color: Colors.black,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.normal),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  ///this method will look whether the
  ///device is connected to the Internet or not
  Future checkUserConnection() async {
    try {
      var connectivityState = await (Connectivity().checkConnectivity());
      setState(() {
        connectivityResult = connectivityState;
      });
    } on SocketException catch (_) {}
  }

  ///this method will open a date picker and
  ///update the Field with the selected date
  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime.now(),
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
        _textEditingControllerDate.text =
            DateFormat("yyyy-MM-dd").format(selectedDate);
      });
    }
  }
}
