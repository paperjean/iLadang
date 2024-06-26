import 'package:flutter/material.dart';
import 'package:sawitcare_app/pages/field/reporting/activity_card.dart';
import 'package:sawitcare_app/pages/field/reporting/harvest_report.dart';
import 'package:sawitcare_app/pages/field/reporting/tree_info_widget.dart';

class ReportForm extends StatefulWidget {
  const ReportForm({super.key});

  @override
  State<ReportForm> createState() => _ReportFormState();
}

class _ReportFormState extends State<ReportForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                'Report Form',
              ),
              actions: [],
            )),
        body: Center(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: TreeInfoCard(treeName: "B152"),
              ),
              // Line
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Container(
                  height: 1,
                  width: MediaQuery.of(context).size.width,
                  color: Color.fromRGBO(217, 217, 217, 1),
                ),
              ),
              const Text(
                'Choose Activity',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {},
                  child: ActivityCard(
                      text: "Harvest",
                      imageAsset: 'assets/sickle.png',
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ReportHarvest()));
                      }),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ActivityCard(
                    text: "Prune",
                    imageAsset: 'assets/leaf.png',
                    onPressed: () {}),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ActivityCard(
                    text: "Fertilize",
                    imageAsset: 'assets/fertilizer_icon.png',
                    onPressed: () {}),
              ),
            ],
          ),
        ));
  }
}
