import 'package:link_shortener/domain/entities/link_entity.dart';
import 'package:link_shortener/domain/repositories/link_repository.dart';

class SaveLinkUseCase {
  final LinkRepository repository;
  SaveLinkUseCase(this.repository);

  Future<LinkEntity> call(LinkEntity link) {
    return repository.saveLink(link);
  }
}
