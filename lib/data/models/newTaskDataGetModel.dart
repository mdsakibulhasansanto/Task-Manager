class NewTaskDataGetModel {
  String? id;
  String? date;
  String? sub;
  String? des;

  NewTaskDataGetModel({this.id, this.date, this.sub, this.des});

  NewTaskDataGetModel.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString() ?? '';
    date = json['date']?.toString() ?? '';
    sub = json['sub']?.toString() ?? '';
    des = json['des']?.toString() ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id ?? '';
    data['date'] = date ?? '';
    data['sub'] = sub ?? '';
    data['des'] = des ?? '';
    return data;
  }
}
