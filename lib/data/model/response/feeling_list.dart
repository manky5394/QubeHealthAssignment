class FeelingList {
  String? userFeelingId;
  String? feelingId;
  String? feelingName;
  String? submitTime;

  FeelingList(
      {this.userFeelingId, this.feelingId, this.feelingName, this.submitTime});

  FeelingList.fromJson(Map<String, dynamic> json) {
    userFeelingId = json['user_feeling_id'];
    feelingId = json['feeling_id'];
    feelingName = json['feeling_name'];
    submitTime = json['submit_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_feeling_id'] = userFeelingId;
    data['feeling_id'] = feelingId;
    data['feeling_name'] = feelingName;
    data['submit_time'] = submitTime;
    return data;
  }
}
