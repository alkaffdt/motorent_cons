import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motorent_cons/core/network/supabase/supabase_provider.dart';
import 'package:motorent_cons/features/home/domain/entities/vehicle_model.dart';
import 'package:supabase/supabase.dart';

final vehiclesRepoProvider = Provider<VehiclesRepo>((ref) {
  final supabaseClient = ref.watch(supabaseProvider);
  return VehiclesRepoImpl(supabaseClient: supabaseClient);
});

abstract class VehiclesRepo {
  Future<List<Vehicle>> getVehicles();
}

class VehiclesRepoImpl implements VehiclesRepo {
  final SupabaseClient supabaseClient;

  VehiclesRepoImpl({required this.supabaseClient});

  @override
  Future<List<Vehicle>> getVehicles() async {
    final response = await supabaseClient.from('vehicles').select('*');
    return response.map((e) => Vehicle.fromJSON(e)).toList();
  }
}
