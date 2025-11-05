import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Military Reports App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/sitrep': (context) => const SitrepForm(),
        '/locstat': (context) => const LocstatForm(),
        '/casevec': (context) => const CasevecForm(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Military Reports'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/sitrep'),
              child: const Text('Create SITREP'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/locstat'),
              child: const Text('Create LOCSTAT'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/casevec'),
              child: const Text('Create CASEVEC'),
            ),
          ],
        ),
      ),
    );
  }
}

class SitrepForm extends StatefulWidget {
  const SitrepForm({super.key});

  @override
  State<SitrepForm> createState() => _SitrepFormState();
}

class _SitrepFormState extends State<SitrepForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _summaryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SITREP Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _dateController,
                decoration: const InputDecoration(labelText: 'Date'),
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _timeController,
                decoration: const InputDecoration(labelText: 'Time'),
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(labelText: 'Location'),
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _summaryController,
                decoration: const InputDecoration(labelText: 'Situation Summary'),
                maxLines: 5,
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              ElevatedButton(
                onPressed: _saveAndShare,
                child: const Text('Save and Share'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveAndShare() async {
    if (_formKey.currentState!.validate()) {
      String content = 'SITREP\nDate: ${_dateController.text}\nTime: ${_timeController.text}\nLocation: ${_locationController.text}\nSummary: ${_summaryController.text}';
      await _saveToFile('sitrep.txt', content);
      await _shareFile('sitrep.txt');
    }
  }

  Future<void> _saveToFile(String filename, String content) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$filename');
    await file.writeAsString(content);
  }

  Future<void> _shareFile(String filename) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$filename');
    await Share.shareXFiles([XFile(file.path)], text: 'Military Report');
  }
}

class LocstatForm extends StatefulWidget {
  const LocstatForm({super.key});

  @override
  State<LocstatForm> createState() => _LocstatFormState();
}

class _LocstatFormState extends State<LocstatForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _unitController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LOCSTAT Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _unitController,
                decoration: const InputDecoration(labelText: 'Unit'),
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(labelText: 'Location'),
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _statusController,
                decoration: const InputDecoration(labelText: 'Status'),
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              ElevatedButton(
                onPressed: _saveAndShare,
                child: const Text('Save and Share'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveAndShare() async {
    if (_formKey.currentState!.validate()) {
      String content = 'LOCSTAT\nUnit: ${_unitController.text}\nLocation: ${_locationController.text}\nStatus: ${_statusController.text}';
      await _saveToFile('locstat.txt', content);
      await _shareFile('locstat.txt');
    }
  }

  Future<void> _saveToFile(String filename, String content) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$filename');
    await file.writeAsString(content);
  }

  Future<void> _shareFile(String filename) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$filename');
    await Share.shareXFiles([XFile(file.path)], text: 'Military Report');
  }
}

class CasevecForm extends StatefulWidget {
  const CasevecForm({super.key});

  @override
  State<CasevecForm> createState() => _CasevecFormState();
}

class _CasevecFormState extends State<CasevecForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _patientController = TextEditingController();
  final TextEditingController _injuryController = TextEditingController();
  final TextEditingController _evacuationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CASEVEC Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _patientController,
                decoration: const InputDecoration(labelText: 'Patient Name'),
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _injuryController,
                decoration: const InputDecoration(labelText: 'Injury'),
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                controller: _evacuationController,
                decoration: const InputDecoration(labelText: 'Evacuation Status'),
                validator: (value) => value!.isEmpty ? 'Required' : null,
              ),
              ElevatedButton(
                onPressed: _saveAndShare,
                child: const Text('Save and Share'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveAndShare() async {
    if (_formKey.currentState!.validate()) {
      String content = 'CASEVEC\nPatient: ${_patientController.text}\nInjury: ${_injuryController.text}\nEvacuation: ${_evacuationController.text}';
      await _saveToFile('casevec.txt', content);
      await _shareFile('casevec.txt');
    }
  }

  Future<void> _saveToFile(String filename, String content) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$filename');
    await file.writeAsString(content);
  }

  Future<void> _shareFile(String filename) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$filename');
    await Share.shareXFiles([XFile(file.path)], text: 'Military Report');
  }
}
