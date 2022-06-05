class PropertyModel {
  final int id;
  final int userId;
  final String name;
  final String area;
  final String type;

  const PropertyModel({
    required this.id,
    required this.userId,
    required this.name,
    required this.area,
    required this.type,
  });

  factory PropertyModel.fromJson(Map<String, dynamic> json) {
    return PropertyModel(
      id: json['id'],
      userId: json['user_id'],
      name: json['property_name'],
      area: json['area'],
      type: json['type'],
    );
  }
}
