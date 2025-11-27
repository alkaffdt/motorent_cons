abstract class AuthRepository {
  Future<void> signInWithEmail(String email, String password);
  Future<void> signUpWithEmail(String email, String password);
  Future<void> signOut();
  Stream<bool> authStateChanges();
  bool isLoggedIn();
  //
  Future<AuthResult> loginOrSignup(String email, String password);
}

class AuthResult {
  final bool success;
  final bool isNewUser;
  final String? message;

  AuthResult({required this.success, required this.isNewUser, this.message});
}
