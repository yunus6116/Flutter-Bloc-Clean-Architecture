import 'package:flutter_bloc_clean_architecture/core/resources/data_state.dart';
import 'package:flutter_bloc_clean_architecture/features/daily_news/domain/usecases/get_article.dart';

import 'remote_article_event.dart';
import 'remote_article_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RemoteArticlesBloc extends Bloc<RemoteArticlesEvent, RemoteArticlesState> {
  final GetArticleUseCase _getArticleUseCase;
  RemoteArticlesBloc(this._getArticleUseCase) : super(const RemoteArticlesLoading()) {
    on<GetArticles>(onGetArticles);
  }

  Future<void> onGetArticles(GetArticles event, Emitter<RemoteArticlesState> emit) async {
    final dataState =
        await _getArticleUseCase(); // _getArticleUseCase.call() is equal to _getArticleUseCase() in Dart (Object.call() == Object())
    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(RemoteArticlesDone(articles: dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(RemoteArticlesError(error: dataState.error!));
    }
  }
}
