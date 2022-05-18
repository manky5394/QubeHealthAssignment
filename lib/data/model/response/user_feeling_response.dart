import 'package:qube_health_assignment/data/model/response/data.dart';

class UserFeelingResponse {
  String? status;
  Data? data;

  UserFeelingResponse({this.status, this.data});

  UserFeelingResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
