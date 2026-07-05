import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/download_record.dart';
import '../../../domain/repositories/history_repository.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final HistoryRepository repository;

  HistoryBloc({required this.repository}) : super(HistoryInitial()) {
    on<HistoryRequested>((event, emit) async {
      emit(HistoryLoading());
      try {
        final history = await repository.getHistory();
        if (history.isEmpty) {
          emit(HistoryEmpty());
        } else {
          emit(HistoryLoaded(history));
        }
      } catch (e) {
        emit(HistoryError(e.toString()));
      }
    });

    on<RecordDeleted>((event, emit) async {
      try {
        await repository.deleteRecord(event.id);
        add(HistoryRequested());
      } catch (e) {
        emit(HistoryError(e.toString()));
      }
    });
  }
}
