import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motorent_cons/features/home/domain/entities/vehicle_model.dart';
import 'package:motorent_cons/features/home/presentation/providers/get_all_vehicles_provider.dart';
import 'package:motorent_cons/features/home/presentation/providers/selected_rental_period_provider.dart';
import 'package:motorent_cons/features/home/presentation/screens/bike_selection_screen.dart';
import 'package:motorent_cons/features/home/presentation/widgets/rent_button.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(getAllVehiclesProvider);
    final anySelected = ref.watch(selectedRentalDetailProvider) != null;

    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: state.when(
              data: (data) => BikeSelectionScreen(data),
              loading: () =>
                  const Center(child: CircularProgressIndicator.adaptive()),
              error: (error, stackTrace) =>
                  Center(child: Text(error.toString())),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: PurchaseButton(isVisible: anySelected),
          ),
        ],
      ),
    );
  }
}
