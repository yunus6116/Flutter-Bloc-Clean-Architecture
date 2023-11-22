import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_bloc_clean_architecture/core/constants/constants.dart';
import 'package:flutter_bloc_clean_architecture/core/resources/data_state.dart';
import 'package:flutter_bloc_clean_architecture/features/daily_news/data/data_sources/remote/news_api_service.dart';
import 'package:flutter_bloc_clean_architecture/features/daily_news/data/models/article.dart';
import 'package:flutter_bloc_clean_architecture/features/daily_news/domain/repository/article_repository.dart';

class ArticeRepositoryImpl implements ArticleRepository {
  final NewsApiService _newsApiService;

  ArticeRepositoryImpl(this._newsApiService);
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
}
