import 'package:motorent_cons/features/auth/data/datasources/remote/auth_remote_datasource.dart';
import 'package:motorent_cons/features/auth/domain/entities/user.dart';
import 'package:motorent_cons/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<User> login(String email, String password) async {
    final userMap = await remoteDataSource.login(email, password);
    return User(
      id: userMap['id'],
      name: userMap['name'],
      email: userMap['email'],
    );
  }

  @override
  Future<void> logout() async {
    // Simulate network request
    await Future.delayed(const Duration(seconds: 1));
  }
}
