import 'package:cleanapp/src/core/params/articles_request.dart';
import 'package:cleanapp/src/core/resources/data_state.dart';
import 'package:cleanapp/src/core/resources/state_enum.dart';
import 'package:cleanapp/src/domain/entities/article.dart';
import 'package:cleanapp/src/domain/usecase/articles_usecase.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class NewsListNotifier extends ChangeNotifier {
   final List<Article> article = [];
    int page = 1;
    String error = "";
    static const int _pageSize = 5;
    RequestState _newsState = RequestState.Empty;
    RequestState get newsState => _newsState;
    
    
    NewsListNotifier({required this.articlesUseCase});

    final ArticlesUseCase articlesUseCase;


   

    Future<void> getBreakingNewsArticle() async{
      // _page  = _page + page;
      print(page);
      if(page == 1){
        _newsState = RequestState.Loading;
      }
      notifyListeners();
      final dataState = await articlesUseCase(params: ArticlesRequestParams(page: page));

      if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
        _newsState = RequestState.Loaded;
        final articles = dataState.data;
        final noMoreData = articles!.length < _pageSize;
        article.addAll(articles);
        page++;
        notifyListeners();
      }
      if (dataState is DataFailed) {
        _newsState = RequestState.Error;
        error = "Mohon Maaf Server Sedang Sibuk";
        notifyListeners();
      }
   
  }
}