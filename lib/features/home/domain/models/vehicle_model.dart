class Vehicle {
  final int id;
  final String name;
  final String description;
  final String shortDesc;
  final int rangePerCharge;
  final int maxSpeed;
  final double dailyPrice;
  final double weeklyPrice;
  final double monthlyPrice;
  final int weight;
  final double batteryCapacity;
  final List<String> images;
  final String productDetailUrl;

  Vehicle({
    required this.id,
    required this.name,
    required this.description,
    required this.shortDesc,
    required this.rangePerCharge,
    required this.maxSpeed,
    required this.dailyPrice,
    required this.weeklyPrice,
    required this.monthlyPrice,
    required this.weight,
    required this.batteryCapacity,
    required this.images,
    required this.productDetailUrl,
  });

  factory Vehicle.fromJSON(Map<String, dynamic> json) {
    return Vehicle(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      shortDesc: json['short_desc'],
      rangePerCharge: json['range_per_charge'],
      maxSpeed: json['max_speed'],
      dailyPrice: (json['daily_price'] as num).toDouble(),
      weeklyPrice: (json['weekly_price'] as num).toDouble(),
      monthlyPrice: (json['monthly_price'] as num).toDouble(),
      weight: json['weight'],
      batteryCapacity: json['battery_capacity'],
      images: List<String>.from(json['images']),
      productDetailUrl: json['product_detail_url'],
    );
  }
}
