import 'package:cleanapp/src/core/params/articles_request.dart';
import 'package:cleanapp/src/core/resources/data_state.dart';
import 'package:cleanapp/src/core/usecase/usecase.dart';
import 'package:cleanapp/src/domain/entities/article.dart';
import 'package:cleanapp/src/domain/repositories/articles_repository.dart';

class ArticlesUseCase implements UseCase<DataState<List<Article>>, ArticlesRequestParams> {
  final ArticlesRepository articlesRepository;

  ArticlesUseCase(this.articlesRepository);

  @override
  Future<DataState<List<Article>>> call({ArticlesRequestParams? params}) {
    return articlesRepository.getBreakingNewsArticles(params!);
  }
}
