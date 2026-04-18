

import 'package:link_shortener/domain/entities/click_entity.dart';
import 'package:link_shortener/domain/entities/link_entity.dart';

abstract class LinkRepository {
  Future<LinkEntity> saveLink(LinkEntity link);
  Future<void> deleteLink(String linkId);
  Future<LinkEntity?> getLinkByCode(String code);
  Future<void> recordLinkClick(ClickEntity click);
  Future<List<ClickEntity>> getClicksForLink(String linkId);


}