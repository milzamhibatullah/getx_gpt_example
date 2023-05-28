class User {
  String? name;
  String? email;
  String? accToken;
  String? idToken;
  String? urlPhoto;

  User({this.name, this.email, this.accToken, this.idToken, this.urlPhoto});

  factory User.fromJson(Map<String, dynamic> json) => User(
      name: json['name'],
      email: json['email'],
      accToken: json['access_token'],
      idToken: json['id_token'],
      urlPhoto: json['url_photo']);

  static Map<String, dynamic> toJson(User model) => <String, dynamic>{
        'name': model.name,
        'email': model.email,
        'access_token': model.accToken,
        'id_token': model.idToken,
        'url_photo': model.urlPhoto
      };
}
