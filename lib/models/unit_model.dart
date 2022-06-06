class UnitModel {
  final int id;
  final int propertyId;
  final String name;
  final String picture;
  final String description;
  final int totalUnit;
  final int price;

  const UnitModel({
    required this.id,
    required this.propertyId,
    required this.name,
    required this.picture,
    required this.description,
    required this.totalUnit,
    required this.price,
  });

  factory UnitModel.fromJson(Map<String, dynamic> json) {
    return UnitModel(
        id: json['id'],
        propertyId: json['property_id'],
        name: json['unit_name'],
        picture: json['unit_picture'],
        description: json['unit_description'],
        totalUnit: json['total_unit'],
        price: json['price']);
  }
}
