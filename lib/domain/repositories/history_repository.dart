import '../entities/download_record.dart';

abstract class HistoryRepository {
  Future<List<DownloadRecord>> getHistory();
  Future<void> saveRecord(DownloadRecord record);
  Future<void> deleteRecord(String id);
}
