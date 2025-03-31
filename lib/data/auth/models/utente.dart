class Utente {
  final String? token;
  final String? username;
  final String? password;
  final String? refreshDate;

  const Utente({
    this.token,
    this.username,
    this.password,
    this.refreshDate,
  });

  Map<String, dynamic> toJson() => {
        'token': token,
        'username': username,
        'password': password,
        'refreshDate': refreshDate,
      };

  factory Utente.fromJson(Map<String, dynamic> json) => Utente(
        token: json["token"],
        username: json["username"],
        password: json["password"],
        refreshDate: json["refreshDate"],
      );

  Utente copyWith({
    String? token,
    String? username,
    String? password,
    String? refreshDate,
  }) {
    return Utente(
      token: token ?? this.token,
      username: username ?? this.username,
      password: password ?? this.password,
      refreshDate: refreshDate ?? this.refreshDate,
    );
  }
}
