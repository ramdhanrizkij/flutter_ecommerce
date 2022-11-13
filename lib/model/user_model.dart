class UserModel {
  int? id;
  String? name;
  String? email;
  String? username;
  String? token;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.username,
    this.token,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    username = json['username'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'username': username,
      'token': token,
    };
  }
}
