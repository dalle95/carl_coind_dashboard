class MacchinaEntity {
  final String id;
  final String codice;
  final String descrizione;
  final String stato;
  final String? lineaId;

  MacchinaEntity({
    required this.id,
    required this.codice,
    required this.descrizione,
    required this.stato,
    this.lineaId,
  });
}
