import 'package:equatable/equatable.dart';

enum PlatformType { tiktok, instagram, twitter, unknown }

class VideoInfo extends Equatable {
  final String title;
  final String? thumbnailUrl;
  final String directUrl;
  final String? extension;
  final int? durationSeconds;
  final PlatformType platform;
  final Map<String, String> httpHeaders;

  const VideoInfo({
    required this.title,
    this.thumbnailUrl,
    required this.directUrl,
    this.extension,
    this.durationSeconds,
    required this.platform,
    required this.httpHeaders,
  });

  @override
  List<Object?> get props => [
        title,
        thumbnailUrl,
        directUrl,
        extension,
        durationSeconds,
        platform,
        httpHeaders,
      ];
}
