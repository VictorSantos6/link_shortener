import 'package:link_shortener/domain/entities/link_entity.dart';
import 'package:link_shortener/domain/repositories/link_repository.dart';

class GetLinkByCodeUseCase {
  final LinkRepository repository;
  GetLinkByCodeUseCase(this.repository);

  Future<LinkEntity?> call(String code) {
    return repository.getLinkByCode(code);
  }
}
