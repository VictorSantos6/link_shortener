import 'package:link_shortener/domain/entities/click_entity.dart';

enum ClickStatus { initial, loading, success, failure }

class ClickState {
  final ClickStatus status;
  final List<ClickEntity> clicks;
  final String? error;

  const ClickState({this.status = ClickStatus.initial, this.clicks = const [], this.error});

  ClickState copyWith({ClickStatus? status, List<ClickEntity>? clicks, String? error}) {
    return ClickState(
      status: status ?? this.status,
      clicks: clicks ?? this.clicks,
      error: error ?? this.error,
    );
  }
}
