part of 'instagram_auth_bloc.dart';

abstract class InstagramAuthEvent extends Equatable {
  const InstagramAuthEvent();

  @override
  List<Object?> get props => [];
}

class LoginCompleted extends InstagramAuthEvent {
  final String cookies;

  const LoginCompleted(this.cookies);

  @override
  List<Object?> get props => [cookies];
}
