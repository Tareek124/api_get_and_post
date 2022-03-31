class Data {
  int? id;
  String? firstName, lastName, email, avatar;
  Data({this.id, this.avatar, this.firstName, this.lastName, this.email});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
        id: json['id'],
        email: json['email'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        avatar: json['avatar']);
  }
}

class GetUsers {
  List<Data>? myData;

  GetUsers({
    this.myData,
  });

  GetUsers.fromJson(Map<String, dynamic> json) {
    myData = <Data>[];
    json['data'].forEach((element) {
      myData!.add(Data.fromJson(element));
    });
  }
}
