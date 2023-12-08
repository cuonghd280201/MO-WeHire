class Skills {
  int? skillId;
  String? skillName;
  String? skillDescription;
  String? statusString;

  Skills(
      {this.skillId, this.skillName, this.skillDescription, this.statusString});

  Skills.fromJson(Map<String, dynamic> json) {
    skillId = json['skillId'];
    skillName = json['skillName'];
    skillDescription = json['skillDescription'];
    statusString = json['statusString'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['skillId'] = this.skillId;
    data['skillName'] = this.skillName;
    data['skillDescription'] = this.skillDescription;
    data['statusString'] = this.statusString;
    return data;
  }
}
