import 'package:equatable/equatable.dart';
import '../../../home/domain/entities/video_info.dart';

abstract class PreviewEvent extends Equatable {
  const PreviewEvent();
  @override
  List<Object?> get props => [];
}

class StartDownload extends PreviewEvent {
  final VideoInfo videoInfo;
  const StartDownload(this.videoInfo);
  @override
  List<Object?> get props => [videoInfo];
}
