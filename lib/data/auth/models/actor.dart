import 'dart:convert';

class Actor {
  String? id;
  String? codice;
  String? nome;

  Actor({
    this.id,
    this.codice,
    this.nome,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'codice': codice,
      'nome': nome,
    };
  }

  factory Actor.fromMap(Map<String, dynamic> map) {
    return Actor(
      id: map['id'],
      codice: map['codice'],
      nome: map['nome'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Actor.fromJson(String source) => Actor.fromMap(json.decode(source));
}
