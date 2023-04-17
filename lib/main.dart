import 'package:flutter/material.dart';
import 'package:persistence_app/Model/contact.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<Database> createDatabase() async {
    var database = await openDatabase(
      join(await getDatabasesPath(), 'contacts_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE contact (id INTEGER PRIMARY KEY, name VARCHAR, age INTEGER)',
        );
      },
      version: 1,
    );

    // ignore: avoid_print
    print("Banco is open:${database.isOpen}");

    return database;
  }

  @override
  void initState() {
    super.initState();
    createDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const Center(),
    );
  }
}
