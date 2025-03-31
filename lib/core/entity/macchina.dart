class Macchina {
  final String id;
  final String codice;
  final String descrizione;
  final String stato; // Attiva, Guasto non bloccante, Guasto bloccante
  final String lineaId;

  Macchina({
    required this.id,
    required this.codice,
    required this.descrizione,
    required this.stato,
    required this.lineaId,
  });
}
