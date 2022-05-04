import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import 'dart:async';
import 'dart:io';

import '../model/model.dart';

class DbHelper {
  // Tables
  static const String tblDocs = "docs";

  // Fields of the 'docs' table
  static const String docId = "id";
  static const String docTitle = "title";
  static const String docExpiration = "expiration";

  static const String fqYear = "fqYear";
  static const String fqHalfYear = "fqHalfYear";
  static const String fqQuarter = "fqQuarter";
  static const String fqMonth = "fqMonth";

  // Singleton
  static final DbHelper _dbHelper = DbHelper._internal();

  DbHelper._internal();

  factory DbHelper() {
    return _dbHelper;
  }

  // Database entry point
  static Database? _db;

  Future<Database> get db async {
    _db ??= await initializeDb();
    return _db!;
  }

  // Initialize the database
  Future<Database> initializeDb() async {
    Directory d = await getApplicationDocumentsDirectory();
    String p = d.path + '/docexpire.db';
    var db = await openDatabase(p, version: 1, onCreate: _createDb);
    return db;
  }

  // Create database tables
  void _createDb(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $tblDocs($docId INTEGER PRIMARY KEY, $docTitle TEXT, "
        "$docExpiration TEXT, "
        "$fqYear INTEGER, $fqHalfYear INTEGER, $fqQuarter INTEGER, "
        "$fqMonth INTEGER)");
  }

  // Insert a new doc
  Future<int> insertDoc(Doc doc) async {
    int r = 0;

    Database db = await this.db;
    try {
      r = await db.insert(tblDocs, doc.toMap());
    } catch (e) {
      debugPrint("insertDoc: " + e.toString());
    }
    return r;
  }

  // Get the list of docs
  Future<List> getDocs() async {
    Database db = await this.db;
    var r =
        await db.rawQuery("SELECT * FROM $tblDocs ORDER BY $docExpiration ASC");
    return r;
  }

  // Gets a Doc based on the id
  Future<List> getDoc(int id) async {
    Database db = await this.db;
    var r = await db.rawQuery(
        "SELECT * FROM $tblDocs WHERE $docId = " + id.toString() + "");
    return r;
  }

  // Gets a Doc based on a String payload
  Future<List> getDocFromStr(String payload) async {
    List<String> p = payload.split("|");
    if (p.length == 2) {
      Database db = await this.db;
      var r = await db.rawQuery("SELECT * FROM $tblDocs WHERE $docId = " +
          p[0] +
          " AND $docExpiration = '" +
          p[1] +
          "'");
      return r;
    } else {
      return [];
    }
  }

  // Get the number of docs
  Future<int> getDocsCount() async {
    Database db = await this.db;
    var r = Sqflite.firstIntValue(
        await db.rawQuery("SELECT COUNT(*) FROM $tblDocs"));
    return r ?? 0;
  }

  // Get the max document id available on the database
  Future<int> getMaxId() async {
    Database db = await this.db;
    var r = Sqflite.firstIntValue(
        await db.rawQuery("SELECT MAX(id) FROM $tblDocs"));
    return r ?? 0;
  }

  /// Update a doc \
  /// seconda riga
  ///
  Future<int> updateDoc(Doc doc) async {
    var db = await this.db;
    var r = await db
        .update(tblDocs, doc.toMap(), where: "$docId = ?", whereArgs: [doc.id]);
    return r;
  }

  // Delete a doc
  Future<int> deleteDoc(int id) async {
    var db = await this.db;
    int r = await db.rawDelete("DELETE FROM $tblDocs WHERE $docId = $id");
    return r;
  }

  // Delete all rows
  Future<int> deleteRows(String tbl) async {
    var db = await this.db;
    int r = await db.rawDelete("DELETE FROM $tbl");
    return r;
  }
}
