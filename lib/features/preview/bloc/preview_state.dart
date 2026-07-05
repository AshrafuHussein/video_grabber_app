part of 'preview_bloc.dart';

abstract class PreviewState extends Equatable {
  const PreviewState();

  @override
  List<Object?> get props => [];
}

class PreviewInitial extends PreviewState {}

class Downloading extends PreviewState {
  final double progress;

  const Downloading(this.progress);

  @override
  List<Object?> get props => [progress];
}

class DownloadComplete extends PreviewState {
  final String localPath;

  const DownloadComplete(this.localPath);

  @override
  List<Object?> get props => [localPath];
}

class DownloadFailed extends PreviewState {
  final String message;

  const DownloadFailed(this.message);

  @override
  List<Object?> get props => [message];
}
