import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'Functions/chargement.dart';
import 'class/message.dart';
import 'affichageUsers.dart';
import 'dart:async';
import 'dart:ui';

import 'package:intl/intl.dart';
// dans le pubsec : intl: ^0.18.1

import 'package:basic_utils/basic_utils.dart';
// dans le pubsec : basic_utils: ^5.6.1

class DiscussionHomePage extends StatefulWidget {
  const DiscussionHomePage(
      {super.key, required this.title, required this.message});
  final String title;
  final Message message;
  @override
  State<DiscussionHomePage> createState() => _DiscussionHomePageState();
}

class _DiscussionHomePageState extends State<DiscussionHomePage> {
  List<Message> liste = [];

  @override
  void initState() {
    super.initState();
    //liste = initList(liste);
    chargement();
  }

  void chargement() async {
    liste = await initDiscussion(liste,widget.message);
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
                        title:
                            'Forum | Liste des utilisateurs'), // Nouvelle page de splashscreen pour le morpion
                  ),
                );
              },
            ),
          ],
        ),
      ),
        body: ListView.builder(
          itemCount: liste.length, // +1 pour le message principal
          itemBuilder: (context, index) {
            if (index == 0) {
              // Afficher le message principal
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 10, left: 5, bottom: 10),
                    child: Text(StringUtils.capitalize(widget.message.getTitre())),
                  ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 5, left: 5, bottom: 5),
                        child: Icon(Icons.person),
                      ),
                      Text(
                        "${widget.message.getNomAuteur()} ${widget.message.getPrenomAuteur()} | ",
                        style: TextStyle(fontSize: 10),
                      ),
                      Text(
                        DateFormat('HH:mm dd-MM-yyyy')
                            .format(widget.message.getDateEnvoie()),
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                ],
              );
            } else {
              return  Card(
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
            ]));
            }
          },
        )
    );
  }
}
