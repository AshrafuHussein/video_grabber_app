import 'package:equatable/equatable.dart';
import '../../domain/entities/download_record.dart';

abstract class HistoryState extends Equatable {
  const HistoryState();
  @override
  List<Object?> get props => [];
}

class HistoryInitial extends HistoryState {}
class HistoryLoading extends HistoryState {}
class HistoryLoaded extends HistoryState {
  final List<DownloadRecord> records;
  const HistoryLoaded(this.records);
  @override
  List<Object?> get props => [records];
}
class HistoryEmpty extends HistoryState {}
class HistoryError extends HistoryState {
  final String message;
  const HistoryError(this.message);
  @override
  List<Object?> get props => [message];
}
