import 'package:link_shortener/domain/entities/link_entity.dart';

enum LinkStatus { initial, loading, success, failure }

class LinkState {
  final LinkStatus status;
  final LinkEntity? link;
  final String? error;

  const LinkState({this.status = LinkStatus.initial, this.link, this.error});

  LinkState copyWith({LinkStatus? status, LinkEntity? link, String? error}) {
    return LinkState(
      status: status ?? this.status,
      link: link ?? this.link,
      error: error ?? this.error,
    );
  }
}
