import 'dart:convert';

import 'package:flutter/foundation.dart';

import '/domain/wo/entities/wo.dart';

class LineaEntity {
  final String id;
  final String codice;
  final String descrizione;
  final String stato;
  final List<WOEntity> woCambioStato;

  LineaEntity({
    required this.id,
    required this.codice,
    required this.descrizione,
    required this.stato,
    this.woCambioStato = const [],
  });

  LineaEntity copyWith({
    String? id,
    String? codice,
    String? descrizione,
    String? stato,
    List<WOEntity>? woCambioStato,
  }) {
    return LineaEntity(
      id: id ?? this.id,
      codice: codice ?? this.codice,
      descrizione: descrizione ?? this.descrizione,
      stato: stato ?? this.stato,
      woCambioStato: woCambioStato ?? this.woCambioStato,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'codice': codice,
      'descrizione': descrizione,
      'stato': stato,
      'woCambioStato': woCambioStato.map((x) => x.toMap()).toList(),
    };
  }

  factory LineaEntity.fromMap(Map<String, dynamic> map) {
    return LineaEntity(
      id: map['id'] ?? '',
      codice: map['codice'] ?? '',
      descrizione: map['descrizione'] ?? '',
      stato: map['stato'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory LineaEntity.fromJson(String source) =>
      LineaEntity.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LineaEntity(id: $id, codice: $codice, descrizione: $descrizione, stato: $stato, woCambioStato: $woCambioStato)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LineaEntity &&
        other.id == id &&
        other.codice == codice &&
        other.descrizione == descrizione &&
        other.stato == stato &&
        listEquals(other.woCambioStato, woCambioStato);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        codice.hashCode ^
        descrizione.hashCode ^
        stato.hashCode ^
        woCambioStato.hashCode;
  }
}
