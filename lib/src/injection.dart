

import 'package:cleanapp/src/data/datasources/remote/news_remote_data_source.dart';
import 'package:cleanapp/src/domain/usecase/articles_usecase.dart';
import 'package:cleanapp/src/persentation/provider/news_list_notifier.dart';
import 'package:get_it/get_it.dart';

import 'data/repositories/article_repository_impl.dart';
import 'domain/repositories/articles_repository.dart';

final locator = GetIt.instance;

void init() {
  locator.registerFactory(
    () => NewsListNotifier(articlesUseCase: locator()),
  );

  locator.registerLazySingleton(() => ArticlesUseCase(locator()));

  locator.registerLazySingleton<ArticlesRepository>(
    () => ArticlesRepositoryImpl(newsApiService: locator()),
  );

  locator.registerLazySingleton<NewsRemoteDataSource>(
      () => NewsRemoteDataSourceImpl());
}