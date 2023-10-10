class Message {
  int _id;
  String _titre;
  DateTime _dateEnvoie;
  String _contenu;

  Message(this._id, this._titre, this._dateEnvoie, this._contenu);

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
}
