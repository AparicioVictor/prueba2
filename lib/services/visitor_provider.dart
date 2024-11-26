import 'package:cloud_firestore/cloud_firestore.dart';

class Visitor {
  String id, name, motivo, identificacion;

  Visitor({required this.id, required this.name, required this.motivo, required this.identificacion});

  factory Visitor.fromMap(String id, Map<String, dynamic> map) {
    return Visitor(
      id: id,
      name: map['name'],
      motivo: map['motivo'],
      identificacion: map['identificacion'],
    );
  }
}

class VisitorProvider {
  final _collection = FirebaseFirestore.instance.collection('VISITANTE');

  Stream<List<Visitor>> getVisitors() {
    return _collection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Visitor.fromMap(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  Future<void> addVisitor(String name, String motivo, String identificacion) async {
    await _collection.add({'name': name, 'motivo': motivo, 'identificacion': identificacion});
  }

  Future<void> deleteVisitor(String id) async {
    await _collection.doc(id).delete();
  }
}
