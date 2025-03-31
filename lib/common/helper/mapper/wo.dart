import '/data/wo/models/wo.dart';
import '/domain/wo/entities/wo.dart';

class WOMapper {
  static WOEntity toEntity(WOModel wo) {
    return WOEntity(
      id: wo.id,
      codice: wo.codice,
      descrizione: wo.descrizione,
      natura: wo.natura,
      puntoDiStrutturaId: wo.puntoDiStrutturaId,
      puntoDiStruttura: wo.puntoDiStruttura,
      impiantoId: wo.impiantoId,
      impianto: wo.impianto,
      dataCreazione: wo.dataCreazione,
      dataInizio: wo.dataInizio,
      dataFine: wo.dataFine,
      assegnatoAId: wo.assegnatoAId,
      assegnatoA: wo.assegnatoA,
      stato: wo.stato,
      statoMacchina: wo.statoMacchina,
      operatoreLinea: wo.operatoreLinea,
      tipoIntervento: wo.tipoIntervento,
      note: wo.note,
    );
  }
}
