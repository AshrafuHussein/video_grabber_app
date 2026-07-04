import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/app_settings.dart';
import '../../domain/repositories/settings_repository.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();
  @override
  List<Object?> get props => [];
}

class LoadSettings extends SettingsEvent {}

class ToggleAutoSave extends SettingsEvent {
  final bool value;
  const ToggleAutoSave(this.value);
  @override
  List<Object?> get props => [value];
}

abstract class SettingsState extends Equatable {
  const SettingsState();
  @override
  List<Object?> get props => [];
}

class SettingsInitial extends SettingsState {}
class SettingsLoaded extends SettingsState {
  final AppSettings settings;
  const SettingsLoaded(this.settings);
  @override
  List<Object?> get props => [settings];
}

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsRepository repository;

  SettingsBloc(this.repository) : super(SettingsInitial()) {
    on<LoadSettings>(_onLoadSettings);
    on<ToggleAutoSave>(_onToggleAutoSave);
  }

  Future<void> _onLoadSettings(LoadSettings event, Emitter<SettingsState> emit) async {
    final settings = await repository.getSettings();
    emit(SettingsLoaded(settings));
  }

  Future<void> _onToggleAutoSave(ToggleAutoSave event, Emitter<SettingsState> emit) async {
    if (state is SettingsLoaded) {
      final currentSettings = (state as SettingsLoaded).settings;
      final newSettings = AppSettings(
        autoSaveToGallery: event.value,
        downloadLocation: currentSettings.downloadLocation,
      );
      await repository.updateSettings(newSettings);
      emit(SettingsLoaded(newSettings));
    }
  }
}
