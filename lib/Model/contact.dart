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

  static Future<List<Map<String, dynamic>>> getContacts() async {
    var db = await getDatabase();
    return db.query('contacts', orderBy: 'id');
  }

  static Future<Map<String, dynamic>> getItem(int id) async {
    var db = await getDatabase();
    return db.query('contacts', where: 'id = ?', whereArgs: [id], limit: 1);
  }
  
  Future<int> insert() async {
    var db = await getDatabase();

    final Map<String, dynamic> contactMap = Map();
    contactMap['name'] = name;
    contactMap['age'] = age;

    return db.insert('contacts', contactMap);
  }

  Future<int> updateItem() async {
    var db = await getDatabase();

    final data = {
      'name' : this.name,
      'age' : this.age
    }

    try{
      return await db.update('contacts', data, where: 'id = ?', whereArgs: [this.id]);    
    } catch (err) {
      debugPrint(err);
    }

  }

  Future<void> deleteItem(int id) async {
    var db = await getDatabase();

    try{
      await db.delete('contacts', where: 'id = ?', whereArgs: [id]);
    } catch (err) {
      debugPrint(err);
    }
  }
}
