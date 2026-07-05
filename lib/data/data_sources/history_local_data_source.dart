import 'package:hive/hive.dart';
import '../models/download_record_model.dart';

abstract class HistoryLocalDataSource {
  Future<List<DownloadRecordModel>> getHistory();
  Future<void> saveRecord(DownloadRecordModel record);
  Future<void> deleteRecord(String id);
}

class HistoryLocalDataSourceImpl implements HistoryLocalDataSource {
  static const _boxName = 'history_box';

  @override
  Future<List<DownloadRecordModel>> getHistory() async {
    final box = await Hive.openBox<DownloadRecordModel>(_boxName);
    return box.values.toList()..sort((a, b) => b.downloadedAt.compareTo(a.downloadedAt));
  }

  @override
  Future<void> saveRecord(DownloadRecordModel record) async {
    final box = await Hive.openBox<DownloadRecordModel>(_boxName);
    await box.put(record.id, record);
  }

  @override
  Future<void> deleteRecord(String id) async {
    final box = await Hive.openBox<DownloadRecordModel>(_boxName);
    await box.delete(id);
  }
}
