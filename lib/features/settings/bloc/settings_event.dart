part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object?> get props => [];
}

class SettingsRequested extends SettingsEvent {}

class AutoSaveToggled extends SettingsEvent {
  final bool value;

  const AutoSaveToggled(this.value);

  @override
  List<Object?> get props => [value];
}
