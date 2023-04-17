import 'package:sqflite/sqflite.dart';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'dart:async';

class Contact {
  late int id;
  late String name;
  late int age;

  Contact({
    required this.name,
    required this.age,
  });

  static Future<Database> getDatabase() async {
    var database = await openDatabase(
      join(await getDatabasesPath(), 'contacts_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE contacts (id INTEGER PRIMARY KEY, name VARCHAR, age INTEGER)',
        );
      },
      version: 1,
    );
    return database;
  }

  Future<int> insert() async {
    var db = await getDatabase();

    final Map<String, dynamic> contactMap = Map();
    contactMap['name'] = name;
    contactMap['age'] = age;

    return db.insert('contacts', contactMap);
  }
}
