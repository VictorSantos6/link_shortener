import 'package:link_shortener/domain/entities/click_entity.dart';
import 'package:link_shortener/domain/repositories/link_repository.dart';

class RecordLinkClickUseCase {
  final LinkRepository repository;
  RecordLinkClickUseCase(this.repository);

  Future<void> call(ClickEntity click) {
    return repository.recordLinkClick(click);
  }
}
