import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motorent_cons/features/auth/presentation/providers/auth_providers.dart';
import 'package:motorent_cons/features/home/domain/models/transaction_history_model.dart';
import 'package:motorent_cons/features/home/domain/models/vehicle_model.dart';
import 'package:motorent_cons/features/home/domain/repositories/vehicles_repo.dart';

final getAllTransactionsProvider =
    FutureProvider<List<RentalTransactionHistory>>((ref) {
      final userId = ref.watch(authUserProfileProvider).id;
      final vehiclesRepo = ref.watch(vehiclesRepoProvider);
      return vehiclesRepo.getTransactionHistories(userId);
    });
