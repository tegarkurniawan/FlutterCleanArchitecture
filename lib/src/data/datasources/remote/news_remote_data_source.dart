
import 'package:cleanapp/src/core/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:cleanapp/src/data/models/breaking_news_response_model.dart';

abstract class NewsRemoteDataSource {
  Future<Response> getBreakingNewsArticles({String apiKey, String country, String category, int page, int pageSize});
}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource{

  final dio = Dio();
  var baseUrl = kBaseUrl;
  
  @override
  Future<Response> getBreakingNewsArticles({String? apiKey, String? country, String? category, int? page, int? pageSize}) async{
    final queryParameters = <String, dynamic>{
      r'apiKey': apiKey,
      r'country': country,
      r'category': category,
      r'page': page,
      r'pageSize': pageSize
    };
    queryParameters.removeWhere((k, v) => v == null);
    const _extra = <String, dynamic>{};
    final _data = <String, dynamic>{};
    print(queryParameters);
    Response result = await dio.request(baseUrl+'/top-headlines',
        queryParameters: queryParameters,
        options: Options(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            ),
        data: _data);
    return result;
    // final value = BreakingNewsResponseModel.fromJson(result.data);
    // return value;
  }

}