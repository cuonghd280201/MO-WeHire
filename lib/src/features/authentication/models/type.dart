class Types {
  int? typeId;
  String? typeName;
  String? typeDescription;
  String? statusString;

  Types({this.typeId, this.typeName, this.typeDescription, this.statusString});

  Types.fromJson(Map<String, dynamic> json) {
    typeId = json['typeId'];
    typeName = json['typeName'];
    typeDescription = json['typeDescription'];
    statusString = json['statusString'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['typeId'] = this.typeId;
    data['typeName'] = this.typeName;
    data['typeDescription'] = this.typeDescription;
    data['statusString'] = this.statusString;
    return data;
  }
}
