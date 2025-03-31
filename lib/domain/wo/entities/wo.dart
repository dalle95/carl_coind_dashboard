import 'dart:convert';

import 'package:carl_coind_dashboard/domain/macchine/entities/macchina.dart';
import 'package:carl_coind_dashboard/domain/tecnici/entities/tecnico.dart';
import 'package:flutter/widgets.dart';

import 'package:carl_coind_dashboard/core/entity/macchina.dart';
import 'package:carl_coind_dashboard/domain/linee/entities/linea.dart';

class WOEntity {
  final String? id;
  final String? codice;
  final String? descrizione;
  final String? natura;
  final String? puntoDiStrutturaId;
  final LineaEntity? puntoDiStruttura;
  final String? impiantoId;
  final MacchinaEntity? impianto;
  final DateTime? dataCreazione;
  final DateTime? dataInizio;
  final DateTime? dataFine;
  final String? assegnatoAId;
  final TecnicoEntity? assegnatoA;
  final String? stato;
  final String? statoMacchina;
  final String? operatoreLinea;
  final String? tipoIntervento;
  final String? note;
  final List<TecnicoEntity> tecnici;

  const WOEntity({
    this.id,
    this.codice,
    this.descrizione,
    this.natura,
    this.puntoDiStrutturaId,
    this.puntoDiStruttura,
    this.impiantoId,
    this.impianto,
    this.dataCreazione,
    this.dataInizio,
    this.dataFine,
    this.assegnatoAId,
    this.assegnatoA,
    this.stato,
    this.statoMacchina,
    this.operatoreLinea,
    this.tipoIntervento,
    this.note,
    this.tecnici = const [],
  });

  factory WOEntity.empty() {
    return const WOEntity(
      id: null,
      codice: '',
      descrizione: '',
      dataInizio: null,
      dataFine: null,
      natura: '',
      puntoDiStrutturaId: '',
      impiantoId: '',
      dataCreazione: null,
      assegnatoAId: '',
      assegnatoA: null,
      stato: '',
      statoMacchina: '',
      operatoreLinea: '',
      tipoIntervento: '',
    );
  }

  WOEntity copyWith({
    ValueGetter<String?>? id,
    ValueGetter<String?>? codice,
    ValueGetter<String?>? descrizione,
    ValueGetter<String?>? natura,
    ValueGetter<String?>? puntoDiStrutturaId,
    LineaEntity? puntoDiStruttura,
    ValueGetter<String?>? impiantoId,
    MacchinaEntity? impianto,
    ValueGetter<DateTime?>? dataCreazione,
    ValueGetter<DateTime?>? dataInizio,
    ValueGetter<DateTime?>? dataFine,
    ValueGetter<String?>? assegnatoAId,
    TecnicoEntity? assegnatoA,
    String? stato,
    ValueGetter<String?>? statoMacchina,
    ValueGetter<String?>? operatoreLinea,
    ValueGetter<String?>? tipoIntervento,
    String? note,
    List<TecnicoEntity>? tecnici,
  }) {
    return WOEntity(
      id: id != null ? id() : this.id,
      codice: codice != null ? codice() : this.codice,
      descrizione: descrizione != null ? descrizione() : this.descrizione,
      natura: natura != null ? natura() : this.natura,
      puntoDiStrutturaId: puntoDiStrutturaId != null
          ? puntoDiStrutturaId()
          : this.puntoDiStrutturaId,
      puntoDiStruttura: puntoDiStruttura ?? this.puntoDiStruttura,
      impiantoId: impiantoId != null ? impiantoId() : this.impiantoId,
      impianto: impianto ?? this.impianto,
      dataCreazione:
          dataCreazione != null ? dataCreazione() : this.dataCreazione,
      dataInizio: dataInizio != null ? dataInizio() : this.dataInizio,
      dataFine: dataFine != null ? dataFine() : this.dataFine,
      assegnatoAId: assegnatoAId != null ? assegnatoAId() : this.assegnatoAId,
      assegnatoA: assegnatoA ?? this.assegnatoA,
      stato: stato ?? this.stato,
      statoMacchina:
          statoMacchina != null ? statoMacchina() : this.statoMacchina,
      operatoreLinea:
          operatoreLinea != null ? operatoreLinea() : this.operatoreLinea,
      tipoIntervento:
          tipoIntervento != null ? tipoIntervento() : this.tipoIntervento,
      note: note ?? this.note,
      tecnici: tecnici ?? this.tecnici,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'codice': codice,
      'descrizione': descrizione,
      'natura': natura,
      'puntoDiStrutturaId': puntoDiStrutturaId,
      'puntoDiStruttura': puntoDiStruttura,
      'impiantoId': impiantoId,
      'impianto': impianto,
      'dataCreazione': dataCreazione?.millisecondsSinceEpoch,
      'dataInizio': dataInizio?.millisecondsSinceEpoch,
      'dataFine': dataFine?.millisecondsSinceEpoch,
      'assegnatoA': assegnatoAId,
      'stato': stato,
      'statoMacchina': statoMacchina,
      'operatoreLinea': operatoreLinea,
      'note': note,
      'tipoIntervento': tipoIntervento,
    };
  }

  factory WOEntity.fromMap(Map<String, dynamic> map) {
    return WOEntity(
      id: map['id'],
      codice: map['codice'],
      descrizione: map['descrizione'],
      natura: map['natura'],
      puntoDiStrutturaId: map['puntoDiStrutturaId'],
      puntoDiStruttura: map['puntoDiStruttura'],
      impiantoId: map['impiantoId'],
      impianto: map['impianto'],
      dataCreazione: map['dataCreazione'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['dataCreazione'])
          : null,
      dataInizio: map['dataInizio'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['dataInizio'])
          : null,
      dataFine: map['dataFine'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['dataFine'])
          : null,
      assegnatoAId: map['assegnatoA'],
      stato: map['stato'],
      statoMacchina: map['statoMacchina'],
      operatoreLinea: map['operatoreLinea'],
      note: map['note'],
      tipoIntervento: map['tipoIntervento'],
    );
  }

  String toJson() => json.encode(toMap());

  factory WOEntity.fromJson(String source) =>
      WOEntity.fromMap(json.decode(source));

  @override
  String toString() {
    return 'WOEntity(id: $id, codice: $codice, descrizione: $descrizione, natura: $natura, puntoDiStrutturaId: $puntoDiStrutturaId, puntoDiStruttura: $puntoDiStruttura, impiantoId: $impiantoId, impianto: $impianto, dataCreazione: $dataCreazione, dataInizio: $dataInizio, dataFine: $dataFine, assegnatoA: $assegnatoAId, stato: $stato, statoMacchina: $statoMacchina, operatoreLinea: $operatoreLinea)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WOEntity &&
        other.id == id &&
        other.codice == codice &&
        other.descrizione == descrizione &&
        other.natura == natura &&
        other.puntoDiStrutturaId == puntoDiStrutturaId &&
        other.puntoDiStruttura == puntoDiStruttura &&
        other.impiantoId == impiantoId &&
        other.impianto == impianto &&
        other.dataCreazione == dataCreazione &&
        other.dataInizio == dataInizio &&
        other.dataFine == dataFine &&
        other.assegnatoAId == assegnatoAId &&
        other.stato == stato &&
        other.statoMacchina == statoMacchina &&
        other.operatoreLinea == operatoreLinea;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        codice.hashCode ^
        descrizione.hashCode ^
        natura.hashCode ^
        puntoDiStrutturaId.hashCode ^
        puntoDiStruttura.hashCode ^
        impiantoId.hashCode ^
        impianto.hashCode ^
        dataCreazione.hashCode ^
        dataInizio.hashCode ^
        dataFine.hashCode ^
        assegnatoAId.hashCode ^
        stato.hashCode ^
        statoMacchina.hashCode ^
        operatoreLinea.hashCode;
  }
}
