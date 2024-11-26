import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/visitor_provider.dart';

class AddVisitorScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  String name = '', motivo = '', identificacion = '';

  @override
  Widget build(BuildContext context) {
    final visitorProvider = Provider.of<VisitorProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Agregar Visitante')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nombre'),
                onSaved: (value) => name = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Motivo'),
                onSaved: (value) => motivo = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Identificación'),
                onSaved: (value) => identificacion = value!,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('Guardar'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    visitorProvider.addVisitor(name, motivo, identificacion);
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
