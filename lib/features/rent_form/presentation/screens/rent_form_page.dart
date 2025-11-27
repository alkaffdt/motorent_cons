import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motorent_cons/common/widgets/date_time_picker.dart';
import 'package:motorent_cons/extensions/int_extensions.dart';
import 'package:motorent_cons/features/home/presentation/providers/selected_vehicle_provider.dart';
import 'package:motorent_cons/features/rent_form/presentation/providers/rent_form_controller.dart';
import 'package:motorent_cons/features/rent_form/presentation/widgets/confirm_rent_button.dart';

class RentFormPage extends ConsumerWidget {
  const RentFormPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formNotifier = ref.read(rentFormProvider.notifier);
    final formState = ref.watch(rentFormProvider);
    //
    final selectedVehicle = ref.watch(selectedVehicleProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Rent Form")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Stack(
          children: [
            ListView(
              children: [
                // VEHICLE
                Hero(
                  tag: "vehicle-${selectedVehicle!.id}",
                  child: Image.network(selectedVehicle.images.first),
                ),

                // START DATE
                MotorentDateTimePicker(
                  label: "Start Date & Time",
                  value: formState.startDateTime,
                  error: null,
                  onPick: () =>
                      _pickDateTime(context, formNotifier.setStartDateTime),
                ),
                16.toHeightGap(),

                // END DATE
                if (formState.endDateTime != null)
                  MotorentDateTimePicker(
                    label: "End Date & Time",
                    value: formState.endDateTime,
                    error: null,
                    enabled: false,
                  ),
                24.toHeightGap(),

                // ADDRESS
                TextField(
                  decoration: InputDecoration(
                    labelText: "Address",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: formNotifier.setAddress,
                ),
                16.toHeightGap(),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ConfirmRentButton(
                enabled: formNotifier.validate(),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickDateTime(
    BuildContext context,
    void Function(DateTime) onPicked,
  ) async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime.now().subtract(const Duration(days: 1)),
      lastDate: DateTime(2100),
      initialDate: DateTime.now(),
    );

    if (date == null) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time == null) return;

    final finalDateTime = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    onPicked(finalDateTime);
  }
}
