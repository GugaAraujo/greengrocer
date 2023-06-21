import 'package:hello_world/src/models/category_model.dart';
import 'package:hello_world/src/models/item_model.dart';
import 'package:hello_world/src/pages/home/result/home_result.dart';

import '../../../constants/endpoints.dart';
import '../../../services/http_manager.dart';

class HomeRepository {
  final HttpManager _httpManager = HttpManager();

  Future<HomeResult<CategoryModel>> getAllCategories() async {
    final result = await _httpManager.restRequest(
      url: Endpoint.getAllCategories,
      method: HttpMethods.post,
    );

    if (result['result'] != null) {
      List<CategoryModel> data = (List<Map<String, dynamic>>.from(result['result']))
          .map(CategoryModel.fromJson)
          .toList();

      return HomeResult<CategoryModel>.success(data);

    } else {
      return HomeResult.error('Erro ao buscar categorias');
    }
  }

  Future<HomeResult<ItemModel>> getAllProducts(Map<String, dynamic> body) async {
    final result = await _httpManager.restRequest(
      url: Endpoint.getAllProducts,
      method: HttpMethods.post,
      body: body
    );

    if(result['result'] != null) {
      List<ItemModel> data = (List<Map<String, dynamic>>.from(result['result']))
          .map(ItemModel.fromJson)
          .toList();

      return HomeResult<ItemModel>.success(data);
    } else {
      return HomeResult.error('Erro ao buscar produtos');
    }
  }
}