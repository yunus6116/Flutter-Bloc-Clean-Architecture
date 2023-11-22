import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_clean_architecture/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:flutter_bloc_clean_architecture/features/daily_news/presentation/bloc/article/remote/remote_article_state.dart';

import '../../widgets/article_tile.dart';

class DailyNews extends StatelessWidget {
  const DailyNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  _buildAppBar() {
    return AppBar(
      title: const Text(
        'Daily News',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }

  _buildBody() {
    return BlocBuilder<RemoteArticlesBloc, RemoteArticlesState>(builder: (_, state) {
      if (state is RemoteArticlesLoading) {
        return const Center(child: CupertinoActivityIndicator());
      }
      if (state is RemoteArticlesError) {
        return const Center(child: Icon(Icons.refresh));
      }
      if (state is RemoteArticlesDone) {
        return ListView.builder(
          itemBuilder: (_, index) {
            final article = state.articles![index];
            return ArticleWidget(
              article: article,
            );
          },
          itemCount: state.articles!.length,
        );
      }

      return const SizedBox();
    });
  }
}
