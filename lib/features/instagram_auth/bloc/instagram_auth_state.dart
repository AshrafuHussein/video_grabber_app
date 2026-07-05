part of 'instagram_auth_state.dart';

abstract class InstagramAuthState extends Equatable {
  const InstagramAuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends InstagramAuthState {}

class AuthSaving extends InstagramAuthState {}

class AuthComplete extends InstagramAuthState {}

class AuthFailed extends InstagramAuthState {
  final String message;

  const AuthFailed(this.message);

  @override
  List<Object?> get props => [message];
}
