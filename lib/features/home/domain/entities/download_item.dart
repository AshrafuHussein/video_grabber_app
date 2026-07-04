import 'package:equatable/equatable.dart';

class DownloadItem extends Equatable {
  final String id;
  final String title;
  final String thumbnailUrl;
  final String source; // e.g., 'TikTok', 'Instagram', 'X'
  final String size;
  final String duration;
  final DateTime timestamp;
  final bool isProcessing;

  const DownloadItem({
    required this.id,
    required this.title,
    required this.thumbnailUrl,
    required this.source,
    required this.size,
    required this.duration,
    required this.timestamp,
    this.isProcessing = false,
  });

  @override
  List<Object?> get props => [id, title, thumbnailUrl, source, size, duration, timestamp, isProcessing];
}
