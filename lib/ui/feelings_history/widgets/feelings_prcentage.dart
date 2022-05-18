import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qube_health_assignment/common/assets.dart';
import 'package:qube_health_assignment/common/strings.dart';
import 'package:qube_health_assignment/controller/feeling_history_controller.dart';
import 'package:qube_health_assignment/data/model/response/feeling_percentage.dart';

class FeelingsPercentage extends StatefulWidget {
  const FeelingsPercentage({Key? key}) : super(key: key);

  @override
  State<FeelingsPercentage> createState() => _FeelingsPercentageState();
}

class _FeelingsPercentageState extends State<FeelingsPercentage> {
  final FeelingHistoryController _feelingHistoryController =
      Get.find<FeelingHistoryController>();
  FeelingPercentage? feelingsPercentage;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.14,
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Text(
            Strings.yourFeelingsHistory30Days,
            style: TextStyle(
                fontSize: 16.0,
                fontFamily: 'SF-Pro-Rounded',
                color: Colors.black,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.normal),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Expanded(flex: 2, child: createFeelingListView()),
        ],
      ),
    );
  }

  ///this method will return the combine UI for the
  ///feeling % according to their respective reaction image
  Widget createFeelingListView() {
    return Obx(
      () {
        return Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            createFeelingView(
                ImageAsset.energeticIcon2x,
                _feelingHistoryController.rxUserFeelingResponse.value.data!
                    .feelingPercentage?.energetic,
                Strings.energeticLabel),
            createFeelingView(
                ImageAsset.sadIcon2x,
                _feelingHistoryController
                    .rxUserFeelingResponse.value.data!.feelingPercentage?.sad,
                Strings.sadLabel),
            createFeelingView(
                ImageAsset.happyIcon2x,
                _feelingHistoryController
                    .rxUserFeelingResponse.value.data!.feelingPercentage?.happy,
                Strings.happyLabel),
            createFeelingView(
                ImageAsset.angryIcon2x,
                _feelingHistoryController
                    .rxUserFeelingResponse.value.data!.feelingPercentage?.angry,
                Strings.angryLabel),
            createFeelingView(
                ImageAsset.calmIcon2x,
                _feelingHistoryController
                    .rxUserFeelingResponse.value.data!.feelingPercentage?.calm,
                Strings.calmLabel),
            createFeelingView(
                ImageAsset.boredIcon2x,
                _feelingHistoryController
                    .rxUserFeelingResponse.value.data!.feelingPercentage?.bored,
                Strings.boredLabel),
            createFeelingView(
                ImageAsset.loveIcon2x,
                _feelingHistoryController
                    .rxUserFeelingResponse.value.data!.feelingPercentage?.happy,
                Strings.loveLabel),
          ],
        );
      },
    );
  }
}

///this method will map the data returned from the API response
///and will handle Widget visibility accordingly, if response from the API
///for some feeling is "0" then that particular widget will be shown disabled
///else it will be shown enable with the appropriate value mapped with it's Icon
Widget createFeelingView(
    String iconPath, String? feelingValue, String feelingLabel) {
  String visibleFeelingValue = feelingValue == '0' ? '' : '$feelingValue%';
  return Opacity(
    opacity: feelingValue == "0" ? 0.4 : 1.0,
    child: Column(
      children: [
        Expanded(
          child: Card(
            elevation: feelingValue == "0" ? 0.0 : 5.0,
            semanticContainer: true,
            color: Color(int.parse('0xffF1F2F3')),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    flex: 1,
                    child: Center(
                        child: Text(
                      visibleFeelingValue,
                      style: const TextStyle(
                          fontSize: 12.0,
                          fontFamily: 'SF-Pro-Rounded',
                          color: Colors.black,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.normal),
                    ))),
                Expanded(
                  flex: 1,
                  child: Container(
                    decoration: const ShapeDecoration(
                      color: Color(0xff85C454),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                      ),
                    ),
                    //backgroundColor: Color(int.parse('0xff85C454')),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset(
                        iconPath,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Text(
          feelingLabel,
          style: const TextStyle(
              fontSize: 12.0,
              fontFamily: 'SF-Pro-Rounded',
              color: Colors.black,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.normal),
        )
      ],
    ),
  );
}
