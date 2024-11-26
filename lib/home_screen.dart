import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/visitor_provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final visitorProvider = Provider.of<VisitorProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Gestión de Visitantes')),
      body: StreamBuilder(
        stream: visitorProvider.getVisitors(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final visitors = snapshot.data!;
          return ListView.builder(
            itemCount: visitors.length,
            itemBuilder: (context, index) {
              final visitor = visitors[index];
              return ListTile(
                title: Text(visitor.name),
                subtitle: Text(visitor.motivo),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => visitorProvider.deleteVisitor(visitor.id),
                ),
                onTap: () {
                  // Navegar a la pantalla de edición
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => context.push('/add'),
      ),
    );
  }
}
