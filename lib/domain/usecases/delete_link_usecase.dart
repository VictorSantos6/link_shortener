import 'package:link_shortener/domain/repositories/link_repository.dart';

class DeleteLinkUseCase {
  final LinkRepository repository;
  DeleteLinkUseCase(this.repository);

  Future<void> call(String linkId) {
    return repository.deleteLink(linkId);
  }
}
