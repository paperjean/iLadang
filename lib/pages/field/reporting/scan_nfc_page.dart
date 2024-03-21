import 'package:flutter/material.dart';
import 'package:sawitcare_app/pages/field/reporting/report_form.dart';

class ScanNFC extends StatefulWidget {
  const ScanNFC({super.key});

  @override
  State<ScanNFC> createState() => _ScanNFCState();
}

class _ScanNFCState extends State<ScanNFC> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(children: [
              const SizedBox(
                height: 100,
              ),
              const Text(
                "Scan NFC",
                style: TextStyle(fontSize: 30),
              ),
              const SizedBox(
                height: 20,
              ),
              const Icon(
                Icons.nfc_outlined,
                size: 100,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                textAlign: TextAlign.center,
                "Place your phone near the NFC tag on the tree",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ]),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ReportForm()),
            );
          },
          child: const Text('Temp Button'),
        ));
  }
}
