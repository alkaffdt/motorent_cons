import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motorent_cons/extensions/context_extension.dart';
import 'package:motorent_cons/extensions/double_extension.dart';
import 'package:motorent_cons/extensions/int_extensions.dart';
import 'package:motorent_cons/extensions/text_style_extension.dart';
import 'package:motorent_cons/features/home/domain/entities/vehicle_model.dart';
import 'package:motorent_cons/features/home/presentation/providers/selected_vehicle_provider.dart';
import 'package:motorent_cons/features/home/presentation/widgets/prices_widget.dart';
import 'package:motorent_cons/themes/app_colors.dart';

class BikeSelectionScreen extends ConsumerStatefulWidget {
  const BikeSelectionScreen(this.vehicles, {super.key});

  final List<Vehicle> vehicles;

  @override
  ConsumerState<BikeSelectionScreen> createState() =>
      _BikeSelectionScreenState();
}

class _BikeSelectionScreenState extends ConsumerState<BikeSelectionScreen> {
  final PageController _controller = PageController(
    viewportFraction: 0.8,
    initialPage: 1,
  );

  int _index = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _onVehicleSelected(widget.vehicles[_index]);
    });
  }

  void _onVehicleSelected(Vehicle vehicle) {
    ref.read(selectedVehicleProvider.notifier).state = vehicle;
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = context.heightInPercent(15);

    return Column(
      children: [
        topPadding.toHeightGap(),
        SizedBox(
          height: 400,
          child: Container(
            color: Colors.amber,
            child: PageView.builder(
              controller: _controller,
              itemCount: widget.vehicles.length,
              onPageChanged: (index) => setState(() => _index = index),
              itemBuilder: (context, index) {
                final vehicle = widget.vehicles[index];
                return AnimatedPadding(
                  padding: EdgeInsets.all(_index == index ? 0.0 : 16.0),
                  curve: Curves.fastOutSlowIn,
                  duration: const Duration(milliseconds: 500),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Image.network(vehicle.images.first),
                      24.toHeightGap(),
                      Text(vehicle.name).headerExtraSize(),
                      4.toHeightGap(),
                      Text(
                        vehicle.shortDesc,
                      ).mediumSize().textColor(AppColors.textSecondary),
                      16.toHeightGap(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'See details',
                          ).mediumSize().textColor(AppColors.textSecondary),
                          Icon(Icons.keyboard_arrow_down_sharp),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
        16.toHeightGap(),
        PricesWidget(widget.vehicles[_index]),
      ],
    );
  }
}
