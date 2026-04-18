import 'package:link_shortener/data/data_sources/interface/link_remote_data_source.dart';
import 'package:link_shortener/data/data_sources/interface/click_remote_data_source.dart';
import 'package:link_shortener/data/models/click_model.dart';
import 'package:link_shortener/data/models/link_model.dart';
import 'package:link_shortener/domain/entities/click_entity.dart';
import 'package:link_shortener/domain/entities/link_entity.dart';
import 'package:link_shortener/domain/repositories/link_repository.dart';
import 'package:link_shortener/data/exceptions/data_exception.dart';
import 'package:link_shortener/domain/exceptions/repository_exception.dart';

class LinkRepositoryImpl extends LinkRepository {
  final LinkRemoteDataSource linkRemoteDataSource;
  final ClickRemoteDataSource clickRemoteDataSource;

  LinkRepositoryImpl({
    required this.linkRemoteDataSource,
    required this.clickRemoteDataSource,
  });

  @override
  Future<LinkEntity> saveLink(LinkEntity link) async {
    try {
      final model = LinkModel.fromEntity(link);
      final saved = await linkRemoteDataSource.saveLink(model);
      return saved.toEntity();
    } on DataSourceException catch (e, st) {
      throw RepositoryException('Failed to save link', e, st);
    } catch (e, st) {
      throw RepositoryException('Failed to save link', e, st);
    }
  }

  @override
  Future<void> deleteLink(String linkId) async {
    try {
      await linkRemoteDataSource.deleteLink(linkId);
    } on DataSourceException catch (e, st) {
      throw RepositoryException('Failed to delete link', e, st);
    } catch (e, st) {
      throw RepositoryException('Failed to delete link', e, st);
    }
  }

  @override
  Future<LinkEntity?> getLinkByCode(String code) async {
    try {
      final model = await linkRemoteDataSource.getLinkByCode(code);
      return model?.toEntity();
    } on DataSourceException catch (e, st) {
      throw RepositoryException('Failed to get link by code', e, st);
    } catch (e, st) {
      throw RepositoryException('Failed to get link by code', e, st);
    }
  }

  @override
  Future<void> recordLinkClick(ClickEntity click) async {
    try {
      final model = ClickModel.fromEntity(click);
      await clickRemoteDataSource.recordClick(model);
    } on DataSourceException catch (e, st) {
      throw RepositoryException('Failed to record link click', e, st);
    } catch (e, st) {
      throw RepositoryException('Failed to record link click', e, st);
    }
  }

  @override
  Future<List<ClickEntity>> getClicksForLink(String linkId) async {
    try {
      final models = await clickRemoteDataSource.getClicksForLinkId(linkId);
      return models.map((m) => m.toEntity()).toList();
    } on DataSourceException catch (e, st) {
      throw RepositoryException('Failed to fetch clicks for link', e, st);
    } catch (e, st) {
      throw RepositoryException('Failed to fetch clicks for link', e, st);
    }
  }
}