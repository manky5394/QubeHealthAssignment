import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qube_health_assignment/common/strings.dart';
import 'package:qube_health_assignment/controller/feeling_history_controller.dart';
import 'package:qube_health_assignment/ui/feelings_history/widgets/calendar_week_view.dart';
import 'package:qube_health_assignment/ui/feelings_history/widgets/feeling_list_with_time.dart';
import 'package:qube_health_assignment/ui/feelings_history/widgets/feelings_prcentage.dart';
import 'package:qube_health_assignment/ui/feelings_history/widgets/recommended_videos.dart';

class UserFeelingsHistory extends StatefulWidget {
  final String? enteredDate;
  const UserFeelingsHistory({this.enteredDate, Key? key}) : super(key: key);

  @override
  State<UserFeelingsHistory> createState() => _UserFeelingsHistoryState();
}

class _UserFeelingsHistoryState extends State<UserFeelingsHistory> {
  final FeelingHistoryController _feelingHistoryController =
      Get.find<FeelingHistoryController>();

  @override
  void initState() {
    connect();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Padding(
              padding: EdgeInsets.zero,
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
          ),
          centerTitle: true,
          title: const Text(
            Strings.yourFeelingsHistoryTitle,
            style: TextStyle(
                fontSize: 24.0,
                fontFamily: 'SF-Pro-Rounded',
                color: Colors.black,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.normal),
          ),
        ),
        body: Obx(() {
          return _feelingHistoryController.isLoading.isTrue
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.green,
                  ),
                )
              : SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const FeelingsPercentage(),
                        const SizedBox(height: 24.0),
                        createDivider(),
                        const SizedBox(height: 24.0),
                        CalendarWeekView(enteredDate: widget.enteredDate),
                        const SizedBox(height: 24.0),
                        createDivider(),
                        const SizedBox(height: 24.0),
                        const FeelingListWithTime(),
                        const SizedBox(height: 24.0),
                        createDivider(),
                        const SizedBox(height: 24.0),
                        const RecommendedVideos()
                      ],
                    ),
                  ),
                );
        }),
      ),
    );
  }

  Widget createDivider() {
    return Opacity(
      opacity: 0.2,
      child: Container(width: Get.width, height: 1, color: Colors.black),
    );
  }

  ///connect method will be called and request will be sent to
  ///the server to retrieve the data and get the response
  Future<void> connect() async {
    await _feelingHistoryController
        .getUserFeelingsHistoryList(widget.enteredDate.toString());
  }
}
