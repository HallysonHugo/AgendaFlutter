import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:uex/app/modules/contact/controller/contact_controller.dart';
import 'package:uex/app/modules/contact/model/address_model.dart';
import 'package:uex/widgets/dialog/custom_dialogs.dart';
import 'package:uex/widgets/text_field/custom_address_field.dart';
import 'package:uex/widgets/text_field/custom_text_field.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ListContactsPage extends StatefulWidget {
  static const String routeName = '/';
  const ListContactsPage({super.key});

  @override
  State<ListContactsPage> createState() => _ListContactsPageState();
}

class _ListContactsPageState extends State<ListContactsPage> {
  final TextEditingController _searchController = TextEditingController();
  final ContactController _contactController = Modular.get();

  @override
  void initState() {
    _contactController.getContacts();
    super.initState();
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                CustomTextField(
                  prefix: const Icon(Icons.search),
                  margin: const EdgeInsets.all(5),
                  controller: _searchController,
                  label: const Text('Pesquisar Contato'),
                  onChanged: (text){
                    _contactController.searchContacts(search: text);
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 35,
                        margin: const EdgeInsets.only(left:20, right: 20),
                        child: ElevatedButton(
                          onPressed: ()async{
                            final TextEditingController nameController = TextEditingController();
                            final TextEditingController phoneController = TextEditingController();
                            final TextEditingController cpfController = TextEditingController();
                            final TextEditingController cepController = TextEditingController();
                            final TextEditingController bairroController = TextEditingController();
                            final TextEditingController logradouroController = TextEditingController();
                            final TextEditingController addressController = TextEditingController();
                            AddressModel addressModel = AddressModel();

                            await showDialog(context: context, builder: (context){
                              return Dialog(
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.4,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const SizedBox(height: 20),
                                      Text('Novo Contato', style: Theme.of(context).textTheme.titleLarge),
                                      const SizedBox(height: 20),
                                      CustomTextField(
                                        controller: nameController,
                                        label: const Text('Nome'),
                                        margin: const EdgeInsets.only(left: 40, right: 40),
                                      ),
                                      const SizedBox(height: 10),
                                      CustomTextField(
                                        controller: cpfController,
                                        label: const Text('CPF'),
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly,
                                          CpfInputFormatter(),
                                        ],
                                        margin: const EdgeInsets.only(left: 40, right: 40),
                                      ),
                                      const SizedBox(height: 10),
                                      CustomTextField(
                                        inputFormatters: [
                                          FilteringTextInputFormatter.digitsOnly,
                                          TelefoneInputFormatter(),
                                        ],
                                        controller: phoneController,
                                        label: const Text('Telefone'),
                                        margin: const EdgeInsets.only(left: 40, right: 40),
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: CustomTypeAhead<AddressModel>(
                                              controller: addressController,
                                              label: const Text('Endereço'),
                                              margin: const EdgeInsets.only(left: 40, right: 5),
                                              itemBuilder: (context, AddressModel addressModel){
                                                return ListTile(
                                                  title: Text(addressModel.logradouro),
                                                  subtitle: Text(addressModel.bairro),
                                                );
                                              },
                                              suggestionsCallback: (search)async{
                                                return await _contactController.getListAddresses(search: search);
                                              },
                                              onSuggestionSelected: (AddressModel addressModel){
                                                cepController.text = addressModel.cep;
                                                bairroController.text = addressModel.bairro;
                                                logradouroController.text = addressModel.logradouro;
                                              },
                                            )
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context).size.width * 0.1,
                                            child: CustomTextField(
                                            onChanged: (text)async{
                                              if(text.length == 10){
                                                addressModel = await _contactController.getAddress(cep: text);
                                                bairroController.text = addressModel.bairro;
                                                logradouroController.text = addressModel.logradouro;
                                              }
                                            },
                                            inputFormatters: [
                                              FilteringTextInputFormatter.digitsOnly,
                                              CepInputFormatter(),
                                            ],
                                            controller: cepController,
                                            label: const Text('CEP'),
                                            margin: const EdgeInsets.only(left: 5, right: 40),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: CustomTextField(
                                              controller: logradouroController,
                                              label: const Text('Logradouro'),
                                              margin: const EdgeInsets.only(left: 40, right: 5),
                                            ),
                                          ),
                                          Expanded(
                                            child: CustomTextField(
                                              controller: bairroController,
                                              label: const Text('Bairro'),
                                              margin: const EdgeInsets.only(left: 5, right: 40),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 20),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          ElevatedButton(
                                            onPressed: (){
                                              Modular.to.pop();
                                            }, 
                                            child: const Text('Cancelar'),
                                          ),
                                          ElevatedButton(
                                            onPressed: ()async{
                                              try{
                                                await _contactController.saveContacts(
                                                  telefone: phoneController.text,
                                                  name: nameController.text, 
                                                  cpf: cpfController.text, 
                                                  address: addressModel
                                                );
                                                Modular.to.pop();
                                              }
                                              catch(e){
                                                CustomDialog.errorDialog(context: context, error: e.toString());
                                              }
                                            }, 
                                            child: const Text('Salvar'),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 20),
                                    ],
                                  ),
                                )
                              );
                            });
                            _contactController.getContacts();
                          }, 
                          child: const Text('Novo Contato'),
                        )
                      ),
                    ),
                  ],
                ),
                Observer(
                  builder: (context) {
                    if(_contactController.contacts.isEmpty){
                      return const Center(
                        child: Text('Nenhum contato encontrado'),
                      );
                    }
                    return Expanded(
                      child: ListView.separated(
                        separatorBuilder: (context, index) => const Divider(),
                        itemCount: _contactController.contacts.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: (){
                              for (var element in _contactController.contacts) {
                                if(element != _contactController.contacts[index]){
                                  element.selected = false;
                                  }
                                }
                                _contactController.contacts[index].selected = true;
                                setState((){});
                            },
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              margin: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                border: Border.all(color: _contactController.contacts[index].selected ? Colors.blue : Colors.transparent),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(_contactController.contacts[index].name),
                                        Text('CPF: ${_contactController.contacts[index].cpf}'),
                                        Text('Logradouro: ${_contactController.contacts[index].address.logradouro}'),
                                        Text('Bairro: ${_contactController.contacts[index].address.bairro}'),
                                        Text('Telefone: ${_contactController.contacts[index].telefone}'),
                                        
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: ()async{
                                      await showDialog(
                                        context: context, 
                                        builder: (context){
                                          return Dialog(
                                            child: Container(
                                              constraints: const BoxConstraints(maxWidth: 400),
                                              margin: const EdgeInsets.all(10),
                                              padding: const EdgeInsets.all(10),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Text('Atencão', style: Theme.of(context).textTheme.titleLarge),
                                                  const SizedBox(height: 20),
                                                  Text('Deseja realmente excluir o contato ${_contactController.contacts[index].name}?'),
                                                  const SizedBox(height: 20),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                    children: [
                                                      ElevatedButton(
                                                        onPressed: (){
                                                          Modular.to.pop();
                                                        }, 
                                                        child: const Text('Cancelar'),
                                                      ),
                                                      const SizedBox(width: 10),
                                                      ElevatedButton(
                                                        onPressed: ()async{
                                                          await _contactController.deleteContact(contactModel: _contactController.contacts[index]);
                                                          Modular.to.pop();
                                                        }, 
                                                        child: const Text('Excluir'),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }
                                      );
                                    }, 
                                    icon: const Icon(Icons.delete, color: Colors.red,))
                                ],
                              ),
                            ),
                          );
                          }
                        ),
                    );
                  }
                ),
              ],
            ),
          ),
          Expanded(
            child: PointerInterceptor(
              intercepting: true,
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: const CameraPosition(
                  target: LatLng(-23.563090, -46.656900),
                  zoom: 14.4746,
                ),
                onMapCreated: (GoogleMapController controller){},
              ), 
            ),
          )
        ],
      ),
    );
  }
}