import 'dart:convert';

class LegameModel {
  final String id;
  final String? lineaId;
  final String? macchinaId;
  final int ordine;

  LegameModel({
    required this.id,
    this.lineaId,
    this.macchinaId,
    required this.ordine,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'lineaId': lineaId,
      'macchinaId': macchinaId,
      'ordine': ordine,
    };
  }

  factory LegameModel.fromMap(Map<String, dynamic> map) {
    return LegameModel(
      id: map['id'] ?? '',
      lineaId: map['relationships']['parent']['data']['id'],
      macchinaId: map['relationships']['child']['data']['id'],
      ordine: map['attributes']['ordering']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory LegameModel.fromJson(String source) =>
      LegameModel.fromMap(json.decode(source));
}
