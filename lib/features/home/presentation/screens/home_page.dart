import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motorent_cons/extensions/int_extensions.dart';
import 'package:motorent_cons/features/auth/presentation/widgets/setting_icon_widget.dart';
import 'package:motorent_cons/features/home/domain/entities/vehicle_model.dart';
import 'package:motorent_cons/features/home/presentation/providers/get_all_vehicles_provider.dart';
import 'package:motorent_cons/features/home/presentation/providers/selected_rental_period_provider.dart';
import 'package:motorent_cons/features/home/presentation/screens/banners_screen.dart';
import 'package:motorent_cons/features/home/presentation/screens/bike_selection_screen.dart';
import 'package:motorent_cons/features/home/presentation/widgets/rent_button.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(getAllVehiclesProvider);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              children: [
                16.toHeightGap(),
                SettingIconWidget(),
                PromotionBannersScreen(),
                16.toHeightGap(),
                BikeSelectionScreen(),
              ],
            ),
            Align(alignment: Alignment.bottomCenter, child: PurchaseButton()),
          ],
        ),
      ),
    );
  }
}
