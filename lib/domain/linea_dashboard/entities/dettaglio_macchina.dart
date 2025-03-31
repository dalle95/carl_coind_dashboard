import '/domain/tecnici/entities/tecnico.dart';
import '/domain/wo/entities/wo.dart';
import '/domain/macchine/entities/macchina.dart';

class DettaglioMacchina {
  final MacchinaEntity macchina;
  final int ordine;
  final List<WOEntity> interventi;
  final List<TecnicoEntity> tecnici;

  DettaglioMacchina({
    required this.macchina,
    required this.ordine,
    required this.interventi,
    required this.tecnici,
  });

  DettaglioMacchina copyWith({
    MacchinaEntity? macchina,
    int? ordine,
    List<WOEntity>? interventi,
    List<TecnicoEntity>? tecnici,
  }) {
    return DettaglioMacchina(
      macchina: macchina ?? this.macchina,
      ordine: ordine ?? this.ordine,
      interventi: interventi ?? this.interventi,
      tecnici: tecnici ?? this.tecnici,
    );
  }

  String getStato() {
    if (interventi.isEmpty) {
      return "Attiva";
    }

    var woBloccanti = interventi.where((wo) => wo.statoMacchina == "Bloccante");

    if (woBloccanti.isNotEmpty) {
      return "Ferma";
    } else {
      return "Parzialmente ferma";
    }
  }
}
