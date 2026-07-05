import '../../domain/entities/download_record.dart';
import '../../domain/repositories/history_repository.dart';
import '../data_sources/history_local_data_source.dart';
import '../models/download_record_model.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  final HistoryLocalDataSource dataSource;

  HistoryRepositoryImpl(this.dataSource);

  @override
  Future<List<DownloadRecord>> getHistory() async {
    final models = await dataSource.getHistory();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<void> saveRecord(DownloadRecord record) async {
    await dataSource.saveRecord(DownloadRecordModel.fromEntity(record));
  }

  @override
  Future<void> deleteRecord(String id) async {
    await dataSource.deleteRecord(id);
  }
}
