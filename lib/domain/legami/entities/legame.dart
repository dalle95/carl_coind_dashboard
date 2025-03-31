class LegameEntity {
  final String id;
  final String? lineaId;
  final String? macchinaId;
  final int ordine;

  LegameEntity({
    required this.id,
    this.lineaId,
    this.macchinaId,
    required this.ordine,
  });
}
