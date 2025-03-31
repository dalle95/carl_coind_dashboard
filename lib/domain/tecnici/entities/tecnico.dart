class TecnicoEntity {
  final String id;
  final String codice;
  final String nome;
  final String stato; // Al lavoro, Non al lavoro, Al magazzino
  final String?
      macchinaId; // Può essere null se il tecnico non è al lavoro su una macchina

  TecnicoEntity({
    required this.id,
    required this.codice,
    required this.nome,
    required this.stato,
    this.macchinaId,
  });
}
