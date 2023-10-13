import 'package:calendario/components/button.dart';
import 'package:calendario/components/events_tile.dart';
import 'package:calendario/pages/home_page.dart';
import 'package:calendario/pages/perfil_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

DateTime focusedDay = DateTime.now();
DateTime? selectedDate = DateTime.now();

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

final user = FirebaseAuth.instance.currentUser!;
Map<String, dynamic> mySelectedEvents = {};
bool leve = false;
bool moderada = false;
bool grave = false;
bool costas = false;
bool cabeca = false;
bool cotoveloDireito = false;
bool cotoveloEsquerdo = false;
bool joelhoDireito = false;
bool joelhoEsquerdo = false;
bool tornozeloDireito = false;
bool tornozeloEsquerdo = false;
bool normal = false;
bool extra = false;
bool profilaxia = false;
bool button = false;
CalendarFormat format = CalendarFormat.month;

List listDays(DateTime dateTime) {
  final formattedDate = DateFormat('MM-dd-yyyy').format(dateTime);

  if (mySelectedEvents.containsKey(formattedDate)) {
    return mySelectedEvents[formattedDate]!;
  } else {
    return [];
  }
}

List<String> sangramentoList = [];
List<String> localList = [];
List<String> fatorList = [];

class _CalendarScreenState extends State<CalendarScreen> {
  final screens = [CalendarScreen(), Perfil()];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          actions: [
            PopupMenuButton(
                itemBuilder: (context) => [
                      PopupMenuItem(
                        child:
                            TextButton(onPressed: logout, child: Text('Sair')),
                      )
                    ])
          ],
          title: Text('Calendário'),
          centerTitle: true,
          backgroundColor: Color(0xFF202C39),
        ),
        floatingActionButton: Align(
          alignment: Alignment(0.9, 0.8),
          child: FloatingActionButton(
            backgroundColor: Color(0xFF202C39),
            child: Icon(Icons.add),
            onPressed: () {
              modal();
            },
          ),
        ),
        extendBody: true,
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 6, left: 10),
                child: Text(
                  'Olá,',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 5, left: 10),
                child: Text(
                  'Como você está hoje?',
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 5),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Material(
                        borderRadius: BorderRadius.circular(15),
                        elevation: 2,
                        child: TableCalendar(
                          calendarBuilders: CalendarBuilders(
                            markerBuilder: (context, day, events) => events
                                    .isNotEmpty
                                ? Padding(
                                    padding: EdgeInsets.only(bottom: 7),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(
                                            right: 3,
                                          ),
                                          width: 15,
                                          height: 18,
                                          alignment: Alignment.topRight,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: const Color.fromARGB(
                                                255, 59, 144, 255),
                                          ),
                                          child: Text(
                                            '${events.length}',
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                : null,
                          ),
                          focusedDay: focusedDay,
                          firstDay: DateTime(2020),
                          lastDay: DateTime(2025),
                          onDaySelected: (newSelectedDay, newFocusedDay) {
                            if (!isSameDay(selectedDate, newSelectedDay)) {
                              setState(() {
                                selectedDate = newSelectedDay;
                                focusedDay = newFocusedDay;
                              });
                            }
                          },
                          eventLoader: listDays,
                          selectedDayPredicate: (day) {
                            return isSameDay(selectedDate, day);
                          },
                          locale: 'pt_BR',
                          calendarFormat: format,
                          headerStyle: HeaderStyle(
                            titleTextStyle: TextStyle(color: Colors.white),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  topRight: Radius.circular(5)),
                              color: Color(0xFF202C39),
                            ),
                            formatButtonVisible: false,
                            titleCentered: true,
                            leftChevronIcon: Icon(
                              Icons.chevron_left,
                              color: Colors.white,
                            ),
                            rightChevronIcon: Icon(
                              Icons.chevron_right,
                              color: Colors.white,
                            ),
                            rightChevronPadding: EdgeInsets.only(right: 80),
                            leftChevronPadding: EdgeInsets.only(left: 80),
                          ),
                          calendarStyle: CalendarStyle(
                            weekendTextStyle: TextStyle(color: Colors.red),
                            selectedDecoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF202C39),
                            ),
                            todayDecoration: (BoxDecoration(
                                color: Colors.grey, shape: BoxShape.circle)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    ...listDays(selectedDate!).map(
                      (myEvents) {
                        List<Widget> eventTexts = [];
                        if (myEvents['sangramento'] != null &&
                            myEvents['sangramento'].isNotEmpty) {
                          eventTexts.add(Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 224, 38, 25),
                                    borderRadius: BorderRadius.circular(50)),
                                child: Padding(
                                  padding: EdgeInsets.all(6),
                                  child: Image.asset(
                                    'assets/images/lesões.png',
                                    color: Colors.white,
                                    height: 20,
                                    width: 20,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Lesão:",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "${myEvents['sangramento']}",
                              ),
                            ],
                          ));
                        }

                        if (myEvents['fator'] != null &&
                            myEvents['fator'].isNotEmpty) {
                          eventTexts.add(Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 105, 145, 221),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(6),
                                  child: Image.asset(
                                    'assets/images/fator.png',
                                    color: Colors.white,
                                    height: 20,
                                    width: 20,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "Fator:",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                "${myEvents['fator']}",
                              ),
                            ],
                          ));
                        }

                        if (myEvents['local'] != null &&
                            myEvents['local'].isNotEmpty) {
                          eventTexts.add(
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color:
                                        const Color.fromARGB(255, 9, 167, 106),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(6),
                                    child: Image.asset(
                                      'assets/images/corpo.png',
                                      color: Colors.white,
                                      width: 20,
                                      height: 20,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  ('Local: '),
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text('${myEvents['local']}'),
                              ],
                            ),
                          );
                        }

                        return Slidable(
                          endActionPane: ActionPane(
                            motion: StretchMotion(),
                            children: [
                              SlidableAction(
                                borderRadius: BorderRadius.circular(5),
                                label: 'Deletar',
                                backgroundColor: Colors.red,
                                icon: Icons.delete,
                                onPressed: (context) {
                                  _deleteEvent(myEvents);
                                },
                              )
                            ],
                          ),
                          child: ListTile(
                            title: Padding(
                              padding: EdgeInsets.only(bottom: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: eventTexts,
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void modal() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext contest, StateSetter setState) {
            return SizedBox(
              height: 500,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: 10, bottom: 0, left: 15, right: 15),
                      child: Row(
                        children: const [
                          Text(
                            'Lesões',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Opção Leve
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomColoredImageContainer(
                                imagePath: 'assets/images/leve.png',
                                defaultImageColor:
                                    Color.fromARGB(255, 201, 20, 7),
                                tappedImageColor:
                                    leve ? Colors.white : Colors.transparent,
                                onImageTap: (isTapped) {
                                  setState(() {
                                    leve = isTapped;
                                  });
                                },
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                'Leve',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          // Opção Moderado
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomColoredImageContainer(
                                imagePath: 'assets/images/moderado.png',
                                defaultImageColor:
                                    Color.fromARGB(255, 201, 20, 7),
                                tappedImageColor: moderada
                                    ? Colors.white
                                    : Colors.transparent,
                                onImageTap: (isTapped) {
                                  setState(() {
                                    moderada = isTapped;
                                  });
                                },
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                'Moderado',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          // Opção Grave
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomColoredImageContainer(
                                imagePath: 'assets/images/grave.png',
                                defaultImageColor:
                                    Color.fromARGB(255, 201, 20, 7),
                                tappedImageColor:
                                    grave ? Colors.white : Colors.transparent,
                                onImageTap: (isTapped) {
                                  setState(() {
                                    grave = isTapped;
                                  });
                                },
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                'Grave',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        children: const [
                          Text(
                            'Local da lesão',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Opção Costas
                          Column(
                            children: [
                              CustomColoredImageContainer(
                                imagePath: 'assets/images/costas.png',
                                defaultImageColor:
                                    Color.fromARGB(255, 9, 167, 106),
                                tappedImageColor:
                                    costas ? Colors.white : Colors.transparent,
                                onImageTap: (isTapped) {
                                  setState(() {
                                    costas = isTapped;
                                  });
                                },
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                'Costas\n ',
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          // Opção Cabeça
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomColoredImageContainer(
                                imagePath: 'assets/images/cabeça.png',
                                defaultImageColor:
                                    Color.fromARGB(255, 9, 167, 106),
                                tappedImageColor:
                                    cabeca ? Colors.white : Colors.transparent,
                                onImageTap: (isTapped) {
                                  setState(() {
                                    cabeca = isTapped;
                                  });
                                },
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                'Cabeça\n ',
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          // Opção Cotovelo direito
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomColoredImageContainer(
                                imagePath: 'assets/images/cotovelo_direito.png',
                                defaultImageColor:
                                    Color.fromARGB(255, 9, 167, 106),
                                tappedImageColor: cotoveloDireito
                                    ? Colors.white
                                    : Colors.transparent,
                                onImageTap: (isTapped) {
                                  setState(() {
                                    cotoveloDireito = isTapped;
                                  });
                                },
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                'Cotovelo\ndireito',
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          // Opção Cotovelo esquerdo
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomColoredImageContainer(
                                imagePath:
                                    'assets/images/cotovelo_esquerdo.png',
                                defaultImageColor:
                                    Color.fromARGB(255, 9, 167, 106),
                                tappedImageColor: cotoveloEsquerdo
                                    ? Colors.white
                                    : Colors.transparent,
                                onImageTap: (isTapped) {
                                  setState(() {
                                    cotoveloEsquerdo = isTapped;
                                  });
                                },
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                'Cotovelo\nesquerdo',
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          // Opção Joelho direito
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomColoredImageContainer(
                                imagePath: 'assets/images/joelho_direito.png',
                                defaultImageColor:
                                    Color.fromARGB(255, 9, 167, 106),
                                tappedImageColor: joelhoDireito
                                    ? Colors.white
                                    : Colors.transparent,
                                onImageTap: (isTapped) {
                                  setState(() {
                                    joelhoDireito = isTapped;
                                  });
                                },
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                'Joelho\ndireito',
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          // Opção Joelho esquerdo
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomColoredImageContainer(
                                imagePath: 'assets/images/joelho_esquerdo.png',
                                defaultImageColor:
                                    Color.fromARGB(255, 9, 167, 106),
                                tappedImageColor: joelhoEsquerdo
                                    ? Colors.white
                                    : Colors.transparent,
                                onImageTap: (isTapped) {
                                  setState(() {
                                    joelhoEsquerdo = isTapped;
                                  });
                                },
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                'Joelho\nesquerdo',
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          // Opção Tornozelo direito
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomColoredImageContainer(
                                imagePath:
                                    'assets/images/tornozelo_direito.png',
                                defaultImageColor:
                                    Color.fromARGB(255, 9, 167, 106),
                                tappedImageColor: tornozeloDireito
                                    ? Colors.white
                                    : Colors.transparent,
                                onImageTap: (isTapped) {
                                  setState(() {
                                    tornozeloDireito = isTapped;
                                  });
                                },
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                'Tornozelo\ndireito',
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          // Opção Tornozelo esquerdo
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomColoredImageContainer(
                                imagePath:
                                    'assets/images/tornozelo_esquerdo.png',
                                defaultImageColor:
                                    Color.fromARGB(255, 9, 167, 106),
                                tappedImageColor: tornozeloEsquerdo
                                    ? Colors.white
                                    : Colors.transparent,
                                onImageTap: (isTapped) {
                                  setState(() {
                                    tornozeloEsquerdo = isTapped;
                                  });
                                },
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                'Tornozelo \nesquerdo',
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        children: const [
                          Text(
                            'Uso de Fator',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomColoredImageContainer(
                                imagePath: 'assets/images/profilaxia.png',
                                defaultImageColor:
                                    Color.fromARGB(255, 105, 145, 221),
                                tappedImageColor: profilaxia
                                    ? Colors.white
                                    : Colors.transparent,
                                onImageTap: (isTapped) {
                                  setState(() {
                                    profilaxia = isTapped;
                                  });
                                },
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                'Profilaxia',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              )
                            ],
                          ),
                          SizedBox(width: 10),
                          // Opção Dose normal
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomColoredImageContainer(
                                imagePath: 'assets/images/normal.png',
                                defaultImageColor:
                                    Color.fromARGB(255, 105, 145, 221),
                                tappedImageColor:
                                    normal ? Colors.white : Colors.transparent,
                                onImageTap: (isTapped) {
                                  setState(() {
                                    normal = isTapped;
                                  });
                                },
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                'Dose normal',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              )
                            ],
                          ),
                          SizedBox(width: 10),
                          // Opção Dose extra
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomColoredImageContainer(
                                imagePath: 'assets/images/extra.png',
                                defaultImageColor:
                                    Color.fromARGB(255, 105, 145, 221),
                                tappedImageColor:
                                    extra ? Colors.white : Colors.transparent,
                                onImageTap: (isTapped) {
                                  setState(() {
                                    extra = isTapped;
                                  });
                                },
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                'Dose extra',
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              )
                            ],
                          ),
                          SizedBox(width: 20),
                        ],
                      ),
                    ),
                    SizedBox(height: 5),
                    SaveButton(
                      onTap: () {
                        setState(() {
                          if (leve) {
                            sangramentoList.add('Leve');
                          }
                          if (moderada) {
                            sangramentoList.add('Moderado');
                          }
                          if (grave) {
                            sangramentoList.add('Grave');
                          }

                          if (cabeca) {
                            localList.add('Cabeça');
                          }
                          if (costas) {
                            localList.add('Costas');
                          }
                          if (cotoveloDireito) {
                            localList.add('Cotovelo direito');
                          }

                          if (cotoveloEsquerdo) {
                            localList.add('Cotovelo esquerdo');
                          }

                          if (joelhoDireito) {
                            localList.add('Joelho direito');
                          }

                          if (joelhoEsquerdo) {
                            localList.add('Joelho esquerdo');
                          }

                          if (tornozeloDireito) {
                            localList.add('Tornozelo direito');
                          }

                          if (tornozeloEsquerdo) {
                            localList.add('Tornozelo esquerdo');
                          }
                          // Add other local options similarly.

                          if (normal) {
                            fatorList.add('Dose normal');
                          }
                          if (extra) {
                            fatorList.add('Dose extra');
                          }
                          if (profilaxia) {
                            fatorList.add('Profilaxia');
                          }

                          if (sangramentoList.isNotEmpty ||
                              fatorList.isNotEmpty ||
                              localList.isNotEmpty) {
                            String sangramento = sangramentoList.join(', ');
                            String local = localList.join(', ');
                            String fator = fatorList.join(', ');

                            if (sangramento.isNotEmpty) {
                              addEventBleed(sangramento);
                            }
                            if (fator.isNotEmpty) {
                              addEventFator(fator);
                            }
                            if (local.isNotEmpty) {
                              addEventLocal(local);
                            }
                            sangramentoList = [];
                            localList = [];
                            fatorList = [];
                            leve = false;
                            moderada = false;
                            grave = false;
                            costas = false;
                            cabeca = false;
                            cotoveloDireito = false;
                            cotoveloEsquerdo = false;
                            joelhoDireito = false;
                            joelhoEsquerdo = false;
                            tornozeloDireito = false;
                            tornozeloEsquerdo = false;
                            normal = false;
                            extra = false;
                            profilaxia = false;
                            Navigator.pop(context);

                            // Reset your flags here if needed.
                          }
                        });
                      },
                      text: 'Salvar',
                      buttonColor: leve ||
                              moderada ||
                              grave ||
                              cabeca ||
                              costas ||
                              cotoveloDireito ||
                              cotoveloEsquerdo ||
                              joelhoDireito ||
                              joelhoEsquerdo ||
                              tornozeloDireito ||
                              tornozeloEsquerdo ||
                              normal ||
                              extra ||
                              profilaxia
                          ? Color(0xff202C39)
                          : const Color.fromARGB(255, 202, 199, 199),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void addEventBleed(String sangramento) {
    setState(() {
      if (mySelectedEvents[DateFormat('MM-dd-yyyy').format(selectedDate!)] !=
          null) {
        mySelectedEvents[DateFormat('MM-dd-yyyy').format(selectedDate!)]?.add({
          "sangramento": sangramento,
        });
      } else {
        mySelectedEvents[DateFormat('MM-dd-yyyy').format(selectedDate!)] = [
          {
            "sangramento": sangramento,
          }
        ];
      }
    });
  }

  void addEventLocal(String local) {
    setState(() {
      if (mySelectedEvents[DateFormat('MM-dd-yyyy').format(selectedDate!)] !=
          null) {
        mySelectedEvents[DateFormat('MM-dd-yyyy').format(selectedDate!)]?.add({
          "local": local,
        });
      } else {
        mySelectedEvents[DateFormat('MM-dd-yyyy').format(selectedDate!)] = [
          {
            "local": local,
          }
        ];
      }
    });
  }

  void addEventFator(String fator) {
    setState(() {
      if (mySelectedEvents[DateFormat('MM-dd-yyyy').format(selectedDate!)] !=
          null) {
        mySelectedEvents[DateFormat('MM-dd-yyyy').format(selectedDate!)]?.add({
          "fator": fator,
        });
      } else {
        mySelectedEvents[DateFormat('MM-dd-yyyy').format(selectedDate!)] = [
          {
            "fator": fator,
          }
        ];
      }
    });
  }

  void _deleteEvent(Map<String, String> event) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Excluir'),
          content: Text('Tem certeza de que deseja excluir?'),
          actions: [
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop(); // Fecha o alerta
              },
            ),
            TextButton(
              child: Text(
                'Excluir',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                setState(() {
                  final selectedDateKey =
                      DateFormat('MM-dd-yyyy').format(selectedDate!);
                  mySelectedEvents[selectedDateKey]?.remove(event);
                  if (mySelectedEvents[selectedDateKey]?.isEmpty ?? false) {
                    mySelectedEvents.remove(selectedDateKey);
                  }
                });

                Navigator.of(context).pop(); // Fecha o alerta
              },
            ),
          ],
        );
      },
    );
  }
}
