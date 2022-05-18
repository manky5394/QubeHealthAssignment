import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qube_health_assignment/controller/feeling_history_controller.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class RecommendedVideos extends StatefulWidget {
  const RecommendedVideos({Key? key}) : super(key: key);

  @override
  State<RecommendedVideos> createState() => _RecommendedVideosState();
}

class _RecommendedVideosState extends State<RecommendedVideos> {
  late YoutubePlayerController controller;
  final FeelingHistoryController _feelingHistoryController =
      Get.find<FeelingHistoryController>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      String? url = _feelingHistoryController
          .rxUserFeelingResponse.value.data?.videoArr?[0].youtubeUrl;
      controller = YoutubePlayerController(
          initialVideoId: YoutubePlayer.convertUrlToId(url!)!,
          flags: const YoutubePlayerFlags(
              autoPlay: false, mute: false, loop: false));
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                displayText(
                    _feelingHistoryController
                        .rxUserFeelingResponse.value.data?.videoArr?[0].title,
                    Colors.black,
                    18.0),
                const SizedBox(
                  height: 10.0,
                ),
                Opacity(
                  opacity: 0.7,
                  child: displayText(
                      _feelingHistoryController.rxUserFeelingResponse.value.data
                          ?.videoArr?[0].description,
                      Colors.black,
                      14.0),
                ),
                const SizedBox(
                  height: 24.0,
                ),
                YoutubePlayerBuilder(
                  player: YoutubePlayer(
                    controller: controller,
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: Colors.grey,
                    width: Get.width * 0.50,
                  ),
                  builder: (context, player) {
                    return player;
                  },
                )
              ],
            ),
          ],
        ),
      );
    });
  }

  ///common method to create a text widget as per the required arguments
  Widget displayText(String? displayText, Color textColor, double fontSize) {
    return Text(
      displayText!,
      style: TextStyle(
          color: textColor,
          fontSize: fontSize,
          fontWeight: FontWeight.normal,
          fontFamily: "SF-Pro-Rounded"),
    );
  }
}
