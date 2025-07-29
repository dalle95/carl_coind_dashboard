import 'dart:convert';

import '/domain/tecnici/entities/tecnico.dart';
import '/domain/linee/entities/linea.dart';
import '/domain/macchine/entities/macchina.dart';

class WOModel {
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
  final String? cambioFormatoDa;
  final String? cambioFormatoA;

  const WOModel({
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
    this.cambioFormatoDa,
    this.cambioFormatoA,
  });

  factory WOModel.empty() {
    return const WOModel(
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
      stato: '',
      statoMacchina: '',
      operatoreLinea: '',
      tipoIntervento: '',
      note: '',
      puntoDiStruttura: null,
      impianto: null,
      assegnatoA: null,
      cambioFormatoDa: '',
      cambioFormatoA: '',
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
      'assegnatoAId': assegnatoAId,
      'assegnatoA': assegnatoA,
      'stato': stato,
      'statoMacchina': statoMacchina,
      'operatoreLinea': operatoreLinea,
      'tipoIntervento': tipoIntervento,
      'note': note,
      'cambioFormatoDa': cambioFormatoDa,
      'cambioFormatoA': cambioFormatoA,
    };
  }

  factory WOModel.fromMap(Map<String, dynamic> map) {
    return WOModel(
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
      dataFine: map['dataInizio'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['dataFine'])
          : null,
      assegnatoAId: map['assegnatoAId'],
      assegnatoA: map['assegnatoA'],
      stato: map['stato'],
      statoMacchina: map['statoMacchina'],
      operatoreLinea: map['operatoreLinea'],
      tipoIntervento: map['tipoIntervento'],
      note: map['note'],
      cambioFormatoDa: map['cambioFormatoDa'],
      cambioFormatoA: map['cambioFormatoA'],
    );
  }

  String toJson() => json.encode(toMap());

  factory WOModel.fromJson(String source) =>
      WOModel.fromMap(json.decode(source));
}
