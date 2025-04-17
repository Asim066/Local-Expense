import 'package:flutter/material.dart';
import 'expense.dart';
import 'add_expense_screen.dart';
import 'expense_list_screen.dart';
import 'split_screen.dart';

class HomeScreen extends StatefulWidget {
  final String username;

  const HomeScreen({super.key, required this.username});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  List<Expense> expenses = [];

  late final AnimationController _fadeController = AnimationController(
    duration: const Duration(milliseconds: 1000),
    vsync: this,
  )..forward();

  void _navigateToAddExpense() async {
    final newExpense = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddExpenseScreen()),
    );

    if (newExpense != null) {
      setState(() {
        expenses.add(newExpense);
      });
    }
  }

  void _navigateToExpenseList() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ExpenseListScreen(expenses: expenses)),
    );
  }

  void _navigateToExpenseSplit(Expense expense) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SplitScreen(expense: expense)),
    );
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Animation<double> fadeAnimation =
    CurvedAnimation(parent: _fadeController, curve: Curves.easeIn);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.lightBlueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 60.0),
        child: FadeTransition(
          opacity: fadeAnimation,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                elevation: 8,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const Icon(Icons.person_pin_circle, size: 70, color: Colors.blueAccent),
                      const SizedBox(height: 10),
                      Text(
                        'Welcome, ${widget.username}!',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Track and manage your expenses easily.',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              _buildAnimatedButton(
                icon: Icons.add_circle_outline,
                label: 'Add Expense',
                color: Colors.white,
                backgroundColor: Colors.indigo,
                onTap: _navigateToAddExpense,
              ),
              const SizedBox(height: 20),
              _buildAnimatedButton(
                icon: Icons.list_alt_outlined,
                label: 'View Expense List',
                color: Colors.white,
                backgroundColor: Colors.green,
                onTap: _navigateToExpenseList,
              ),
              const SizedBox(height: 20),
              _buildAnimatedButton(
                icon: Icons.call_split,
                label: 'Split Expense',
                color: Colors.white,
                backgroundColor: expenses.isNotEmpty ? Colors.deepOrange : Colors.grey,
                onTap: expenses.isNotEmpty ? () => _navigateToExpenseSplit(expenses[0]) : null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedButton({
    required IconData icon,
    required String label,
    required Color color,
    required Color backgroundColor,
    required VoidCallback? onTap,
  }) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 600),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.easeOutBack,
      builder: (context, scale, child) {
        return Transform.scale(
          scale: scale,
          child: ElevatedButton.icon(
            icon: Icon(icon, size: 26),
            label: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14.0),
              child: Text(label, style: const TextStyle(fontSize: 16)),
            ),
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              backgroundColor: backgroundColor,
              foregroundColor: color,
              minimumSize: const Size.fromHeight(55),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              elevation: 6,
              shadowColor: Colors.black38,
            ),
          ),
        );
      },
    );
  }
}
