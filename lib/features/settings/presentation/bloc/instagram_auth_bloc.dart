import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/domain/repositories/cookie_repository.dart';

abstract class InstagramAuthEvent extends Equatable {
  const InstagramAuthEvent();
  @override
  List<Object?> get props => [];
}

class LoginCompleted extends InstagramAuthEvent {
  final List<dynamic> cookies;
  const LoginCompleted(this.cookies);
  @override
  List<Object?> get props => [cookies];
}

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

class InstagramAuthBloc extends Bloc<InstagramAuthEvent, InstagramAuthState> {
  final CookieRepository cookieRepository;

  InstagramAuthBloc(this.cookieRepository) : super(AuthInitial()) {
    on<LoginCompleted>(_onLoginCompleted);
  }

  Future<void> _onLoginCompleted(LoginCompleted event, Emitter<InstagramAuthState> emit) async {
    emit(AuthSaving());
    try {
      await cookieRepository.saveInstagramCookies(event.cookies);
      emit(AuthComplete());
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }
}
