import 'package:pdvexpress/app/core/domain/entities/api_response.dart';
import 'package:pdvexpress/app/core/domain/entities/produto.dart';
import 'package:pdvexpress/app/core/domain/utils/constansts.dart';
import 'package:pdvexpress/app/core/infra/datasources/produto_datasource.dart';
import 'package:pdvexpress/app/core/infra/models/api_response_model.dart';

class ProdutoDatasourceImpl implements ProdutoDatasource {
  @override
  Future<ApiResponse> store(Produto produto) async {
    try {
      await storeInstance.collection('produtos').add({
        'uuid_usuario': produto.uuidUsuario,
        'nome': produto.nome,
        'descricao': produto.descricao,
        'quantidade': produto.quantidade,
        'valor': produto.valor,
      });

      return ApiResponseModel.ok(produto, '');
    } catch (e) {
      print('---> Datasource');
      print(e);
      return ApiResponseModel.error('Erro ao realizar o salvamento');
    }
  }

  @override
  Future<ApiResponse> update(Produto produto) async {
    try {
      await storeInstance.collection('produtos').doc(produto.uuid).update({
        'nome': produto.nome,
        'descricao': produto.descricao,
        'quantidade': produto.quantidade,
        'valor': produto.valor,
      });

      return ApiResponseModel.ok(produto, '');
    } catch (e) {
      print('---> Datasource');
      print(e);
      return ApiResponseModel.error('Erro ao realizar o salvamento');
    }
  }

  @override
  Future<ApiResponse> destroy(String uid) async {
    try {
      await storeInstance.collection('produtos').doc(uid).update({
        'active': false,
      });

      return ApiResponseModel.ok(true, '');
    } catch (e) {
      print('---> Datasource');
      print(e);
      return ApiResponseModel.error('Erro ao realizar o salvamento');
    }
  }

  @override
  Future<ApiResponse> activated(String uid) async {
    try {
      await storeInstance.collection('produtos').doc(uid).update({
        'active': true,
      });

      return ApiResponseModel.ok(true, '');
    } catch (e) {
      print('---> Datasource');
      print(e);
      return ApiResponseModel.error('Erro ao realizar o salvamento');
    }
  }
}
