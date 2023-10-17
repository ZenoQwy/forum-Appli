import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Functions/chargement.dart';
import 'affichageDiscussion.dart';
import 'class/message.dart';
import 'affichageUsers.dart';
import 'dart:async';
import 'dart:ui';

import 'package:intl/intl.dart';
// dans le pubsec : intl: ^0.18.1

import 'package:basic_utils/basic_utils.dart';
// dans le pubsec : basic_utils: ^5.6.1

class ListeMessageHomePage extends StatefulWidget {
  const ListeMessageHomePage({super.key, required this.title});
  final String title;
  @override
  State<ListeMessageHomePage> createState() => _ListeMessageHomePageState();
}

class _ListeMessageHomePageState extends State<ListeMessageHomePage> {
  List<Message> liste = [];
  @override
  void initState() {
    super.initState();
    //liste = initList(liste);
    chargement();
  }

  void chargement() async {
    liste = await initMessageList(liste);
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
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.deepPurple),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Menu',
                  ),
                ],
              ),
            ),
            const IntrinsicWidth(
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.fromLTRB(0, 25, 0, 0)),
                  Text(
                    'Menu principal',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Divider(
                    color: Colors.black,
                    thickness: 2,
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 10)),
                ],
              ),
            ),
            ListTile(
              // Icône de maison
              title: Text('Liste des utilisateurs'),
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => ListeUserHomePage(
                        title: 'Forum | Liste des utilisateurs'), // Nouvelle page de splashscreen pour le morpion
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: ListView.builder(
          itemCount: liste.length,
          itemBuilder: ((context, index) {
            return InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => DiscussionHomePage(message: liste[index],
                          title: 'Forum | Discussion de ${liste[index].getNomAuteur()} ${liste[index].getPrenomAuteur()}'), // Nouvelle page de splashscreen pour le morpion
                    ),
                  );
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
                          "${liste[index].getNomAuteur()} ${liste[index].getPrenomAuteur()} | ",
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
