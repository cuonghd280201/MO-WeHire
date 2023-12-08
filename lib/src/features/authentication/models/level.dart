class Level {
  int? levelId;
  String? levelName;
  String? levelDescription;
  String? statusString;

  Level(
      {this.levelId, this.levelName, this.levelDescription, this.statusString});

  Level.fromJson(Map<String, dynamic> json) {
    levelId = json['levelId'];
    levelName = json['levelName'];
    levelDescription = json['levelDescription'];
    statusString = json['statusString'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['levelId'] = this.levelId;
    data['levelName'] = this.levelName;
    data['levelDescription'] = this.levelDescription;
    data['statusString'] = this.statusString;
    return data;
  }
}
