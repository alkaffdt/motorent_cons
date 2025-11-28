import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motorent_cons/extensions/int_extensions.dart';
import 'package:motorent_cons/features/auth/presentation/widgets/setting_icon_widget.dart';
import 'package:motorent_cons/features/home/domain/entities/vehicle_model.dart';
import 'package:motorent_cons/features/home/presentation/providers/get_all_vehicles_provider.dart';
import 'package:motorent_cons/features/home/presentation/providers/home_page_scroll_controller.dart';
import 'package:motorent_cons/features/home/presentation/providers/selected_rental_period_provider.dart';
import 'package:motorent_cons/features/home/presentation/screens/banners_screen.dart';
import 'package:motorent_cons/features/home/presentation/screens/vehicle_selection_screen.dart';
import 'package:motorent_cons/features/home/presentation/widgets/rent_button.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = ref.watch(homeScreenScrollControllerProvider);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            ListView(
              controller: scrollController,
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
