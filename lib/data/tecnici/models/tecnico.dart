import 'dart:convert';

class TecnicoModel {
  final String id;
  final String codice;
  final String nome;
  final String stato; // Al lavoro, Non al lavoro, Al magazzino
  final String?
      macchinaId; // Può essere null se il tecnico non è al lavoro su una macchina

  TecnicoModel({
    required this.id,
    required this.codice,
    required this.nome,
    required this.stato,
    this.macchinaId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'codice': codice,
      'nome': nome,
      'stato': stato,
      'macchinaId': macchinaId
    };
  }

  factory TecnicoModel.fromMap(Map<String, dynamic> map) {
    return TecnicoModel(
      id: map['relationships']['actor']['data']['id'] ?? '',
      codice: map['attributes']['code'] ?? '',
      nome: map['attributes']['code'] ?? '',
      stato: map['attributes']['statusCode'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TecnicoModel.fromJson(String source) =>
      TecnicoModel.fromMap(json.decode(source));
}
