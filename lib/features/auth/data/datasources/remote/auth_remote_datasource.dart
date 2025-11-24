abstract class AuthRemoteDataSource {
  Future<Map<String, dynamic>> login(String email, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<Map<String, dynamic>> login(String email, String password) async {
    // Simulate network request
    await Future.delayed(const Duration(seconds: 1));
    if (email == 'test@test.com' && password == 'password') {
      return {'id': '1', 'name': 'Test User', 'email': email};
    } else {
      throw Exception('Invalid credentials');
    }
  }
}
