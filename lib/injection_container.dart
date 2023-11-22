import 'package:dio/dio.dart';
import 'package:flutter_bloc_clean_architecture/features/daily_news/data/repository/article_repository_impl.dart';
import 'package:flutter_bloc_clean_architecture/features/daily_news/domain/repository/article_repository.dart';
import 'package:flutter_bloc_clean_architecture/features/daily_news/domain/usecases/get_article.dart';
import 'package:flutter_bloc_clean_architecture/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:get_it/get_it.dart';

import 'features/daily_news/data/data_sources/remote/news_api_service.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Dio
  sl.registerSingleton<Dio>(Dio());

  // Data sources
  sl.registerSingleton<NewsApiService>(NewsApiService(sl()));

  // Repository
  sl.registerLazySingleton<ArticleRepository>(() => ArticeRepositoryImpl(sl()));

  // Use cases
  sl.registerLazySingleton(() => GetArticleUseCase(sl()));

  // Bloc
  sl.registerFactory(() => RemoteArticlesBloc(sl()));
}
