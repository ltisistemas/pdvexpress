import 'package:pdvexpress/app/core/domain/entities/api_response.dart';
import 'package:pdvexpress/app/core/domain/entities/produto.dart';

abstract class ProdutoDatasource {
  Future<ApiResponse> store(Produto produto);

  Future<ApiResponse> update(Produto produto);

  Future<ApiResponse> destroy(String uid);

  Future<ApiResponse> activated(String uid);
}
