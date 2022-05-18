import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qube_health_assignment/common/assets.dart';
import 'package:qube_health_assignment/common/strings.dart';
import 'package:qube_health_assignment/common/utils.dart';
import 'package:qube_health_assignment/controller/feeling_history_controller.dart';

class FeelingListWithTime extends StatefulWidget {
  const FeelingListWithTime({Key? key}) : super(key: key);

  @override
  State<FeelingListWithTime> createState() => _FeelingListWithTimeState();
}

class _FeelingListWithTimeState extends State<FeelingListWithTime> {
  final FeelingHistoryController _feelingHistoryController =
      Get.find<FeelingHistoryController>();
  Map<String, List<String>> timeMoodMapping = {};

  @override
  void initState() {
    if (_feelingHistoryController
            .rxUserFeelingResponse.value.data?.feelingList?.isNotEmpty ??
        true) {
      getFeelingTimeRange(
          _feelingHistoryController
              .rxUserFeelingResponse.value.data?.feelingList![0].submitTime,
          _feelingHistoryController
              .rxUserFeelingResponse.value.data?.feelingList![0].feelingName);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return _feelingHistoryController
                  .rxUserFeelingResponse.value.data?.feelingList!.isEmpty ??
              true
          ? const SizedBox.shrink()
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                children: [
                  createTimeSlotContainer(
                      timeSlots[0], timeMoodMapping["9 AM - 12 PM"]?[0]),
                  createTimeSlotContainer(
                      timeSlots[1], timeMoodMapping["12 PM - 3 PM"]?[0]),
                  createTimeSlotContainer(
                      timeSlots[2], timeMoodMapping["3 PM - 6 PM"]?[0]),
                  createTimeSlotContainer(
                      timeSlots[3], timeMoodMapping["6 PM - 9 PM"]?[0])
                ],
              ),
            );
    });
  }

  ///this method will give us the combine UI for
  ///the time slot and the feeling for that time slot
  Widget createTimeSlotContainer(String timeSlot, String? moodName) {
    return moodName?.isEmpty ?? true
        ? const SizedBox.shrink()
        : Row(
            children: [
              Text(
                timeSlot,
                style: const TextStyle(
                    fontSize: 12.0,
                    fontFamily: 'SF-Pro-Rounded',
                    color: Colors.black,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.normal),
              ),
              const SizedBox(
                width: 30.0,
              ),
              Row(
                children: [
                  Image.asset(setImage(moodName.toString())),
                  const SizedBox(
                    width: 3.0,
                  ),
                  Text(
                    moodName.toString(),
                    style: const TextStyle(
                        fontSize: 14.0,
                        fontFamily: 'SF-Pro-Rounded',
                        color: Colors.black,
                        decoration: TextDecoration.none,
                        fontWeight: FontWeight.normal),
                  )
                ],
              )
            ],
          );
  }

  ///this method will help us to find the time slot for
  ///the specific feeling submitted by the user for the given time
  getFeelingTimeRange(String? dateTime, String? moodName) {
    if (dateTime.toString().isNotEmpty &&
        moodName.toString().isNotEmpty == true) {
      DateTime dateTimeValue = DateTime.parse(dateTime.toString());
      TimeOfDay timeOfDay = TimeOfDay.fromDateTime(dateTimeValue);
      if (9 <= timeOfDay.hour && timeOfDay.hour < 12) {
        timeMoodMapping["9 AM - 12 PM"] = [moodName.toString()];
        return;
      } else if (timeOfDay.hour >= 12 && timeOfDay.hour < 15) {
        timeMoodMapping["12 PM - 3 PM"] = [moodName.toString()];
        return;
      } else if (timeOfDay.hour >= 15 && timeOfDay.hour < 18) {
        timeMoodMapping["3 PM - 6 PM"] = [moodName.toString()];
        return;
      } else if (timeOfDay.hour >= 18 && timeOfDay.hour < 21) {
        timeMoodMapping["6 PM - 9 PM"] = [moodName.toString()];
        return;
      }
    }
  }

  ///this method will give us the image as per the feeling
  String setImage(String? feelingName) {
    String imagePath = '';
    if (feelingName == Strings.energeticLabel) {
      imagePath = ImageAsset.energeticIcon;
    } else if (feelingName == Strings.sadLabel) {
      imagePath = ImageAsset.sadIcon;
    } else if (feelingName == Strings.happyLabel) {
      imagePath = ImageAsset.happyIcon;
    } else if (feelingName == Strings.angryLabel) {
      imagePath = ImageAsset.angryIcon;
    } else if (feelingName == Strings.calmLabel) {
      imagePath = ImageAsset.calmIcon;
    } else if (feelingName == Strings.boredLabel) {
      imagePath = ImageAsset.boredIcon;
    } else if (feelingName == Strings.loveLabel) {
      imagePath = ImageAsset.loveIcon;
    }
    return imagePath;
  }
}

///Class will be used in the map to
///maintain the mood and time slot
class TimeMoodMapping {
  String? moodValue;

  TimeMoodMapping({this.moodValue});
}
