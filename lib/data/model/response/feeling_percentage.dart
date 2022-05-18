class FeelingPercentage {
  String? happy;
  String? sad;
  String? energetic;
  String? calm;
  String? angry;
  String? bored;

  FeelingPercentage(
      {this.happy,
      this.sad,
      this.energetic,
      this.calm,
      this.angry,
      this.bored});

  FeelingPercentage.fromJson(Map<String, dynamic> json) {
    happy = json['Happy'];
    sad = json['Sad'];
    energetic = json['Energetic'];
    calm = json['Calm'];
    angry = json['Angry'];
    bored = json['Bored'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Happy'] = happy;
    data['Sad'] = sad;
    data['Energetic'] = energetic;
    data['Calm'] = calm;
    data['Angry'] = angry;
    data['Bored'] = bored;
    return data;
  }
}
