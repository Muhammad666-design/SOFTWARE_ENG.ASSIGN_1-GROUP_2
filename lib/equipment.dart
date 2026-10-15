class Equipment {
  Equipment({
    required this.assetId,
    required this.name,
    required this.category,
    required this.location,
    required this.condition,
    this.maintenanceRequired = false,
  });

  final String assetId;
  final String name;
  final String category;
  final String location;
  String condition;
  bool maintenanceRequired;
}
