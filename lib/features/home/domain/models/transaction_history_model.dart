import 'package:dartz/dartz.dart';
import 'package:motorent_cons/features/home/domain/models/vehicle_model.dart';

class RentalTransactionHistory {
  final int? id;
  final DateTime? createdAt;
  final String? userId; // nullable di Supabase
  final DateTime? startDate;
  final DateTime? endDate;
  final int? durationInDays;
  final double? totalPrice;
  final String? addressDetail;
  final Vehicle? vehicle;

  const RentalTransactionHistory({
    this.id,
    this.createdAt,
    this.userId,
    this.startDate,
    this.endDate,
    this.durationInDays,
    this.totalPrice,
    this.addressDetail,
    this.vehicle,
  });

  // ---- FROM JSON ----
  factory RentalTransactionHistory.fromJson(Map<String, dynamic> json) {
    return RentalTransactionHistory(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      userId: json['user_id'] as String?,
      startDate: json['start_date'] != null
          ? DateTime.parse(json['start_date'])
          : null,
      endDate: json['end_date'] != null
          ? DateTime.parse(json['end_date'])
          : null,
      durationInDays: json['duration_in_days'],
      totalPrice: (json['total_price'] as num?)?.toDouble(),
      addressDetail:
          json['address_detail'] as String?, // typo di DB tetap dipakai
      vehicle: Vehicle.fromJSON(json['vehicles']),
    );
  }

  // ---- COPYWITH ----
  RentalTransactionHistory copyWith({
    String? userId,
    DateTime? startDate,
    DateTime? endDate,
    int? durationInDays,
    double? totalPrice,
    String? addressDetail,
  }) {
    return RentalTransactionHistory(
      userId: userId ?? this.userId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      durationInDays: durationInDays ?? this.durationInDays,
      totalPrice: totalPrice ?? this.totalPrice,
      addressDetail: addressDetail ?? this.addressDetail,
    );
  }
}
