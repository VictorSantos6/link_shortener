import 'package:link_shortener/domain/entities/click_entity.dart';
import 'package:link_shortener/domain/repositories/link_repository.dart';

class GetClicksForLinkUseCase {
  final LinkRepository repository;
  GetClicksForLinkUseCase(this.repository);

  Future<List<ClickEntity>> call(String linkId) {
    return repository.getClicksForLink(linkId);
  }
}
