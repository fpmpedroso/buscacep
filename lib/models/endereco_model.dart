import 'dart:convert';

class EnderecoModel{

  final String cep;
  final String logradouro;
  final String complemento;

  EnderecoModel({
    required this.cep,
    required this.logradouro,
    required this.complemento,
  });

  //método para transformar a classe em uma mapa
  Map<String,dynamic> toMap(){
    return {
      'cep': cep,
      'logradouro': logradouro,
      'complemento': complemento
    };
  }

  //recebe um mapa e retorna um objeto do tipo EnderecoModel
  factory EnderecoModel.fromMap(Map<String, dynamic> map){
    return EnderecoModel(
      cep: map['cep'] ?? '',
      logradouro: map['logradouro'] ?? '',
      complemento: map['complemento'] ?? ''
    );
  }

  //recebe uma string json e chama o EnderecoModel
  factory EnderecoModel.fromJson(String json) =>
      EnderecoModel.fromMap(jsonDecode(json));

  String toJson() => jsonEncode(toMap());

}