import 'package:equatable/equatable.dart';

enum PlatformType { tiktok, instagram, x, unknown }

class VideoInfo extends Equatable {
  final String title;
  final String thumbnailUrl;
  final String directUrl;
  final String extension;
  final double durationSeconds;
  final PlatformType platform;

  const VideoInfo({
    required this.title,
    required this.thumbnailUrl,
    required this.directUrl,
    required this.extension,
    required this.durationSeconds,
    required this.platform,
  });

  @override
  List<Object?> get props => [title, thumbnailUrl, directUrl, extension, durationSeconds, platform];
}
