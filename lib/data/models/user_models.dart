
class UserModel {
  String? name;
  String? email;
  String? number;

  UserModel({this.name, this.email, this.number});

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    number = json['number'];
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'number': number,
    };
  }
}
