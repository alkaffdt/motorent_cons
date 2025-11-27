import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motorent_cons/consts/rent_period_types.dart';
import 'package:motorent_cons/extensions/double_extension.dart';
import 'package:motorent_cons/extensions/int_extensions.dart';
import 'package:motorent_cons/extensions/string_extension.dart';
import 'package:motorent_cons/extensions/text_style_extension.dart';
import 'package:motorent_cons/features/home/domain/entities/rental_detail_model.dart';
import 'package:motorent_cons/features/home/domain/entities/vehicle_model.dart';
import 'package:motorent_cons/features/home/presentation/providers/selected_rental_period_provider.dart';
import 'package:motorent_cons/themes/app_colors.dart';
import 'package:motorent_cons/utils/discount_calculator.dart';

class PricesWidget extends ConsumerWidget {
  const PricesWidget(this.vehicle, {super.key});

  final Vehicle vehicle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Expanded(child: _timeType(vehicle.id, 1, vehicle.dailyPrice)),
        Expanded(
          child: _timeType(
            vehicle.id,
            7,
            vehicle.weeklyPrice,
            discount: DiscountCalculator.getWeeklyDiscount(
              dailyPrice: vehicle.dailyPrice,
              weeklyPrice: vehicle.weeklyPrice,
            ),
          ),
        ),
        Expanded(
          child: _timeType(
            vehicle.id,
            30,
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

  Widget _timeType(
    int vehicleId,
    int durationInDays,
    double price, {
    double discount = 0,
  }) {
    return Consumer(
      builder: (context, ref, child) {
        final isSelected =
            ref.watch(selectedRentalDetailProvider)?.durationInDays ==
            durationInDays;

        return InkWell(
          onTap: () {
            ref.read(selectedRentalDetailProvider.notifier).state =
                RentalDetail(durationInDays: durationInDays, price: price);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  '$durationInDays day${durationInDays > 1 ? 's' : ''}',
                ).fontSize(14),
              ),
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.primary),
                      color: isSelected ? AppColors.primary : Colors.white,
                    ),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 8,
                    ).copyWith(top: 12),
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 12,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text('Rp ${price.formattedIDRPrice}')
                              .mediumSize()
                              .mediumWeight()
                              .textColor(
                                isSelected
                                    ? Colors.white
                                    : AppColors.textPrimary,
                              ),
                        ),
                      ],
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

                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 12,
                        ),
                        child: Text(
                          'Save ${discount.toInt().toString()}',
                        ).fontSize(10).textColor(Colors.white),
                      ),
                    ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
