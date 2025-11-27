class RentalTransactionData {
  final int id;
  final DateTime createdAt;
  final String? userId; // nullable di Supabase
  final DateTime? startDate;
  final DateTime? endDate;
  final String? periodType;
  final double? totalPrice;
  final String? addressDetail;

  const RentalTransactionData({
    required this.id,
    required this.createdAt,
    this.userId,
    this.startDate,
    this.endDate,
    this.periodType,
    this.totalPrice,
    this.addressDetail,
  });

  // ---- FROM JSON ----
  factory RentalTransactionData.fromJson(Map<String, dynamic> json) {
    return RentalTransactionData(
      id: json['id'] as int,
      createdAt: DateTime.parse(json['created_at']),
      userId: json['user_id'] as String?,
      startDate: json['start_date'] != null
          ? DateTime.parse(json['start_date'])
          : null,
      endDate: json['end_date'] != null
          ? DateTime.parse(json['end_date'])
          : null,
      periodType: json['period_type'] as String?,
      totalPrice: (json['total_price'] as num?)?.toDouble(),
      addressDetail:
          json['adress_detail'] as String?, // typo di DB tetap dipakai
    );
  }

  // ---- TO JSON ----
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'user_id': userId,
      'start_date': startDate?.toIso8601String(),
      'end_date': endDate?.toIso8601String(),
      'period_type': periodType,
      'total_price': totalPrice,
      'adress_detail': addressDetail, // sesuai DB
    };
  }

  // ---- COPYWITH ----
  RentalTransactionData copyWith({
    int? id,
    DateTime? createdAt,
    String? userId,
    DateTime? startDate,
    DateTime? endDate,
    String? periodType,
    double? totalPrice,
    String? addressDetail,
  }) {
    return RentalTransactionData(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      userId: userId ?? this.userId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      periodType: periodType ?? this.periodType,
      totalPrice: totalPrice ?? this.totalPrice,
      addressDetail: addressDetail ?? this.addressDetail,
    );
  }
}
