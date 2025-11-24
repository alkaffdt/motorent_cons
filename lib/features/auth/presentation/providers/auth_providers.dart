import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:motorent_cons/features/auth/data/datasources/remote/auth_remote_datasource.dart';
import 'package:motorent_cons/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:motorent_cons/features/auth/domain/repositories/auth_repository.dart';
import 'package:motorent_cons/features/auth/domain/usecases/login.dart';

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSourceImpl();
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final remoteDataSource = ref.watch(authRemoteDataSourceProvider);
  return AuthRepositoryImpl(remoteDataSource: remoteDataSource);
});

final loginUseCaseProvider = Provider<Login>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return Login(repository);
});
