import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motorent_cons/common/widgets/app_dialogs.dart';
import 'package:motorent_cons/common/widgets/date_time_picker.dart';
import 'package:motorent_cons/extensions/int_extensions.dart';
import 'package:motorent_cons/extensions/navigation_extension.dart';
import 'package:motorent_cons/features/auth/domain/models/submission_status_state.dart';
import 'package:motorent_cons/features/auth/presentation/providers/auth_providers.dart';
import 'package:motorent_cons/features/home/presentation/providers/get_all_transactions_provider.dart';
import 'package:motorent_cons/features/home/presentation/providers/selected_vehicle_provider.dart';
import 'package:motorent_cons/features/rent_form/presentation/providers/rent_form_controller.dart';
import 'package:motorent_cons/features/rent_form/presentation/widgets/confirm_rent_button.dart';

class RentFormPage extends ConsumerWidget {
  RentFormPage({super.key});

  final ScrollController _scrollController = ScrollController();
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formNotifier = ref.read(rentFormProvider.notifier);
    final formState = ref.watch(rentFormProvider);
    //
    final selectedVehicle = ref.watch(selectedVehicleProvider);

    ref.listen(rentFormProvider, (previous, next) {
      if (next.submissionStatus == SubmissionStatus.loading) {
        AppDialog.showLoadingDialog(context);
      } else if (next.submissionStatus == SubmissionStatus.success) {
        context.pop(); // close loading dialog
        AppDialog.showSuccessDialog(context, message: 'Rent Form Submitted');
        ref.watch(getAllTransactionsProvider);

        Future.delayed(const Duration(seconds: 2), () {
          context.pop();
        });
      } else if (next.submissionStatus == SubmissionStatus.failure) {
        context.pop(); // close loading dialog
        AppDialog.showErrorDialog(
          context,
          message: next.submissionErrorMessage,
        );
      }
    });

    Future.microtask(() {
      nameController.text =
          ref.watch(authUserProfileProvider).userMetadata?['display_name'] ??
          '';
    });

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text("Rent Form")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Stack(
          children: [
            ListView(
              controller: _scrollController,
              children: [
                // VEHICLE
                Hero(
                  tag: "vehicle-${selectedVehicle!.id}",
                  child: Image.network(selectedVehicle.images.first),
                ),
                24.toHeightGap(),

                // START DATE
                MotorentDateTimePicker(
                  label: "Start Date & Time",
                  value: formState.startDateTime,
                  error: null,
                  onPick: () =>
                      _pickDateTime(context, formNotifier.setStartDateTime),
                ),
                16.toHeightGap(),

                TextField(
                  enabled: false,
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: "Name",
                    border: OutlineInputBorder(),
                  ),
                ),

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
                  onTap: () {
                    _scrollController.animateTo(
                      _scrollController.position.maxScrollExtent,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  decoration: InputDecoration(
                    labelText: "Address",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: formNotifier.setAddress,
                ),
                16.toHeightGap(),
                300.toHeightGap(),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ConfirmRentButton(
                enabled: formNotifier.validate(),
                onPressed: () {
                  formNotifier.submitRentForm();
                },
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
      firstDate: DateTime.now(),
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
