class User{

  String? name;
  String? genre;
  int? value;

  User({this.name, this.genre, this.value});

  factory User.instance() => User();

  Map<String, dynamic> toMap(){
    return {
      'name': name,
      'genre': genre,
      'value': value
    };
  }

  User fromMap(Map json) =>
      User(name: json['name'], genre: json['genre'],value: json['value']);
}