import 'package:hive/hive.dart';
import '../../domain/entities/download_record.dart';
import '../../domain/repositories/history_repository.dart';
import '../models/download_record_model.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  static const String boxName = 'history_box';

  @override
  Future<List<DownloadRecord>> getHistory() async {
    final box = await Hive.openBox<DownloadRecordModel>(boxName);
    return box.values.map((model) => model.toEntity()).toList().reversed.toList();
  }

  @override
  Future<void> saveRecord(DownloadRecord record) async {
    final box = await Hive.openBox<DownloadRecordModel>(boxName);
    await box.put(record.id, DownloadRecordModel.fromEntity(record));
  }

  @override
  Future<void> deleteRecord(String id) async {
    final box = await Hive.openBox<DownloadRecordModel>(boxName);
    await box.delete(id);
  }
}
