import 'package:equatable/equatable.dart';

abstract class HistoryEvent extends Equatable {
  const HistoryEvent();
  @override
  List<Object?> get props => [];
}

class LoadHistory extends HistoryEvent {}

class DeleteRecord extends HistoryEvent {
  final String id;
  const DeleteRecord(this.id);
  @override
  List<Object?> get props => [id];
}
