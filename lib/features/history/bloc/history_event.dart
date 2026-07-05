part of 'history_bloc.dart';

abstract class HistoryEvent extends Equatable {
  const HistoryEvent();

  @override
  List<Object?> get props => [];
}

class HistoryRequested extends HistoryEvent {}

class RecordDeleted extends HistoryEvent {
  final String id;

  const RecordDeleted(this.id);

  @override
  List<Object?> get props => [id];
}
