import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Functions/chargement.dart';
import 'class/message.dart';
import 'dart:async';
import 'dart:ui';

import 'package:intl/intl.dart';
// dans le pubsec : intl: ^0.18.1

import 'package:basic_utils/basic_utils.dart';
// dans le pubsec : basic_utils: ^5.6.1

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Message> liste = [];
  @override
  void initState() {
    super.initState();
    //liste = initList(liste);
    chargement();
  }

  void chargement() async {
    liste = await initList2(liste);
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView.builder(
          itemCount: liste.length,
          itemBuilder: ((context, index) {
            return InkWell(
                onTap: () {
                  print(liste[index].getTitre());
                },
                child: Card(
                    child: Row(children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(top: 10, left: 5, bottom: 10),
                          child: Text(StringUtils.capitalize(liste[index].getTitre()))),
                      Row(children: [
                        const Padding(padding: EdgeInsets.only(top: 5, left: 5, bottom: 5), child: Icon(Icons.person)),
                        Text(
                          "auteur $index | ",
                          style: TextStyle(fontSize: 10),
                        ),
                        Text(DateFormat('HH:mm dd-MM-yyyy').format(liste[index].getDateEnvoie()),
                            style: TextStyle(fontSize: 10))
                      ])
                    ],
                  )
                ])));
          })),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
