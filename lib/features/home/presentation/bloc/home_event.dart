import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
  @override
  List<Object?> get props => [];
}

class FetchRecentDownloads extends HomeEvent {}

class LinkPasted extends HomeEvent {
  final String url;
  const LinkPasted(this.url);
  @override
  List<Object?> get props => [url];
}

class ExtractRequested extends HomeEvent {
  final String url;
  const ExtractRequested(this.url);
  @override
  List<Object?> get props => [url];
}
