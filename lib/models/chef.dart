class Chef {
  final String uid;
  Chef({this.uid});

  factory Chef.fromMap(Map data) {
    return Chef(
      uid: data['uid'],
    );
  }


}

