import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motorent_cons/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:motorent_cons/features/auth/domain/repositories/auth_repository.dart';
import 'package:motorent_cons/features/auth/presentation/providers/auth_controller_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// PROVIDERS

final supabaseClientProvider = Provider<SupabaseClient>((ref) {
  return Supabase.instance.client;
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final client = ref.watch(supabaseClientProvider);
  return SupabaseAuthRepositoryImpl(client);
});

final authControllerProvider =
    StateNotifierProvider<AuthController, AsyncValue<bool>>((ref) {
      final repo = ref.watch(authRepositoryProvider);
      return AuthController(repo);
    });

final authStateProvider = StreamProvider<bool>((ref) {
  return ref.watch(authRepositoryProvider).authStateChanges();
});
