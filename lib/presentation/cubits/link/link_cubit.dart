import 'package:flutter_bloc/flutter_bloc.dart';
import 'link_state.dart';
import 'package:link_shortener/domain/usecases/usecases.dart';
import 'package:link_shortener/domain/entities/link_entity.dart';
import 'package:link_shortener/domain/exceptions/repository_exception.dart';

class LinkCubit extends Cubit<LinkState> {
  final SaveLinkUseCase _saveLink;
  final DeleteLinkUseCase _deleteLink;
  final GetLinkByCodeUseCase _getByCode;

  LinkCubit(this._saveLink, this._deleteLink, this._getByCode) : super(const LinkState());

  Future<void> saveLink(LinkEntity link) async {
    emit(state.copyWith(status: LinkStatus.loading, error: null));
    try {
      final saved = await _saveLink(link);
      emit(state.copyWith(status: LinkStatus.success, link: saved));
    } on RepositoryException catch (e) {
      emit(state.copyWith(status: LinkStatus.failure, error: e.message));
    } catch (e) {
      emit(state.copyWith(status: LinkStatus.failure, error: e.toString()));
    }
  }

  Future<void> fetchByCode(String code) async {
    emit(state.copyWith(status: LinkStatus.loading, error: null));
    try {
      final link = await _getByCode(code);
      if (link == null) {
        emit(state.copyWith(status: LinkStatus.failure, error: 'Link not found'));
      } else {
        emit(state.copyWith(status: LinkStatus.success, link: link));
      }
    } on RepositoryException catch (e) {
      emit(state.copyWith(status: LinkStatus.failure, error: e.message));
    } catch (e) {
      emit(state.copyWith(status: LinkStatus.failure, error: e.toString()));
    }
  }

  Future<void> deleteLink(String linkId) async {
    emit(state.copyWith(status: LinkStatus.loading, error: null));
    try {
      await _deleteLink(linkId);
      emit(const LinkState(status: LinkStatus.success));
    } on RepositoryException catch (e) {
      emit(state.copyWith(status: LinkStatus.failure, error: e.message));
    } catch (e) {
      emit(state.copyWith(status: LinkStatus.failure, error: e.toString()));
    }
  }
}
