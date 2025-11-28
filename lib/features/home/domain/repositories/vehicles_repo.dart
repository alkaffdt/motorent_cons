import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motorent_cons/core/network/supabase/supabase_provider.dart';
import 'package:motorent_cons/features/home/domain/models/banner_model.dart';
import 'package:motorent_cons/features/home/domain/models/transaction_history_model.dart';
import 'package:motorent_cons/features/home/domain/models/vehicle_model.dart';
import 'package:supabase/supabase.dart';

final vehiclesRepoProvider = Provider<VehiclesRepo>((ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  return VehiclesRepoImpl(supabaseClient: supabaseClient);
});

abstract class VehiclesRepo {
  Future<List<Vehicle>> getVehicles();
  Future<List<PromotionBanner>> getBanners();
  Future<List<RentalTransactionHistory>> getTransactionHistories();
}

class VehiclesRepoImpl implements VehiclesRepo {
  final SupabaseClient supabaseClient;

  VehiclesRepoImpl({required this.supabaseClient});

  @override
  Future<List<PromotionBanner>> getBanners() async {
    try {
      final response = await supabaseClient.from('banners').select('*');
      return response.map((e) => PromotionBanner.fromJSON(e)).toList();
    } catch (e) {
      throw Exception("Failed to fetch banners: $e");
    }
  }

  @override
  Future<List<Vehicle>> getVehicles() async {
    try {
      final response = await supabaseClient.from('vehicles').select('*');
      return response.map((e) => Vehicle.fromJSON(e)).toList();
    } catch (e) {
      throw Exception("Failed to fetch vehicles: $e");
    }
  }

  @override
  Future<List<RentalTransactionHistory>> getTransactionHistories() async {
    try {
      final response = await supabaseClient
          .from('rental_transactions')
          .select('*, vehicles!vehicle_id(*)')
          .order('created_at', ascending: false);
      return response.map((e) => RentalTransactionHistory.fromJson(e)).toList();
    } catch (e) {
      throw Exception("Failed to fetch vehicles: $e");
    }
  }
}
