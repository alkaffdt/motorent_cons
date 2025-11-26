import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motorent_cons/extensions/text_style_extension.dart';
import 'package:motorent_cons/features/home/domain/entities/vehicle_model.dart';
import 'package:motorent_cons/themes/app_colors.dart';
import 'package:motorent_cons/utils/discount_calculator.dart';

class PricesWidget extends ConsumerWidget {
  const PricesWidget(this.vehicle, {super.key});

  final Vehicle vehicle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Expanded(child: _timeType('Daily', vehicle.dailyPrice)),
        Expanded(
          child: _timeType(
            'Weekly',
            vehicle.weeklyPrice,
            discount: DiscountCalculator.getWeeklyDiscount(
              dailyPrice: vehicle.dailyPrice,
              weeklyPrice: vehicle.weeklyPrice,
            ),
          ),
        ),
        Expanded(
          child: _timeType(
            'Monthly',
            vehicle.monthlyPrice,
            discount: DiscountCalculator.getMonthlyDiscount(
              dailyPrice: vehicle.dailyPrice,
              monthlyPrice: vehicle.monthlyPrice,
            ),
          ),
        ),
      ],
    );
  }

  Widget _timeType(String label, double price, {double discount = 0}) {
    return Stack(
      children: [
        Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.primary),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 8).copyWith(top: 12),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            child: Text(label).mediumSize(),
          ),
        ),
        if (discount > 0)
          Align(
            alignment: Alignment.topRight,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.error,
              ),

              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
              child: Text(
                'Save ${discount.toInt().toString()}',
              ).fontSize(10).textColor(Colors.white),
            ),
          ),
      ],
    );
  }
}
