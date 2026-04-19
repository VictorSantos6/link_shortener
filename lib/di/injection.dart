import 'package:get_it/get_it.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:link_shortener/data/data_sources/interface/link_remote_data_source.dart';
import 'package:link_shortener/data/data_sources/interface/click_remote_data_source.dart';
import 'package:link_shortener/data/data_sources/link_remote_data_source_impl.dart';
import 'package:link_shortener/data/data_sources/click_remote_data_source_impl.dart';
import 'package:link_shortener/data/repositories/link_repository_impl.dart';
import 'package:link_shortener/domain/repositories/link_repository.dart';
import 'package:link_shortener/domain/usecases/usecases.dart';
import 'package:link_shortener/presentation/cubits/link/link_cubit.dart';
import 'package:link_shortener/presentation/cubits/click/click_cubit.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupDependencies() async {
  // Core
  getIt.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

  // Data sources
  getIt.registerLazySingleton<LinkRemoteDataSource>(() => LinkRemoteDataSourceImpl(firestore: getIt()));
  getIt.registerLazySingleton<ClickRemoteDataSource>(() => ClickRemoteDataSourceImpl(firestore: getIt()));

  // Repository
  getIt.registerLazySingleton<LinkRepository>(() => LinkRepositoryImpl(
        linkRemoteDataSource: getIt(),
        clickRemoteDataSource: getIt(),
      ));

  // Usecases
  getIt.registerFactory(() => SaveLinkUseCase(getIt()));
  getIt.registerFactory(() => DeleteLinkUseCase(getIt()));
  getIt.registerFactory(() => GetLinkByCodeUseCase(getIt()));
  getIt.registerFactory(() => RecordLinkClickUseCase(getIt()));
  getIt.registerFactory(() => GetClicksForLinkUseCase(getIt()));

  // Cubits
  getIt.registerFactory(() => LinkCubit(getIt(), getIt(), getIt()));
  getIt.registerFactory(() => ClickCubit(getIt(), getIt()));
}
