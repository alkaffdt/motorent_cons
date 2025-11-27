import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motorent_cons/common/widgets/inapp_webview_page.dart';
import 'package:motorent_cons/extensions/context_extension.dart';
import 'package:motorent_cons/extensions/double_extension.dart';
import 'package:motorent_cons/extensions/int_extensions.dart';
import 'package:motorent_cons/extensions/navigation_extension.dart';
import 'package:motorent_cons/extensions/text_style_extension.dart';
import 'package:motorent_cons/features/home/domain/entities/vehicle_model.dart';
import 'package:motorent_cons/features/home/presentation/providers/get_all_vehicles_provider.dart';
import 'package:motorent_cons/features/home/presentation/providers/selected_vehicle_provider.dart';
import 'package:motorent_cons/features/home/presentation/widgets/prices_widget.dart';
import 'package:motorent_cons/themes/app_colors.dart';

class BikeSelectionScreen extends ConsumerWidget {
  const BikeSelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(getAllVehiclesProvider);

    return state.when(
      data: (data) => _BikeSelectionBody(data),
      loading: () => const Center(child: CircularProgressIndicator.adaptive()),
      error: (error, stackTrace) => Center(child: Text(error.toString())),
    );
  }
}

class _BikeSelectionBody extends ConsumerStatefulWidget {
  const _BikeSelectionBody(this.vehicles, {super.key});

  final List<Vehicle> vehicles;

  @override
  ConsumerState<_BikeSelectionBody> createState() => _BikeSelectionBodyState();
}

class _BikeSelectionBodyState extends ConsumerState<_BikeSelectionBody> {
  final PageController _controller = PageController(
    viewportFraction: 0.65,
    initialPage: 1,
  );

  int _index = 1;

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
    final topPadding = context.heightInPercent(10);

    return Column(
      children: [
        SizedBox(
          height: 324,
          child: Container(
            color: Colors.amber,
            child: PageView.builder(
              controller: _controller,
              itemCount: widget.vehicles.length,
              onPageChanged: (index) {
                setState(() => _index = index);

                _onVehicleSelected(widget.vehicles[index]);
              },
              itemBuilder: (context, index) {
                final vehicle = widget.vehicles[index];
                final imageHeight = 175.0;

                return AnimatedPadding(
                  padding: EdgeInsets.all(_index == index ? 0.0 : 16.0),
                  curve: Curves.fastOutSlowIn,
                  duration: const Duration(milliseconds: 500),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Hero(
                        tag: "vehicle-${vehicle.id}",
                        child: Image.network(
                          vehicle.images.first,
                          height: imageHeight,
                        ),
                      ),
                      16.toHeightGap(),
                      Text(vehicle.name).headerExtraSize(),
                      4.toHeightGap(),
                      Text(
                        vehicle.shortDesc,
                      ).mediumSize().textColor(AppColors.textSecondary),
                      8.toHeightGap(),
                      InkWell(
                        onTap: () {
                          context.push(
                            InAppWebViewPage(
                              initialUrl: vehicle.productDetailUrl,
                              title: vehicle.name,
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'See details',
                            ).mediumSize().textColor(AppColors.textSecondary),
                            Icon(Icons.keyboard_arrow_down_sharp),
                          ],
                        ),
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
        200.toHeightGap(),
      ],
    );
  }
}
