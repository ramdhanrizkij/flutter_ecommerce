class UserModel {
  int? id;
  String? firstName;
  String? lastName;
  String? email;
  String? username;
  String? image;
  String? token;

  UserModel({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.username,
    this.image,
    this.token,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    username = json['username'];
    image = json['image'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'username': username,
      'image': image,
      'token': token,
    };
  }
}
