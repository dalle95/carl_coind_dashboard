import 'dart:convert';

class MacchinaModel {
  final String id;
  final String codice;
  final String descrizione;
  final String stato;
  final String? lineaId;

  MacchinaModel({
    required this.id,
    required this.codice,
    required this.descrizione,
    required this.stato,
    this.lineaId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'codice': codice,
      'nome': descrizione,
      'stato': stato,
      'lineaId': lineaId,
    };
  }

  factory MacchinaModel.fromMap(Map<String, dynamic> map) {
    return MacchinaModel(
      id: map['id'] ?? '',
      codice: map['attributes']['code'] ?? '',
      descrizione: map['attributes']['code'] ?? '',
      stato: map['attributes']['statusCode'] ?? '',
      lineaId: null,
    );
  }

  String toJson() => json.encode(toMap());

  factory MacchinaModel.fromJson(String source) =>
      MacchinaModel.fromMap(json.decode(source));
}
