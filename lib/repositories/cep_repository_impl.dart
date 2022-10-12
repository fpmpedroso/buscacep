import 'dart:math';

import 'package:buscacep/models/endereco_model.dart';
import 'package:buscacep/repositories/cep_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class CepRepositoryImpl implements CepRopository{

  //cumpre-se a obrigatoriedade do contrato (classe abstrata CepRepository)
  @override
  Future<EnderecoModel> getCep(String cep) async{

    try {
      //busca-se através do Dio, os dados json do site informado
      final result = await Dio().get('https://viacep.com.br/ws/$cep/json/');

      //retorna-se um objeto ao chamar o método e passar um valor
      return EnderecoModel.fromMap(result.data);

    }on DioError catch (e){
      debugPrint('Erro ao buscar o cep erro: $e');
      throw Exception('Erro ao buscar o cep');
    }

  }

}