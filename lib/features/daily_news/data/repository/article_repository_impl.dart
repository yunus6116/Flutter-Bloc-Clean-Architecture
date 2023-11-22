import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc_clean_architecture/core/constants/constants.dart';
import 'package:flutter_bloc_clean_architecture/core/resources/data_state.dart';
import 'package:flutter_bloc_clean_architecture/features/daily_news/data/data_sources/local/app_database.dart';
import 'package:flutter_bloc_clean_architecture/features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:flutter_bloc_clean_architecture/features/daily_news/data/models/article.dart';
import 'package:flutter_bloc_clean_architecture/features/daily_news/domain/entities/article.dart';
import 'package:flutter_bloc_clean_architecture/features/daily_news/domain/repository/article_repository.dart';

class ArticeRepositoryImpl implements ArticleRepository {
  final NewsApiService _newsApiService;
  final AppDatabase _appDatabase;
  ArticeRepositoryImpl(this._newsApiService, this._appDatabase);
  @override
  Future<DataState<List<ArticleModel>>> getNewsArticles() async {
    try {
      final httpResponse = await _newsApiService.getNewsArticles(
        apiKey: newsAPIKey,
        country: countryQuery,
        category: categoryQuery,
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
          DioException(
            requestOptions: httpResponse.response.requestOptions,
            response: httpResponse.response,
            error: httpResponse.response.statusMessage,
            type: DioExceptionType.badResponse,
          ),
        );
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<List<ArticleEntity>> getSavedArticles() async {
    return _appDatabase.articleDao.getArticles();
  }

  @override
  Future<void> removeArticle(ArticleEntity article) {
    return _appDatabase.articleDao.deleteArticle(ArticleModel.fromEntity(article));
  }

  @override
  Future<void> saveArticle(ArticleEntity article) {
    return _appDatabase.articleDao.insertArticle(ArticleModel.fromEntity(article));
  }
}
