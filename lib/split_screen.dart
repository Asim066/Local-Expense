import 'package:flutter/material.dart';
import 'expense.dart'; // Assuming this contains your Expense model

class SplitScreen extends StatefulWidget {
  final Expense expense;

  const SplitScreen({super.key, required this.expense});

  @override
  State<SplitScreen> createState() => _SplitScreenState();
}

class _SplitScreenState extends State<SplitScreen> {
  double totalAmount = 0;
  double customPercentage = 50;
  bool isCustom = false;

  @override
  void initState() {
    super.initState();
    // Automatically set the totalAmount from the passed expense
    totalAmount = widget.expense.amount;
  }

  @override
  Widget build(BuildContext context) {
    double userAShare = isCustom
        ? (customPercentage / 100) * totalAmount
        : totalAmount / 2;
    double userBShare = totalAmount - userAShare;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Split Expense'),
        backgroundColor: Colors.orangeAccent,
        elevation: 6,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orangeAccent, Colors.orange],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Splitting: ${widget.expense.title}',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextField(
                        decoration: const InputDecoration(
                          labelText: 'Total Amount',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        controller: TextEditingController(
                          text: totalAmount.toString(),
                        ),
                        onChanged: (val) => setState(() {
                          totalAmount = double.tryParse(val) ?? 0;
                        }),
                      ),
                      const SizedBox(height: 16),
                      SwitchListTile(
                        value: isCustom,
                        title: const Text(
                          'Custom Split',
                          style: TextStyle(fontSize: 16),
                        ),
                        onChanged: (val) => setState(() => isCustom = val),
                      ),
                      if (isCustom)
                        Column(
                          children: [
                            const SizedBox(height: 12),
                            Slider(
                              value: customPercentage,
                              min: 0,
                              max: 100,
                              divisions: 20,
                              label: 'User A: ${customPercentage.toInt()}%',
                              onChanged: (val) => setState(() => customPercentage = val),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'User A gets ${customPercentage.toInt()}% • User B gets ${(100 - customPercentage).toInt()}%',
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'User A pays: PKR ${userAShare.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'User B pays: PKR ${userBShare.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
