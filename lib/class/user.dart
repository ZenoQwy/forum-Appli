class User {
  int _id;
  String _nom;
  String _prenom;
  DateTime _dateInscription;

  User(this._id, this._nom, this._prenom, this._dateInscription);

  int getId() {
    return this._id;
  }

  String getNom() {
    return this._nom;
  }

  String getPrenom() {
    return this._prenom;
  }

  DateTime getDateInscription() {
    return this._dateInscription;
  }
}
