import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motorent_cons/features/auth/presentation/providers/auth_providers.dart';
import 'package:motorent_cons/features/rent_form/data/models/rental_transaction_dto.dart';
import 'package:motorent_cons/features/rent_form/data/datasources/remote/rent_form_repository_impl.dart';

final rentFormRepositoryProvider = Provider<RentFormRepository>((ref) {
  return RentFormRepositoryImpl(ref.watch(supabaseClientProvider));
});

abstract class RentFormRepository {
  Future<Either<Exception, Unit>> submitRent(RentalTransactionDTO data);
}
