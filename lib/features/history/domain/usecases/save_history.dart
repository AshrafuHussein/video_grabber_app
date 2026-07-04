import '../entities/download_record.dart';
import '../repositories/history_repository.dart';

class SaveHistory {
  final HistoryRepository repository;

  SaveHistory(this.repository);

  Future<void> call(DownloadRecord record) {
    return repository.saveRecord(record);
  }
}
