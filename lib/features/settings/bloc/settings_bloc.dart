import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/app_settings.dart';
import '../../../domain/repositories/settings_repository.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsRepository repository;

  SettingsBloc({required this.repository}) : super(SettingsInitial()) {
    on<SettingsRequested>((event, emit) async {
      try {
        final settings = await repository.getSettings();
        emit(SettingsLoaded(settings));
      } catch (e) {
        // Handle error if needed
      }
    });

    on<AutoSaveToggled>((event, emit) async {
      if (state is SettingsLoaded) {
        final currentSettings = (state as SettingsLoaded).settings;
        final newSettings = currentSettings.copyWith(autoSaveToGallery: event.value);
        await repository.updateSettings(newSettings);
        emit(SettingsLoaded(newSettings));
      }
    });
  }
}
