import 'package:flutter/material.dart';
import 'package:flutter_firebase/services/firebase_service.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('App Crude FireBase')),
      body: FutureBuilder(
        future: getUsuarios(),
        builder: ((context, snapshot) {
          if (snapshot.hasData == false) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data?[index]['nombre']),
                  subtitle: Text(snapshot.data?[index]['email']),
                  leading: CircleAvatar(
                    child: Text(
                      snapshot.data?[index]['nombre'].substring(0, 1),
                    ),
                  ),
                  onTap: () async {
                    await Navigator.pushNamed(context, '/edit', arguments: {
                      'uid': snapshot.data?[index]['uid'],
                      'nombre': snapshot.data?[index]['nombre'],
                      'email': snapshot.data?[index]['email'],
                      'nocuenta': snapshot.data?[index]['nocuenta'],
                    });
                    setState(() {});
                  },
                );
              },
            );
          }
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
