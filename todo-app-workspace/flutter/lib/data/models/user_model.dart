class UserModel {
  final int id;
  final String name;
  final String email;

  UserModel(this.id, this.name, this.email);

  factory UserModel.fromJson(Map<String, dynamic> json){
    var id = json['id'];
    var name = json['name'];
    var email = json['email'];

    return UserModel(id, name, email);
  }
}