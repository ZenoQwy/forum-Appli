import 'package:forum/class/message.dart';
import 'package:forum/class/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Message>> initMessageList(List<Message> liste) async {
  String baseUrl = 's3-4676.nuage-peda.fr';
  Map<String, String> header = {
    "Content-type": "application/json; charset=UTF-8",
    "Accept": 'application/json',
  };
  final _uri =
      Uri.http(baseUrl, '/forum/api/messages', {'page': '1', 'exists[parent]': 'false', 'order[datePoste]': 'desc'});

  final response = await http.get(_uri, headers: header);

  if (response.statusCode == 200) {
    List responseBody = jsonDecode(response.body);
    for (int i = 0; i < responseBody.length; i++) {
      // Appel du constructeur
      Message mess = Message(
          responseBody[i]['id'],
          responseBody[i]['titre'],
          DateTime.parse(responseBody[i]['datePoste']),
          responseBody[i]['contenu'],
          responseBody[i]['user']['nom'],
          responseBody[i]['user']['prenom'],
      );
      liste.add(mess);
    }
    print("Chargement des messages terminé !");
  } else {
    // Recupérer l'erreur de chargement et l'afficher
    print("Error: ${response.statusCode} - ${response.reasonPhrase}");
  }

  return liste;
}





Future<List<User>> initUserList(List<User> liste) async {
  String baseUrl = 's3-4676.nuage-peda.fr';
  Map<String, String> header = {
    "Content-type": "application/json; charset=UTF-8",
    "Accept": 'application/json',
  };
  final _uri = Uri.http(baseUrl, '/forum/api/users', {'page': '1', 'order[nom]': 'asc', 'order[prenom]': 'asc'});

  final response = await http.get(_uri, headers: header);

  if (response.statusCode == 200) {
    List responseBody = jsonDecode(response.body);
    for (int i = 0; i < responseBody.length; i++) {
      // Appel du constructeur
      User users = User(responseBody[i]['id'], responseBody[i]['nom'], responseBody[i]['prenom'],
          DateTime.parse(responseBody[i]['dateInscription']));
      liste.add(users);
    }
    print("Chargement des utilisateurs terminé !");
  } else {
    // Recupérer l'erreur de chargement et l'afficher
    print("Error: ${response.statusCode} - ${response.reasonPhrase}");
  }

  return liste;
}







Future<List<Message>> initDiscussion(List<Message> liste, Message message) async {
  String baseUrl = 's3-4676.nuage-peda.fr';
  Map<String, String> header = {
    "Content-type": "application/json; charset=UTF-8",
    "Accept": 'application/json',
  };
  final _uri = Uri.http(baseUrl, '/forum/api/messages', {'page': '1', 'id': '${message.getId()}'});

  final response = await http.get(_uri, headers: header);

  if (response.statusCode == 200) {
    List<dynamic> responseBody = jsonDecode(response.body);
    if (responseBody.isNotEmpty && responseBody[0]['messages'] is List) {
      List messages = responseBody[0]['messages'];
      for (int i = 0; i < messages.length; i++) {
        if (messages[i] is Map && messages[i].containsKey('id')) {
          Message mess = Message(
            messages[i]['id'],
            messages[i]['titre'],
            DateTime.parse(messages[i]['datePoste']),
            messages[i]['contenu'],
            messages[i]['user']['nom'],
            messages[i]['user']['prenom'],
          );
          liste.add(mess);
        }
      }
      print("Chargement de la discussion terminé !");
    } else {
      print("No 'messages' key in the response or 'messages' is not a list.");
    }
  } else {
    print("Error: ${response.statusCode} - ${response.reasonPhrase}");
  }

  return liste;
}
