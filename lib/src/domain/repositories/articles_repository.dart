import 'package:cleanapp/src/core/params/articles_request.dart';
import 'package:cleanapp/src/core/resources/data_state.dart';
import 'package:cleanapp/src/domain/entities/article.dart';

abstract class ArticlesRepository {
  // API methods
  Future<DataState<List<Article>>> getBreakingNewsArticles(ArticlesRequestParams params);
}