part of 'extraction_bloc.dart';

abstract class ExtractionState extends Equatable {
  const ExtractionState();

  @override
  List<Object?> get props => [];
}

class ExtractionInitial extends ExtractionState {}

class ExtractionLoading extends ExtractionState {}

class ExtractionSuccess extends ExtractionState {
  final VideoInfo videoInfo;

  const ExtractionSuccess(this.videoInfo);

  @override
  List<Object?> get props => [videoInfo];
}

class ExtractionFailure extends ExtractionState {
  final String message;

  const ExtractionFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class UnsupportedPlatform extends ExtractionState {
  final String message;

  const UnsupportedPlatform(this.message);

  @override
  List<Object?> get props => [message];
}

class InstagramAuthRequired extends ExtractionState {}
