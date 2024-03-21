import 'package:flutter/material.dart';
import 'package:sawitcare_app/pages/activity/activity_screen.dart';
import 'package:sawitcare_app/pages/field/reporting/activity_card.dart';
import 'package:sawitcare_app/pages/field/reporting/number_picker.dart';
import 'package:sawitcare_app/pages/field/reporting/tree_info_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ReportHarvest extends StatefulWidget {
  const ReportHarvest({super.key});

  @override
  State<ReportHarvest> createState() => _ReportHarvestState();
}

class _ReportHarvestState extends State<ReportHarvest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Report form
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            elevation: 0,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            centerTitle: true,
            title: const Text(
              'Confirm Details',
            ),
          )),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TreeInfoCard(treeName: "B152"),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(
                      color: Color.fromRGBO(226, 232, 240, 1),
                      width: 1,
                    )),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: const Text(
                      'Harvest ',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    trailing: Image.asset('assets/sickle.png'),
                  ),
                ),
              ),

              const SizedBox(
                height: 20,
              ),
              // Number picker
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: NumberPicker(
                  textArray: ["1", "2", "3"],
                  onChange: (i) => print(i),
                ),
              ),

              const Text(
                'Number of fruits harvested',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // Remark
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Remark',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              // Take Picture Button
              Container(
                width: 200,
                height: 80,
                child: ElevatedButton(
                  style: ButtonStyle(),
                  onPressed: () {},
                  child: const Row(
                    children: [
                      const Icon(Icons.camera_alt),
                      Spacer(),
                      const Text('Take Picture'),
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
