class UserModel {
  final String? id;
  final String? fullname;
  final String? email;
  final String? image;
  final bool? isAdmin;
  UserModel({
    this.id,
    this.fullname,
    this.email,
    this.image,
    this.isAdmin,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullname': fullname,
      'email': email,
      'image': image,
      'isAdmin': isAdmin,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      fullname: map['fullname'],
      email: map['email'],
      image: map['image'],
      isAdmin: map['isAdmin'],
    );
  }
}
