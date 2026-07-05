import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/data_sources/cookie_storage_data_source.dart';

part 'instagram_auth_event.dart';
part 'instagram_auth_state.dart';

class InstagramAuthBloc extends Bloc<InstagramAuthEvent, InstagramAuthState> {
  final CookieStorageDataSource cookieStorage;

  InstagramAuthBloc({required this.cookieStorage}) : super(AuthInitial()) {
    on<LoginCompleted>((event, emit) async {
      emit(AuthSaving());
      try {
        await cookieStorage.saveCookies(event.cookies);
        emit(AuthComplete());
      } catch (e) {
        emit(AuthFailed(e.toString()));
      }
    });
  }
}
