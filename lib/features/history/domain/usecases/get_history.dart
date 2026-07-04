import '../entities/download_record.dart';
import '../repositories/history_repository.dart';

class GetHistory {
  final HistoryRepository repository;

  GetHistory(this.repository);

  Future<List<DownloadRecord>> call() {
    return repository.getHistory();
  }
}
