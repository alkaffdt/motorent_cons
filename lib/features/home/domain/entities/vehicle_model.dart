class Vehicle {
  final int id;
  final String name;
  final String description;
  final int rangePerCharge;
  final int maxSpeed;
  final int dailyPrice;
  final int weeklyPrice;
  final int monthlyPrice;
  final int weight;
  final double batteryCapacity;
  final List<String> images;

  Vehicle({
    required this.id,
    required this.name,
    required this.description,
    required this.rangePerCharge,
    required this.maxSpeed,
    required this.dailyPrice,
    required this.weeklyPrice,
    required this.monthlyPrice,
    required this.weight,
    required this.batteryCapacity,
    required this.images,
  });

  factory Vehicle.fromJSON(Map<String, dynamic> json) {
    return Vehicle(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      rangePerCharge: json['range_per_charge'],
      maxSpeed: json['max_speed'],
      dailyPrice: json['daily_price'],
      weeklyPrice: json['weekly_price'],
      monthlyPrice: json['monthly_price'],
      weight: json['weight'],
      batteryCapacity: json['battery_capacity'],
      images: List<String>.from(json['images']),
    );
  }
}
