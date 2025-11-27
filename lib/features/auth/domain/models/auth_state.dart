import 'package:motorent_cons/features/auth/domain/models/submission_status_state.dart';
import 'package:motorent_cons/features/auth/domain/models/user_model.dart';

enum AuthStatus { initial, loading, success, failure }

class AuthState {
  final AppUser? user;
  final AuthStatus authStatus;

  AuthState({this.user, this.authStatus = AuthStatus.initial});

  AuthState copyWith({AppUser? user, AuthStatus? authStatus}) {
    return AuthState(
      user: user ?? this.user,
      authStatus: authStatus ?? this.authStatus,
    );
  }
}
