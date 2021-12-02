

import 'dart:convert';

import 'package:cleanapp/src/core/params/articles_request.dart';
import 'package:cleanapp/src/core/resources/data_state.dart';
import 'package:cleanapp/src/data/datasources/remote/news_remote_data_source.dart';
import 'package:cleanapp/src/data/models/breaking_news_response_model.dart';
import 'package:cleanapp/src/domain/entities/article.dart';
import 'package:cleanapp/src/domain/repositories/articles_repository.dart';
import 'package:dio/dio.dart';

class ArticlesRepositoryImpl implements ArticlesRepository {
  final NewsRemoteDataSource newsApiService;


  const ArticlesRepositoryImpl({required this.newsApiService});

  @override
  Future<DataState<List<Article>>> getBreakingNewsArticles(ArticlesRequestParams params) async {
    try {
      Response res = await newsApiService.getBreakingNewsArticles(
        apiKey: params.apiKey,
        country: params.country,
        category: params.category,
        page: params.page,
        pageSize: params.pageSize,
      );

      if(res.statusCode == 200){
        
        var news = BreakingNewsResponseModel.fromJson(res.data);
        return DataSuccess(news.articles);
      }else{
        return DataFailed(
          DioError(
            error: res.statusMessage,
            response: res.data,
            type: DioErrorType.response, requestOptions: RequestOptions(path: ''),
          ),
        );
      }
    } on DioError catch (e) {
      return DataFailed(e);
    }
  }
  
}
