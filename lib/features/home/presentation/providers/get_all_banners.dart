import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motorent_cons/features/home/domain/models/banner_model.dart';
import 'package:motorent_cons/features/home/domain/repositories/vehicles_repo.dart';

final getAllBannersProvider = FutureProvider<List<PromotionBanner>>((ref) {
  final vehiclesRepo = ref.watch(vehiclesRepoProvider);
  return vehiclesRepo.getBanners();
});
