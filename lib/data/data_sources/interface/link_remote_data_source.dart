import 'package:link_shortener/data/models/link_model.dart';

abstract class LinkRemoteDataSource {
  Future<LinkModel> saveLink(LinkModel link);
  Future<void> deleteLink(String linkId);
  Future<LinkModel?> getLinkByCode(String code);
}
