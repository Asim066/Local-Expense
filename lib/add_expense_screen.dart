import 'package:flutter/material.dart';
import 'package:intl/intl.dart';  // Import the intl package
import 'expense.dart';  // Import the Expense model

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  String _category = 'Food';
  DateTime _selectedDate = DateTime.now();
  bool _isShared = false;

  void _saveExpense() {
    if (_formKey.currentState!.validate()) {
      final newExpense = Expense(
        title: _titleController.text,
        category: _category,
        amount: double.parse(_amountController.text),
        date: _selectedDate,
        isShared: _isShared,
      );

      // Show SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Expense added successfully!'),
          duration: Duration(seconds: 2),
        ),
      );

      // Delay popping the screen to allow the SnackBar to show
      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.pop(context, newExpense);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Expense')),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.lightBlueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              AnimatedOpacity(
                opacity: 1.0,
                duration: const Duration(milliseconds: 500),
                child: _buildTextField(
                  controller: _titleController,
                  labelText: 'Expense Title',
                  validator: (value) => value == null || value.isEmpty ? 'Enter a title' : null,
                ),
              ),
              const SizedBox(height: 12),
              AnimatedOpacity(
                opacity: 1.0,
                duration: const Duration(milliseconds: 500),
                child: _buildDropdown(),
              ),
              const SizedBox(height: 12),
              AnimatedOpacity(
                opacity: 1.0,
                duration: const Duration(milliseconds: 500),
                child: _buildTextField(
                  controller: _amountController,
                  labelText: 'Amount Spent',
                  keyboardType: TextInputType.number,
                  validator: (value) => value == null || value.isEmpty ? 'Enter amount' : null,
                ),
              ),
              const SizedBox(height: 12),
              AnimatedOpacity(
                opacity: 1.0,
                duration: const Duration(milliseconds: 500),
                child: _buildDatePicker(),
              ),
              const SizedBox(height: 12),
              AnimatedOpacity(
                opacity: 1.0,
                duration: const Duration(milliseconds: 500),
                child: _buildCheckbox(),
              ),
              const SizedBox(height: 20),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut,
                child: ElevatedButton(
                  onPressed: _saveExpense,
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    //primary: Colors.deepOrange,
                    elevation: 8,
                  ),
                  child: const Text('Save Expense', style: TextStyle(fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.white),
        filled: true,
        fillColor: Colors.white.withOpacity(0.7),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.deepOrange, width: 2),
        ),
      ),
      keyboardType: keyboardType,
      validator: validator,
    );
  }

  Widget _buildDropdown() {
    return DropdownButtonFormField<String>(
      value: _category,
      decoration: const InputDecoration(labelText: 'Category', labelStyle: TextStyle(color: Colors.white)),
      items: ['Food', 'Transport', 'Bills', 'Shopping']
          .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
          .toList(),
      onChanged: (val) => setState(() => _category = val!),
    );
  }

  Widget _buildDatePicker() {
    return Row(
      children: [
        Expanded(
          child: Text(DateFormat.yMMMd().format(_selectedDate), style: const TextStyle(color: Colors.white, fontSize: 16)),
        ),
        IconButton(
          onPressed: () {
            _pickDate();
          },
          icon: const Icon(Icons.calendar_today, color: Colors.white),
        ),
      ],
    );
  }

  Widget _buildCheckbox() {
    return CheckboxListTile(
      value: _isShared,
      title: const Text('Share this expense', style: TextStyle(color: Colors.white)),
      onChanged: (val) => setState(() => _isShared = val!),
      activeColor: Colors.deepOrange,
      checkColor: Colors.white,
    );
  }

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }
}
