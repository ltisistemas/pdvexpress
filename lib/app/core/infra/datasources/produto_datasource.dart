import 'package:pdvexpress/app/core/domain/entities/api_response.dart';
import 'package:pdvexpress/app/core/domain/entities/produto.dart';

abstract class ProdutoDatasource {
  Future<ApiResponse> store(Produto produto);
}
