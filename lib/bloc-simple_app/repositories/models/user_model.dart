class User {
  String? balance;
  String? picture;
  int? age;
  String? name;
  String? gender;
  String? company;
  String? email;

  User(
      {this.balance,
      this.picture,
      this.age,
      this.name,
      this.gender,
      this.company,
      this.email});

  User.fromJson(Map<String, dynamic> json) {
    balance = json['balance'];
    picture = json['picture'];
    age = json['age'];
    name = json['name'];
    gender = json['gender'];
    company = json['company'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['balance'] = balance;
    data['picture'] = picture;
    data['age'] = age;
    data['name'] = name;
    data['gender'] = gender;
    data['company'] = company;
    data['email'] = email;
    return data;
  }

  @override
  String toString() {
    return 'User - $name';
  }
}