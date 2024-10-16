import 'package:expense_tracker/view/model/expenses_model.dart';
import 'package:expense_tracker/view/widget/expenses_list_builer_widget.dart';
import 'package:expense_tracker/view/widget/new_expenses_manage_widget.dart';
import 'package:flutter/material.dart';

class ExpensesPage extends StatefulWidget {
  const ExpensesPage({super.key});
  @override
  State<ExpensesPage> createState() {
    return _ExpensesPageState();
  }
}

class _ExpensesPageState extends State<ExpensesPage> {
  final List<ExpensesModel> _registeredExpenses = [
    ExpensesModel(
        amount: 80,
        title: 'Badam Shake',
        date: DateTime.now(),
        category: Category.food),
    ExpensesModel(
        amount: 190,
        title: 'Hair Gel',
        date: DateTime.now(),
        category: Category.groceries),
  ];

  void _addExpenseOption() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (cnxt) => NewExpensesWidget(
        onAddExpense: _addExpense,
      ),
    );
  }

  void _addExpense(ExpensesModel exoense) {
    setState(() {
      _registeredExpenses.add(exoense);
    });
  }

  void _removeExpense(ExpensesModel expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3),
        content: Text('Expense Deleted!'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = Center(
      child: Text(
        'No expenses found. Start adding some',
        style: TextStyle(fontSize: 20),
      ),
    );
    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesListBuilderWidget(
        expenses: _registeredExpenses,
        onTapRemoveExpense: _removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Expense Tracker',
          style: TextStyle(fontSize: 20),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: _addExpenseOption,
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          // TODO Chart to be added soon
          // const Text('The Chart'),
          Expanded(
            child: mainContent,
          )
        ],
      ),
    );
  }
}
