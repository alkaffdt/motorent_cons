import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motorent_cons/features/home/domain/entities/vehicle_model.dart';
import 'package:motorent_cons/features/home/presentation/providers/get_all_vehicles_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(getAllVehiclesProvider);
    return Scaffold(
      body: Center(
        child: state.when(
          data: (data) => _VehicleListView(data),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(child: Text(error.toString())),
        ),
      ),
    );
  }
}

class _VehicleListView extends ConsumerWidget {
  _VehicleListView(this.vehicles, {super.key});

  final List<Vehicle> vehicles;
  final PageController _controller = PageController(viewportFraction: 0.8);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PageView.builder(
      controller: _controller,
      itemCount: vehicles.length,
      itemBuilder: (context, index) {
        final vehicle = vehicles[index];
        return Container(
          margin: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [Image.network(vehicle.images.first), Text(vehicle.name)],
          ),
        );
      },
    );
  }
}
