
import 'package:cleanapp/src/core/resources/state_enum.dart';
import 'package:cleanapp/src/domain/entities/article.dart';
import 'package:cleanapp/src/persentation/provider/news_list_notifier.dart';
import 'package:cleanapp/src/persentation/view/widget/article_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class BreakingNewsView extends HookWidget {
   BreakingNewsView({Key? key}) : super(key: key);

  var loads = false;

  @override
  Widget build(BuildContext context) {
     Future.microtask(() =>
        Provider.of<NewsListNotifier>(context, listen: false)
            .getBreakingNewsArticle());
    final scrollController = useScrollController();

    useEffect(() {
      scrollController.addListener(() => _onScrollListener(context, scrollController));
      return scrollController.dispose;
    }, [scrollController]);

    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(scrollController),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text('Daily News', style: TextStyle(color: Colors.black)),
    );
  }

  Widget _buildBody(ScrollController scrollController) {
   
    return Consumer<NewsListNotifier>(
       builder: (context, data, child) {
            if (data.newsState == RequestState.Loading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
            } else if (data.newsState == RequestState.Loaded) {
              loads = false;
              return _buildArticle(scrollController, data.article);
            } else {
              return Center(
                key: Key('error_message'),
                child: Text(data.error),
              );
            }
       }
    );
  }

  Widget _buildArticle(
    ScrollController scrollController,
    List<Article> articles,
  ) {
    return ListView(
      controller: scrollController,
      children: [
        // Items
        ...List<Widget>.from(
          articles.map(
            (e) => Builder(
              builder: (context) => ArticleWidget(
                article: e,
              ),
            ),
          ),
        ),
        _loading(),
      ],
    );
  }

  Widget _loading(){
    return Center(
                child: CircularProgressIndicator(),
              );
  }

  void _onScrollListener(BuildContext context, ScrollController scrollController) {
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.position.pixels;
    if (currentScroll == maxScroll) {
      loads = true;
      Future.microtask(() =>
        Provider.of<NewsListNotifier>(context, listen: false)
            .getBreakingNewsArticle());
    }
  }

 
}

