import 'package:calendario/components/details.dart';
import 'package:calendario/components/hemofilia.dart';
import 'package:flutter/material.dart';

class Perfil extends StatefulWidget {
  const Perfil({super.key});

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  String nome = '';
  String telefone = '';
  String tipoHemofilia = 'Tipo A';
  String dosagemFator = '';
  String ematologistaResponsavel = '';
  String cartaoSus = '';
  String nota = '';
  String hemofiliaGravidade = 'Leve';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Perfil"),
          centerTitle: true,
          backgroundColor: Color(0xFF202C39)),
      body: ListView(
        children: [
          //==========================FOTO========================
          const SizedBox(height: 50),
          Icon(Icons.person, size: 72),
          SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.only(left: 25),
            child: Text(
              'Detalhes',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
          //============================Usuário Detalhes=============================
          Details(
            isPhoneNumber: false,
            isNumeric: false,
            title: 'Nome',
            initialValue: nome,
            onSaved: (value) {
              setState(() {
                nome = value;
              });
            },
          ),
          Details(
            isPhoneNumber: true,
            isNumeric: true,
            title: 'Telefone',
            initialValue: formatPhoneNumber(telefone),
            onSaved: (value) {
              final formattedValue =
                  formatPhoneNumber(value); // Formate o valor ao salvar
              setState(() {
                telefone = formattedValue;
              });
            },
          ),
          //====================================Informações da hemofilia============================
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: EdgeInsets.only(left: 25),
            child: Text(
              'Informações sobre a Hemofilia',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(width: 0, color: Colors.transparent),
            ),
            padding: EdgeInsets.only(left: 15, bottom: 15),
            margin: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Text('Tipo de Hemofilia',
                    style: TextStyle(color: Color(0xffa6a6a6))),
                Material(
                  type: MaterialType.transparency,
                  child: HemofiliaSelector(
                    selectedValue: tipoHemofilia,
                    onChanged: (value) {
                      setState(() {
                        tipoHemofilia = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(width: 0, color: Colors.transparent),
            ),
            padding: EdgeInsets.only(left: 15, bottom: 15),
            margin: EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Text('Gravidade', style: TextStyle(color: Color(0xffa6a6a6))),
                Material(
                  type: MaterialType.transparency,
                  child: HemofiliaGravidade(
                    value: hemofiliaGravidade,
                    onChange: (value) {
                      setState(() {
                        hemofiliaGravidade = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Details(
            isPhoneNumber: false,
            isNumeric: true,
            title: 'Dosagem de Fator',
            initialValue: dosagemFator,
            onSaved: (value) {
              setState(() {
                dosagemFator = value;
              });
            },
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: EdgeInsets.only(left: 25),
            child: Text(
              'Informações adicionais',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
          Details(
            isPhoneNumber: false,
            isNumeric: false,
            title: 'Ematologista responsável',
            initialValue: ematologistaResponsavel,
            onSaved: (value) {
              setState(() {
                ematologistaResponsavel = value;
              });
            },
          ),
          Details(
            isPhoneNumber: false,
            isNumeric: true,
            title: 'Cartão SUS',
            initialValue: formatSUSCard(cartaoSus),
            onSaved: (value) {
              final formattedValue =
                  formatSUSCard(value); // Formate o valor ao salvar
              setState(() {
                cartaoSus = formattedValue;
              });
            },
          ),
          Details(
            isPhoneNumber: false,
            isNumeric: false,
            title: 'Observação',
            initialValue: nota,
            onSaved: (value) {
              setState(() {
                nota = value;
              });
            },
          )
        ],
      ),
    );
  }

  String formatPhoneNumber(String phoneNumber) {
    final cleaned = phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');
    final regex = RegExp(r'^(\d{2})(\d{5})(\d{4})$');

    if (regex.hasMatch(cleaned)) {
      final match = regex.firstMatch(cleaned);
      return '(${match?.group(1)}) ${match?.group(2)}-${match?.group(3)}';
    }

    return phoneNumber;
  }

  String formatSUSCard(String susCard) {
    final cleaned = susCard.replaceAll(RegExp(r'[^0-9]'), '');

    if (cleaned.length == 15) {
      return '${cleaned.substring(0, 3)}.${cleaned.substring(3, 6)}.${cleaned.substring(6, 9)}.${cleaned.substring(9, 12)}.${cleaned.substring(12, 15)}';
    }

    return susCard;
  }
}
