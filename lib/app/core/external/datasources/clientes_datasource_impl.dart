import 'package:pdvexpress/app/core/domain/entities/api_response.dart';
import 'package:pdvexpress/app/core/domain/entities/cliente.dart';
import 'package:pdvexpress/app/core/domain/utils/constansts.dart';
import 'package:pdvexpress/app/core/infra/datasources/clientes_datasource.dart';
import 'package:pdvexpress/app/core/infra/models/api_response_model.dart';

class ClientesDatasourceImpl implements ClientesDatasource {
  @override
  Future<ApiResponse> store(Cliente cliente) async {
    try {
      await storeInstance.collection('clientes').add({
        'uuid_usuario': cliente.uuidUsuario,
        'nome': cliente.nome,
        'telefone': cliente.telefone,
        'email': cliente.email,
        'active': true,
      });

      return ApiResponseModel.ok(cliente, '');
    } catch (e) {
      print('---> Datasource');
      print(e);
      return ApiResponseModel.error('Erro ao realizar o salvamento');
    }
  }

  @override
  Future<ApiResponse> activated(String uid) async {
    try {
      await storeInstance.collection('clientes').doc(uid).update({
        'active': true,
      });

      return ApiResponseModel.ok(true, '');
    } catch (e) {
      print('---> Datasource');
      print(e);
      return ApiResponseModel.error('Erro ao realizar o salvamento');
    }
  }

  @override
  Future<ApiResponse> destroy(String uid) async {
    try {
      await storeInstance.collection('clientes').doc(uid).update({
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
  Future<ApiResponse> update(Cliente cliente) async {
    try {
      await storeInstance.collection('clientes').doc(cliente.uuid).update({
        'nome': cliente.nome,
        'telefone': cliente.telefone,
        'email': cliente.email,
      });

      return ApiResponseModel.ok(cliente, '');
    } catch (e) {
      print('---> Datasource');
      print(e);
      return ApiResponseModel.error('Erro ao realizar o salvamento');
    }
  }
}
