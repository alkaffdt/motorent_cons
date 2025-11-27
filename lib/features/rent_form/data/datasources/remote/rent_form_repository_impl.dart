import 'package:motorent_cons/features/rent_form/data/models/rental_transaction_dto.dart';
import 'package:motorent_cons/features/rent_form/domain/repositories/rent_form_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:dartz/dartz.dart';

class RentFormRepositoryImpl implements RentFormRepository {
  final SupabaseClient client;

  RentFormRepositoryImpl(this.client);

  @override
  Future<Either<Exception, Unit>> submitRent(RentalTransactionData data) async {
    try {
      final response = await client
          .from("rental_transactions")
          .insert(data.toJson())
          .select()
          .single();

      if (response.isEmpty) {
        return Left(Exception("Failed to submit rent (empty response)."));
      }

      return Right(unit);
    } catch (e) {
      return Left(Exception("Submit Rent Failed: $e"));
    }
  }
}
