import 'package:hive/hive.dart';
import 'package:uex/app/service/database.dart';

part 'address_model.g.dart';

@HiveType(typeId: Database.adressHiveTypeId)
class AddressModel{

  @HiveField(0)
  String latitude = '';

  @HiveField(1)
  String longitude = '';

  @HiveField(2)
  String cep = '';

  @HiveField(3)
  String logradouro = '';

  @HiveField(4)
  String complemento = '';

  @HiveField(5)
  String bairro = '';

  @HiveField(6)
  String cidade = '';

  @HiveField(7)
  String uf = '';
  

  AddressModel();


  AddressModel.fromJson(Map<String, dynamic> json){
    cep = json['cep'];
    logradouro = json['logradouro'];
    complemento = json['complemento'];
    bairro = json['bairro'];
    cidade = json['localidade'];
    uf = json['uf'];
  }
}