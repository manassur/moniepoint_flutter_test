enum MapMenu {
  cosyAreas(
    'shield',
    "Cosy areas",
  ),
  price(
    'wallet',
    "Price",
  ),
  infrastructure(
    'infrastructure',
    "Infrastructure",
  ),
  withoutAnyLayer(
    'layer-icon',
    "Without any layer",
  );

  final String icon;
  final String value;

  const MapMenu(
    this.icon,
    this.value,
  );
}

extension MapMenuX on MapMenu {
  bool get isCosyAreas => this == MapMenu.cosyAreas;
  bool get isPrice => this == MapMenu.price;
  bool get isInfrastructure => this == MapMenu.infrastructure;
  bool get isWithoutAnyLayer => this == MapMenu.withoutAnyLayer;
}
