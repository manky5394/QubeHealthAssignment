import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CalendarWeekView extends StatefulWidget {
  final String? enteredDate;
  const CalendarWeekView({this.enteredDate, Key? key}) : super(key: key);

  @override
  State<CalendarWeekView> createState() => _CalendarWeekViewState();
}

class _CalendarWeekViewState extends State<CalendarWeekView> {
  Map<String, DateTimeWithHighlighter> dateMapping = {};
  @override
  void initState() {
    super.initState();
    getDayAsPerDate(widget.enteredDate!);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.14,
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
              color: Color(int.parse("0xffC6E5F7")),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                getFormattedDate(widget.enteredDate!),
                style: const TextStyle(
                    fontSize: 12.0,
                    fontFamily: 'SF-Pro-Rounded',
                    color: Colors.black,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Expanded(child: createCalendarWeekView())
        ],
      ),
    );
  }

  ///this method will create a combine view for the weekly calendar
  ///and highlight the entered date for which the response has been
  ///received from the API and It's respective week is displayed on the UI
  Widget createCalendarWeekView() {
    DateFormat formatter = DateFormat('d');
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        createDateView(
            "Mo", formatter.format(dateMapping["Mo"]?.dateTime as DateTime),
            isEnteredDate: dateMapping["Mo"]?.isDateHighlighted as bool),
        createDateView(
            "Tu", formatter.format(dateMapping["Tu"]?.dateTime as DateTime),
            isEnteredDate: dateMapping["Tu"]?.isDateHighlighted as bool),
        createDateView(
            "We", formatter.format(dateMapping["We"]?.dateTime as DateTime),
            isEnteredDate: dateMapping["We"]?.isDateHighlighted as bool),
        createDateView(
            "Th", formatter.format(dateMapping["Th"]?.dateTime as DateTime),
            isEnteredDate: dateMapping["Th"]?.isDateHighlighted as bool),
        createDateView(
            "Fr", formatter.format(dateMapping["Fr"]?.dateTime as DateTime),
            isEnteredDate: dateMapping["Fr"]?.isDateHighlighted as bool),
        createDateView(
            "Sa", formatter.format(dateMapping["Sa"]?.dateTime as DateTime),
            isEnteredDate: dateMapping["Sa"]?.isDateHighlighted as bool),
        createDateView(
            "Su", formatter.format(dateMapping["Su"]?.dateTime as DateTime),
            isEnteredDate: dateMapping["Su"]?.isDateHighlighted as bool),
      ],
    );
  }

  ///this method will give us the first date of the week
  ///when teh entered date is passed to it
  DateTime findFirstDateOfTheWeek(DateTime dateTime) {
    return dateTime.subtract(Duration(days: dateTime.weekday - 1));
  }

  ///this method will create a map and add the week accordingly
  ///to the map so that we can bind it to the UI
  void getDayAsPerDate(String enteredDate) {
    var dayNumber = DateTime.parse(enteredDate);
    var weekDayNumber = dayNumber.weekday;
    dayNumber = findFirstDateOfTheWeek(dayNumber);
    dateMapping["Mo"] =
        DateTimeWithHighlighter(dateTime: dayNumber, isDateHighlighted: true);
    dateMapping["Tu"] = DateTimeWithHighlighter(
        dateTime: dayNumber.add(const Duration(days: 1)),
        isDateHighlighted: false);
    dateMapping["We"] = DateTimeWithHighlighter(
        dateTime: dayNumber.add(const Duration(days: 2)),
        isDateHighlighted: false);
    dateMapping["Th"] = DateTimeWithHighlighter(
        dateTime: dayNumber.add(const Duration(days: 3)),
        isDateHighlighted: false);
    dateMapping["Fr"] = DateTimeWithHighlighter(
        dateTime: dayNumber.add(const Duration(days: 4)),
        isDateHighlighted: false);
    dateMapping["Sa"] = DateTimeWithHighlighter(
        dateTime: dayNumber.add(const Duration(days: 5)),
        isDateHighlighted: false);
    dateMapping["Su"] = DateTimeWithHighlighter(
        dateTime: dayNumber.add(const Duration(days: 6)),
        isDateHighlighted: false);

    for (String key in dateMapping.keys) {
      if (dateMapping[key]?.dateTime?.weekday == weekDayNumber) {
        dateMapping[key]?.isDateHighlighted = true;
      } else {
        dateMapping[key]?.isDateHighlighted = false;
      }
    }
  }

  ///this method will create a combine view for the week calendar displayed on the UI
  ///and highlight he entered date
  Widget createDateView(String dayName, String? date, {bool? isEnteredDate}) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: ShapeDecoration(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          color: isEnteredDate!
              ? Color(int.parse("0xff4F4F4F"))
              : Colors.transparent),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              dayName,
              style: TextStyle(
                  fontSize: 15.0,
                  fontFamily: 'SF-Pro-Rounded',
                  color: Color(int.parse("0xffA7A7A7")),
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.normal),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              date!,
              style: TextStyle(
                  fontSize: 15.0,
                  fontFamily: 'SF-Pro-Rounded',
                  color: isEnteredDate
                      ? Color(int.parse("0xffF1F2F3"))
                      : Color(int.parse("0xff121212")),
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.normal),
            ),
          )
        ],
      ),
    );
  }

  ///this method will give us the formatted date which
  ///will be displayed just above teh week calendar
  String getFormattedDate(String date) {
    return DateFormat("d MMM, yyyy").format(DateTime.parse(date));
  }
}

///Class will be used in the map to maintain the week and
///which date will be shown as highlighted
class DateTimeWithHighlighter {
  DateTime? dateTime;
  bool? isDateHighlighted;

  DateTimeWithHighlighter({this.dateTime, this.isDateHighlighted});
}
