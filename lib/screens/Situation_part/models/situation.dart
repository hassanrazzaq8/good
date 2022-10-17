class Situation {
  final String title;
  final String gameMode;
  final String noOfPlayers;
  final String sb;
  final String bb;
  final String position;
  final String stack;
  final List sValue;
  final List flopValue;
  final List turnValue;
  final List riverValue;
  final List prejoueur;
  final List preaction;
  final List premontant;
  final List fjoueur;
  final List faction;
  final List fmontant;
  final List tjoueur;
  final List taction;
  final List tmontant;
  final List rjoueur;
  final List raction;
  final List rmontant;
  final String pot1;
  final String pot2;
  final String pot3;
  final List comm;
  final List like;
  final String note;
  final String uid;
  final String postId;

  Situation(
    this.noOfPlayers,
    this.sb,
    this.bb,
    this.position,
    this.stack,
    this.prejoueur,
    this.preaction,
    this.premontant,
    this.pot1,
    this.pot2,
    this.pot3,
    this.sValue,
    this.flopValue,
    this.turnValue,
    this.riverValue,
    this.comm,
    this.like,
    this.note,
    this.fjoueur,
    this.faction,
    this.fmontant,
    this.tjoueur,
    this.taction,
    this.tmontant,
    this.rjoueur,
    this.raction,
    this.rmontant, {
    required this.postId,
    required this.title,
    required this.gameMode,
    required this.uid,
  });

  Map<String, dynamic> tojson() => {
        "uid": uid,
        "postId": postId,
        "title": title,
        "gameMode": gameMode,
        "noOfPlayers": noOfPlayers,
        "sb": sb,
        "bb": bb,
        "position": position,
        "stack": stack,
        "flopPot": pot1,
        "turnPot": pot1,
        "riverPot": pot1,
        "SimpleCardValue": sValue,
        "FlopCardValue": flopValue,
        "TurnCardValue": turnValue,
        "RiverCardValue": riverValue,
        "comment": comm,
        "SituationLikes": like,
        "Note": note,
        'prejoueur': prejoueur,
        'preaction': preaction,
        'premontant': premontant,
        'flopjoueur': fjoueur,
        'flopaction': faction,
        'flopmontant': fmontant,
        'turnjoueur': tjoueur,
        'turnaction': taction,
        'turnmontant': tmontant,
        'riverjoueur': rjoueur,
        'riveraction': raction,
        'rivermontant': rmontant,
        "time": DateTime.now(),
      };
}
