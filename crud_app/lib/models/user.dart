class User {
  num? id;
  String firstName;
  String lastName;
  String email;
  String? phoneNumber;
  String? zipCode;
  User(
      {required this.firstName,
      required this.lastName,
      required this.email,
      this.phoneNumber,
      this.zipCode,
      this.id});
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      zipCode: json['zipCode'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'zipCode': zipCode,
    };
  }
}
