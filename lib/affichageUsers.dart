import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Functions/chargement.dart';
import 'affichageMessages.dart';
import 'class/user.dart';
import 'dart:async';
import 'dart:ui';

import 'package:intl/intl.dart';
// dans le pubsec : intl: ^0.18.1

import 'package:basic_utils/basic_utils.dart';
// dans le pubsec : basic_utils: ^5.6.1

class ListeUserHomePage extends StatefulWidget {
  const ListeUserHomePage({super.key, required this.title});
  final String title;
  @override
  State<ListeUserHomePage> createState() => _ListeUserHomePageState();
}

class _ListeUserHomePageState extends State<ListeUserHomePage> {
  List<User> liste = [];
  @override
  void initState() {
    super.initState();
    //liste = initList(liste);
    chargement();
  }

  void chargement() async {
    liste = await initUserList(liste);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          widget.title,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Icône de retour (flèche vers la gauche)
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) =>
                    ListeMessageHomePage(title: 'Forum | Liste des messages'), // Remplacez par le titre approprié
              ),
            );
          },
        ),
      ),
      body: ListView.builder(
          itemCount: liste.length,
          itemBuilder: ((context, index) {
            return InkWell(
                onTap: () {},
                child: Card(
                    child: Row(children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(top: 10, left: 7, bottom: 10),
                          child: Text(
                              "${StringUtils.capitalize(liste[index].getNom())} ${StringUtils.capitalize(liste[index].getPrenom())}")),
                      Row(children: [
                        const Padding(padding: EdgeInsets.only(top: 5, left: 5, bottom: 5), child: Icon(Icons.person)),
                        Text(
                          "User : ${liste[index].getId()} | Inscrit le : ",
                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                        Text(DateFormat('dd-MM-yyyy').format(liste[index].getDateInscription()),
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
