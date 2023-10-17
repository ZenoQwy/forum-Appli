class Message {
  int _id;
  String _titre;
  DateTime _dateEnvoie;
  String _contenu;
  String _nomAuteur;
  String _prenomAuteur;

  Message(this._id, this._titre, this._dateEnvoie, this._contenu, this._nomAuteur, this._prenomAuteur);

  int getId() {
    return this._id;
  }

  String getTitre() {
    return this._titre;
  }

  DateTime getDateEnvoie() {
    return this._dateEnvoie;
  }

  String getContenu() {
    return this._contenu;
  }

  String getNomAuteur() {
    return this._nomAuteur;
  }

  String getPrenomAuteur() {
    return this._prenomAuteur;
  }

}
