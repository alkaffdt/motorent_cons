import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motorent_cons/extensions/navigation_extension.dart';
import 'package:motorent_cons/features/auth/presentation/widgets/login_dialog.dart';
import 'package:motorent_cons/features/auth/presentation/providers/auth_providers.dart';
import 'package:motorent_cons/features/home/presentation/providers/selected_rental_period_provider.dart';
import 'package:motorent_cons/features/home/presentation/providers/selected_vehicle_provider.dart';
import 'package:motorent_cons/features/rent_form/presentation/screens/rent_form_page.dart';

class PurchaseButton extends ConsumerWidget {
  const PurchaseButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isVisible = ref.watch(selectedRentalDetailProvider) != null;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: AnimatedSlide(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
        offset: isVisible ? Offset(0, 0) : Offset(0, 1.0),

        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 250),
          opacity: isVisible ? 1 : 0,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: SizedBox(
              height: 48,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final isLoggedIn = ref
                      .read(authRepositoryProvider)
                      .isLoggedIn();

                  if (!isLoggedIn) {
                    LoginDialog.show(context);
                  } else {
                    context.pushWithSlowTransition(RentFormPage());
                  }
                },
                child: const Text("Let's Rent!"),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
