class VideoArr {
  String? title;
  String? description;
  String? youtubeUrl;

  VideoArr({this.title, this.description, this.youtubeUrl});

  VideoArr.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    youtubeUrl = json['youtube_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['youtube_url'] = youtubeUrl;
    return data;
  }
}
