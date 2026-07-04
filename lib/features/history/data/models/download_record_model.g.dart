// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'download_record_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DownloadRecordModelAdapter extends TypeAdapter<DownloadRecordModel> {
  @override
  final int typeId = 0;

  @override
  DownloadRecordModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DownloadRecordModel(
      id: fields[0] as String,
      title: fields[1] as String,
      platform: fields[2] as String,
      localFilePath: fields[3] as String,
      thumbnailUrl: fields[4] as String,
      fileSizeBytes: fields[5] as int,
      downloadedAt: fields[6] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, DownloadRecordModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.platform)
      ..writeByte(3)
      ..write(obj.localFilePath)
      ..writeByte(4)
      ..write(obj.thumbnailUrl)
      ..writeByte(5)
      ..write(obj.fileSizeBytes)
      ..writeByte(6)
      ..write(obj.downloadedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DownloadRecordModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
