import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();

const uuid = Uuid();

class ExpensesModel {
  ExpensesModel({
    required this.amount,
    required this.title,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return formatter.format(date);
  }
}

enum Category { food, travel, communication, groceries }

const categoryIcons = {
  Category.food: Icons.fastfood,
  Category.communication: Icons.phone_iphone_sharp,
  Category.groceries: Icons.local_grocery_store_sharp,
  Category.travel: Icons.airplane_ticket,
};
