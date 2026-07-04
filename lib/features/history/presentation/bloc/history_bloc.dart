import 'package:flutter_bloc/flutter_bloc.dart';
import 'history_event.dart';
import 'history_state.dart';
import '../../domain/usecases/get_history.dart';
import '../../domain/repositories/history_repository.dart'; // Using repository directly for delete if no use case

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final GetHistory getHistory;
  final HistoryRepository repository;

  HistoryBloc({
    required this.getHistory,
    required this.repository,
  }) : super(HistoryInitial()) {
    on<LoadHistory>(_onLoadHistory);
    on<DeleteRecord>(_onDeleteRecord);
  }

  Future<void> _onLoadHistory(LoadHistory event, Emitter<HistoryState> emit) async {
    emit(HistoryLoading());
    try {
      final records = await getHistory();
      if (records.isEmpty) {
        emit(HistoryEmpty());
      } else {
        emit(HistoryLoaded(records));
      }
    } catch (e) {
      emit(HistoryError(e.toString()));
    }
  }

  Future<void> _onDeleteRecord(DeleteRecord event, Emitter<HistoryState> emit) async {
    try {
      await repository.deleteRecord(event.id);
      add(LoadHistory());
    } catch (e) {
      emit(HistoryError(e.toString()));
    }
  }
}
