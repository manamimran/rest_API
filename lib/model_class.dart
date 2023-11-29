class ModelClass {
  late  int id;
  late  String email;
  late  String firstName;
  late  String lastName;
  late  String avatar;

  ModelClass({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  ModelClass.fromJson(Map<String, dynamic> data){
    id = data['id'];
    email = data['email'];
    firstName = data['first_name'];
    lastName = data['last_name'];
    avatar = data['avatar'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['avatar'] = avatar;
    return data;
  }
}