import 'package:dartz/dartz.dart';

class RentalTransactionDTO {
  final StringMonoid? id;
  final DateTime? createdAt;
  final String? userId; // nullable di Supabase
  final DateTime? startDate;
  final DateTime? endDate;
  final String? durationInDays;
  final double? totalPrice;
  final String? addressDetail;
  final int? vehicleId;

  const RentalTransactionDTO({
    this.id,
    this.createdAt,
    this.userId,
    this.startDate,
    this.endDate,
    this.durationInDays,
    this.totalPrice,
    this.addressDetail,
    this.vehicleId,
  });

  // ---- FROM JSON ----
  factory RentalTransactionDTO.fromJson(Map<String, dynamic> json) {
    return RentalTransactionDTO(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      userId: json['user_id'] as String?,
      startDate: json['start_date'] != null
          ? DateTime.parse(json['start_date'])
          : null,
      endDate: json['end_date'] != null
          ? DateTime.parse(json['end_date'])
          : null,
      durationInDays: json['duration_in_days'] as String?,
      totalPrice: (json['total_price'] as num?)?.toDouble(),
      addressDetail:
          json['address_detail'] as String?, // typo di DB tetap dipakai
      vehicleId: json['vehicle_id'] as int?,
    );
  }

  // ---- TO JSON ----
  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'start_date': startDate?.toIso8601String(),
      'end_date': endDate?.toIso8601String(),
      'duration_in_days': durationInDays,
      'total_price': totalPrice,
      'address_detail': addressDetail, // sesuai DB
      'vehicle_id': vehicleId,
    };
  }

  // ---- COPYWITH ----
  RentalTransactionDTO copyWith({
    String? userId,
    DateTime? startDate,
    DateTime? endDate,
    String? durationInDays,
    double? totalPrice,
    String? addressDetail,
    int? vehicleId,
  }) {
    return RentalTransactionDTO(
      userId: userId ?? this.userId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      durationInDays: durationInDays ?? this.durationInDays,
      totalPrice: totalPrice ?? this.totalPrice,
      addressDetail: addressDetail ?? this.addressDetail,
    );
  }
}
