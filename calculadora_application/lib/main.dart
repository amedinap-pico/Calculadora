import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController billController = TextEditingController(
    text: '120',
  );
  final TextEditingController peopleController = TextEditingController(
    text: '4',
  );
  double tipPercent = 20;
  bool roundUp = false;

  @override
  void dispose() {
    billController.dispose();
    peopleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bill = double.tryParse(billController.text) ?? 0.0;
    final people = int.tryParse(peopleController.text) ?? 1;
    final safePeople = people > 0 ? people : 1;
    final tipAmount = bill * tipPercent / 100;
    final total = bill + tipAmount;
    final split = total / safePeople;
    final perPerson = roundUp ? split.ceilToDouble() : split;

    return MaterialApp(
      title: 'Tip Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
      ),
      home: Scaffold(
        backgroundColor: const Color(0xFFFFF7ED),
        appBar: AppBar(
          title: const Text('Calculadora de propina'),
          centerTitle: true,
          backgroundColor: Colors.orange.shade700,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Cuenta total',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              ),
              const SizedBox(height: 8),
              TextField(
                key: const ValueKey('billInput'),
                controller: billController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                decoration: const InputDecoration(
                  prefixText: '\$ ',
                  hintText: '120.00',
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                'Porcentaje de propina',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              ),
              Slider(
                value: tipPercent,
                min: 0,
                max: 50,
                divisions: 50,
                label: '${tipPercent.round()}%',
                onChanged: (value) {
                  setState(() {
                    tipPercent = value;
                  });
                },
              ),
              Text(
                '${tipPercent.round()}%',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                'Personas',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
              ),
              const SizedBox(height: 8),
              TextField(
                key: const ValueKey('peopleInput'),
                controller: peopleController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(hintText: '4'),
              ),
              const SizedBox(height: 8),
              SwitchListTile(
                key: const ValueKey('roundSwitch'),
                contentPadding: EdgeInsets.zero,
                title: const Text('Redondear por persona'),
                value: roundUp,
                onChanged: (value) {
                  setState(() {
                    roundUp = value;
                  });
                },
              ),
              const SizedBox(height: 24),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    children: [
                      Text(
                        'Propina: \$${tipAmount.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Total: \$${total.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Por persona: \$${perPerson.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Colors.orange.shade800,
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
