import 'package:qube_health_assignment/data/model/response/feeling_list.dart';
import 'package:qube_health_assignment/data/model/response/feeling_percentage.dart';
import 'package:qube_health_assignment/data/model/response/video_arr.dart';

class Data {
  FeelingPercentage? feelingPercentage;
  List<FeelingList>? feelingList;
  List<VideoArr>? videoArr;

  Data({this.feelingPercentage, this.feelingList, this.videoArr});

  Data.fromJson(Map<String, dynamic> json) {
    feelingPercentage = json['feeling_percentage'] != null
        ? FeelingPercentage.fromJson(json['feeling_percentage'])
        : null;
    if (json['feeling_list'] != null) {
      feelingList = <FeelingList>[];
      json['feeling_list'].forEach((v) {
        feelingList!.add(FeelingList.fromJson(v));
      });
    }
    if (json['video_arr'] != null) {
      videoArr = <VideoArr>[];
      json['video_arr'].forEach((v) {
        videoArr!.add(VideoArr.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (feelingPercentage != null) {
      data['feeling_percentage'] = feelingPercentage!.toJson();
    }
    if (feelingList != null) {
      data['feeling_list'] = feelingList!.map((v) => v.toJson()).toList();
    }
    if (videoArr != null) {
      data['video_arr'] = videoArr!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
