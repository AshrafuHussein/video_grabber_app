import 'package:equatable/equatable.dart';
import '../../domain/entities/video_info.dart';
import '../../../history/domain/entities/download_record.dart';

abstract class HomeState extends Equatable {
  const HomeState();
  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeHistoryLoaded extends HomeState {
  final List<DownloadRecord> recentDownloads;
  const HomeHistoryLoaded(this.recentDownloads);
  @override
  List<Object?> get props => [recentDownloads];
}

class ExtractionLoading extends HomeState {}

class ExtractionSuccess extends HomeState {
  final VideoInfo videoInfo;
  const ExtractionSuccess(this.videoInfo);
  @override
  List<Object?> get props => [videoInfo];
}

class ExtractionFailure extends HomeState {
  final String message;
  const ExtractionFailure(this.message);
  @override
  List<Object?> get props => [message];
}

class NeedsInstagramAuth extends HomeState {
  final String pendingUrl;
  const NeedsInstagramAuth(this.pendingUrl);
  @override
  List<Object?> get props => [pendingUrl];
}

class UnsupportedPlatform extends HomeState {
  final String url;
  const UnsupportedPlatform(this.url);
  @override
  List<Object?> get props => [url];
}
