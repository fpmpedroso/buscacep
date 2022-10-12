import 'package:buscacep/models/endereco_model.dart';

abstract class CepRopository {

  //método que obrigatoriamente deverá ser correspondido por quem implementá-lo
  Future<EnderecoModel> getCep(String cep);

}