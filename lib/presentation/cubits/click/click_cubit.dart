import 'package:flutter_bloc/flutter_bloc.dart';
import 'click_state.dart';
import 'package:link_shortener/domain/usecases/usecases.dart';
import 'package:link_shortener/domain/entities/click_entity.dart';
import 'package:link_shortener/domain/exceptions/repository_exception.dart';

class ClickCubit extends Cubit<ClickState> {
  final RecordLinkClickUseCase _recordClick;
  final GetClicksForLinkUseCase _getClicks;

  ClickCubit(this._recordClick, this._getClicks) : super(const ClickState());

  Future<void> loadClicks(String linkId) async {
    emit(state.copyWith(status: ClickStatus.loading, error: null));
    try {
      final clicks = await _getClicks(linkId);
      emit(state.copyWith(status: ClickStatus.success, clicks: clicks));
    } on RepositoryException catch (e) {
      emit(state.copyWith(status: ClickStatus.failure, error: e.message));
    } catch (e) {
      emit(state.copyWith(status: ClickStatus.failure, error: e.toString()));
    }
  }

  Future<void> recordClick(ClickEntity click) async {
    emit(state.copyWith(status: ClickStatus.loading, error: null));
    try {
      await _recordClick(click);
      final clicks = await _getClicks(click.linkId);
      emit(state.copyWith(status: ClickStatus.success, clicks: clicks));
    } on RepositoryException catch (e) {
      emit(state.copyWith(status: ClickStatus.failure, error: e.message));
    } catch (e) {
      emit(state.copyWith(status: ClickStatus.failure, error: e.toString()));
    }
  }
}
