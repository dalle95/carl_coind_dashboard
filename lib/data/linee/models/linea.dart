import 'dart:convert';

class LineaModel {
  final String id;
  final String codice;
  final String descrizione;
  final String stato;

  LineaModel({
    required this.id,
    required this.codice,
    required this.descrizione,
    required this.stato,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'codice': codice,
      'nome': descrizione,
      'stato': stato,
    };
  }

  factory LineaModel.fromMap(Map<String, dynamic> map) {
    return LineaModel(
      id: map['id'] ?? '',
      codice: map['attributes']['code'] ?? '',
      descrizione: map['attributes']['code'] ?? '',
      stato: map['attributes']['statusCode'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory LineaModel.fromJson(String source) =>
      LineaModel.fromMap(json.decode(source));
}
