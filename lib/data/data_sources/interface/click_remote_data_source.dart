import 'package:link_shortener/data/models/click_model.dart';

abstract class ClickRemoteDataSource {
  Future<void> recordClick(ClickModel click);
  Future<List<ClickModel>> getClicksForLinkId(String linkId);
}


