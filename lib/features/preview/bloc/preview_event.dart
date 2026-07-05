part of 'preview_bloc.dart';

abstract class PreviewEvent extends Equatable {
  const PreviewEvent();

  @override
  List<Object?> get props => [];
}

class DownloadRequested extends PreviewEvent {
  final VideoInfo videoInfo;

  const DownloadRequested(this.videoInfo);

  @override
  List<Object?> get props => [videoInfo];
}
