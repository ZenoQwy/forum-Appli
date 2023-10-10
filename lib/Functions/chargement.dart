import 'package:forum/class/message.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

List<Message> initList(List<Message> liste) {
  liste.add(Message(1, "titre1", DateTime(1989, 11, 9), "Bonjour1"));
  liste.add(Message(2, "titre2", DateTime(2009, 1, 6), "Bonjour2"));
  liste.add(Message(3, "titre3", DateTime(1919, 5, 4), "Bonjour3"));
  return liste;
}

Future<List<Message>> initList2(List<Message> liste) async {
  String baseUrl = 's3-4676.nuage-peda.fr';
  Map<String, String> header = {
    "Content-type": "application/json; charset=UTF-8",
    "Accept": 'application/json',
  };
  final _uri = Uri.http(baseUrl, '/forum/api/messages');

  final response = await http.get(_uri, headers: header);

  if (response.statusCode == 200) {
    List responseBody = jsonDecode(response.body);
    for (int i = 0; i < responseBody.length; i++) {
      Message mess = Message(responseBody[i]['id'], responseBody[i]['titre'],
          DateTime.parse(responseBody[i]['datePoste']), responseBody[i]['contenu']);
      liste.add(mess);
    }
    print("Chargement terminé !");
  } else {
    // Recupérer l'erreur de chargement et l'afficher
    print("Error: ${response.statusCode} - ${response.reasonPhrase}");
  }

  return liste;
}
