class UserModel {
  final String? fullname;
  final String? email;
  final String? image;
  UserModel({
    this.fullname,
    this.email,
    this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'fullname': fullname,
      'email': email,
      'image': image,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      fullname: map['fullname'],
      email: map['email'],
      image: map['image'],
    );
  }
}
