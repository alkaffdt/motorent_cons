import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motorent_cons/features/rent_form/presentation/providers/rent_form_controller.dart';

class RentFormPage extends ConsumerWidget {
  const RentFormPage({super.key});

  Future<DateTime?> _pickDateTime(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      initialDate: DateTime.now(),
    );

    if (date == null) return null;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time == null) return null;

    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(rentFormProvider);
    final notifier = ref.read(rentFormProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text("Rent Form")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Address Field
            TextField(
              decoration: const InputDecoration(
                labelText: "Address",
                border: OutlineInputBorder(),
              ),
              onChanged: notifier.setAddress,
            ),

            const SizedBox(height: 20),

            // Start DateTime Picker
            InkWell(
              onTap: () async {
                final result = await _pickDateTime(context);
                if (result != null) notifier.setStartDateTime(result);
              },
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.schedule),
                    const SizedBox(width: 10),
                    Text(
                      state.startDateTime == null
                          ? "Select Start Time"
                          : state.startDateTime.toString(),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // End DateTime Picker
            InkWell(
              onTap: () async {
                final result = await _pickDateTime(context);
                if (result != null) notifier.setEndDateTime(result);
              },
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.schedule_outlined),
                    const SizedBox(width: 10),
                    Text(
                      state.endDateTime == null
                          ? "Select End Time"
                          : state.endDateTime.toString(),
                    ),
                  ],
                ),
              ),
            ),

            const Spacer(),

            // Submit Button
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () {
                  if (state.address.isEmpty ||
                      state.startDateTime == null ||
                      state.endDateTime == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please fill all fields.")),
                    );
                    return;
                  }

                  // TODO: connect with Supabase insert()

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Rental submitted!")),
                  );
                },
                child: const Text("Submit"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
