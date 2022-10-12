import 'dart:ui';

import 'package:buscacep/models/endereco_model.dart';
import 'package:buscacep/repositories/cep_repository.dart';
import 'package:buscacep/repositories/cep_repository_impl.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final CepRopository cepRopository = CepRepositoryImpl();
  EnderecoModel? enderecoModel;

  //inicia o status carregando como falso
  bool loading = false;

  //recupera-se os dados do formulário
  final formKey = GlobalKey<FormState>();

  //recupera-se o que foi digitado (obs: toda controladora deve ser descartada qdo não usada)
  final cepEC = TextEditingController();

  @override
  void dispose() {

    //descartar a controladora qdo deixar de ser usada
    cepEC.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Buscar CEP"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: cepEC,
                validator: (value){
                  if (value == null || value.isEmpty){
                    return 'CEP obrigatório';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () async{
                  final valid = formKey.currentState?.validate() ?? false;

                  if (valid){
                    try {

                      setState(() {
                        loading = true;
                      });

                      final endereco = await cepRopository.getCep(cepEC.text);

                      setState(() {
                        loading = false;
                        enderecoModel = endereco;
                      });
                    }catch(e){
                      setState(() {
                        loading = false;
                        enderecoModel = null;
                      });

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(
                          'Erro ao buscar o endereço'
                      )));
                    }

                  }
                },
                child: const Text("Buscar"),
              ),
              Visibility(
                visible: loading,
                child: const CircularProgressIndicator(),
              ),
              Visibility(
                visible: enderecoModel != null,
                child: Text(
                  '${enderecoModel?.logradouro} ${enderecoModel?.complemento} ${enderecoModel?.cep}'
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

