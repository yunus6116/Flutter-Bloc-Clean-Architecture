import 'package:dio/dio.dart';
import 'package:flutter_bloc_clean_architecture/features/daily_news/data/data_sources/local/app_database.dart';
import 'package:flutter_bloc_clean_architecture/features/daily_news/data/repository/article_repository_impl.dart';
import 'package:flutter_bloc_clean_architecture/features/daily_news/domain/repository/article_repository.dart';
import 'package:flutter_bloc_clean_architecture/features/daily_news/domain/usecases/get_article.dart';
import 'package:flutter_bloc_clean_architecture/features/daily_news/domain/usecases/get_saved_article.dart';
import 'package:flutter_bloc_clean_architecture/features/daily_news/domain/usecases/remove_article.dart';
import 'package:flutter_bloc_clean_architecture/features/daily_news/domain/usecases/save_article.dart';
import 'package:flutter_bloc_clean_architecture/features/daily_news/presentation/bloc/article/local/local_article_bloc.dart';
import 'package:flutter_bloc_clean_architecture/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:get_it/get_it.dart';

import 'features/daily_news/data/data_sources/remote/news_api_service.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  sl.registerSingleton<AppDatabase>(database);
  // Dio
  sl.registerSingleton<Dio>(Dio());

  // Data sources
  sl.registerSingleton<NewsApiService>(NewsApiService(sl()));

  // Repository
  sl.registerLazySingleton<ArticleRepository>(() => ArticeRepositoryImpl(sl(), sl()));

  // Use cases
  sl.registerLazySingleton(() => GetArticleUseCase(sl()));

  sl.registerLazySingleton(() => GetSavedArticleUseCase(sl()));

  sl.registerLazySingleton(() => SaveArticleUseCase(sl()));

  sl.registerLazySingleton(() => RemoveArticleUseCase(sl()));

  // Blocs
  sl.registerFactory(() => RemoteArticlesBloc(sl()));

  sl.registerFactory<LocalArticleBloc>(() => LocalArticleBloc(sl(), sl(), sl()));
}
