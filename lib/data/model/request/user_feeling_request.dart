class UserFeelingRequest {
  int? userId;
  String? feelingDate;

  UserFeelingRequest({this.userId, this.feelingDate});

  UserFeelingRequest.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    feelingDate = json['feeling_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['feeling_date'] = feelingDate;
    return data;
  }
}
