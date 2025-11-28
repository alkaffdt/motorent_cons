import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motorent_cons/extensions/int_extensions.dart';
import 'package:motorent_cons/extensions/navigation_extension.dart';
import 'package:motorent_cons/extensions/text_style_extension.dart';
import 'package:motorent_cons/features/auth/presentation/providers/auth_providers.dart';
import 'package:motorent_cons/features/home/presentation/screens/transactions_history_page.dart';
import 'package:motorent_cons/themes/app_colors.dart';

class SettingIconWidget extends ConsumerWidget {
  const SettingIconWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(authControllerProvider);
    final isLoggedIn = ref.watch(authRepositoryProvider).isLoggedIn();

    if (!isLoggedIn) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          PopupMenuButton(
            icon: const Icon(Icons.settings),
            iconSize: 24,
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  enabled: false,
                  value: 1,
                  child: const Text('Profile'),
                ),
                PopupMenuItem(
                  onTap: () {
                    context.push(TransactionsHistoryPage());
                  },
                  value: 2,
                  child: Text('Transactions'),
                ),
                PopupMenuItem(
                  onTap: () {
                    ref.read(authControllerProvider.notifier).signOut();
                  },
                  value: 2,
                  child: Text('Logout').textColor(AppColors.error),
                ),
              ];
            },
          ),
        ],
      ),
    );
  }
}
