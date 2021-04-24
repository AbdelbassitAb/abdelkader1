import 'package:abdelkader1/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DataBaseController extends GetxController {
  static DataBaseController to = Get.find();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  final String uid;

  DataBaseController({this.uid});

  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('Users');
  final CollectionReference transactionsCollection =
      FirebaseFirestore.instance.collection('Transactions');
  final CollectionReference workersCollection =
      FirebaseFirestore.instance.collection('Workers');
  final CollectionReference achatMateriauxCollection =
      FirebaseFirestore.instance.collection('Achat Materiaux');
  final CollectionReference gazCollection =
      FirebaseFirestore.instance.collection('Gaz');
  final CollectionReference nouritureCollection =
      FirebaseFirestore.instance.collection('Nouriture');
  final CollectionReference payementCollection =
      FirebaseFirestore.instance.collection('Payement');
  final CollectionReference chantiersCollection =
      FirebaseFirestore.instance.collection('Chantier');

  CollectionReference get collection {
    return usersCollection;
  }

  Future<void> updateUserData(String uid, String name, String email,
      String numTlf, double argent, bool deleted) async {
    return await usersCollection.doc(uid).set({
      'uid': uid,
      'name': name,
      'email': email,
      'numTlf': numTlf,
      'argent': argent,
      'deleted': deleted,
    });
  }

  Future<void> updateWorkerData(
    String uid,
    String name,
  ) async {
    return await workersCollection.doc(uid).set({
      'uid': uid,
      'name': name,
    });
  }

  Future<void> updateUserTransaction(
      String uid,
      String name,
      String description,
      String time,
      double argent,
      double somme,
      Workerr worker,
      bool deleted,
      String type,
      String chantier) async {
    await transactionsCollection.doc('All transactions').collection('Transactions').doc(uid).set({
      'uid': uid,
      'name': name,
      'description': description,
      'time': time,
      'argent': argent,
      'somme': somme,
      'type': type,
      'chantier': chantier,
      'workerName': worker.name,
      'workerId': worker.uid,
      'deleted': deleted,
    });

    await chantiersCollection
        .doc(chantier)
        .collection('Transactions')
        .doc(uid)
        .set({
      'uid': uid,
      'name': name,
      'description': description,
      'time': time,
      'argent': argent,
      'somme': somme,
      'type': type,
      'chantier': chantier,
      'workerName': worker.name,
      'workerId': worker.uid,
      'deleted': deleted,
    });

    await transactionsCollection
        .doc(type)
        .collection('Transactions')
        .doc(uid)
        .set({
      'uid': uid,
      'name': name,
      'description': description,
      'time': time,
      'argent': argent,
      'somme': somme,
      'type': type,
      'chantier': chantier,
      'workerName': worker.name,
      'workerId': worker.uid,
      'deleted': deleted,
    });

    if (worker.uid != null) {
      await workersCollection
          .doc(worker.uid)
          .collection('Transactions')
          .doc(uid)
          .set({
        'uid': uid,
        'name': name,
        'description': description,
        'time': time,
        'argent': argent,
        'somme': somme,
        'type': type,
        'chantier': chantier,
        'workerName': worker.name,
        'workerId': worker.uid,
        'deleted': deleted,
      });
    }

    return await usersCollection
        .doc(this.uid)
        .collection('Transactions')
        .doc(uid)
        .set({
      'uid': uid,
      'name': name,
      'description': description,
      'time': time,
      'argent': argent,
      'somme': somme,
      'type': type,
      'chantier': chantier,
      'workerName': worker.name,
      'workerId': worker.uid,
      'deleted': deleted,
    });
  }

  /* Future<void> addTransaction(String uid, String name,String description,String time,
      double argent,double somme,bool deleted) async {
    return await usersCollection.doc(uid).collection('Transactions').add({
      'uid': uid,
      'name': name,
      'description' : description,
      'time' : time,
      'argent': argent,
      'somme' : somme,
      'deleted': deleted,
    });
  }*/

  List<ChefData> _chefListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return ChefData.fromMap(doc.data());
    }).toList();
  }

  List<Workerr> _workerListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Workerr.fromMap(doc.data());
    }).toList();
  }



  List<TR> _transactionsListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return TR.fromMap(doc.data());
    }).toList();
  }

  //get brews stream
  Stream<List<ChefData>> get chefs {
    return usersCollection.snapshots().map(_chefListFromSnapshot);
  }

  Stream<List<Workerr>> get workers {
    return workersCollection.snapshots().map(_workerListFromSnapshot);
  }

  Stream<List<TR>> get allTransactions {
    return transactionsCollection
        .snapshots()
        .map(_transactionsListFromSnapshot);
  }

  Stream<List<TR>> get transactions {
    return usersCollection
        .doc(uid)
        .collection('Transactions')
        .snapshots()
        .map(_transactionsListFromSnapshot);
  }

  Stream<List<TR>> get workerTransactions {
    return workersCollection
        .doc(uid)
        .collection('Transactions')
        .snapshots()
        .map(_transactionsListFromSnapshot);
  }

  Future<void> deleteChef(String id) {
    return usersCollection.doc(id).delete();
  }

  Future<void> deleteTransaction(String id) {
    transactionsCollection.doc(id).delete();
    return usersCollection
        .doc(this.uid)
        .collection('Transactions')
        .doc(id)
        .delete();
  }

  Future<void> deleteWorkersTransaction(String id) {
    return workersCollection
        .doc(this.uid)
        .collection('Transactions')
        .doc(id)
        .delete();
  }
}
