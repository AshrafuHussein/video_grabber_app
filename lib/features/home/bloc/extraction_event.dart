part of 'extraction_bloc.dart';

abstract class ExtractionEvent extends Equatable {
  const ExtractionEvent();

  @override
  List<Object?> get props => [];
}

class LinkPasted extends ExtractionEvent {
  final String url;

  const LinkPasted(this.url);

  @override
  List<Object?> get props => [url];
}
