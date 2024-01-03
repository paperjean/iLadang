import 'package:flutter/material.dart';
import 'package:sawitcare_app/pages/bricks/Widgets%20Example/add_button.dart';
import 'package:sawitcare_app/pages/bricks/Widgets%20Example/gradient_button_rounded.dart';

class Tree extends StatelessWidget {
  const Tree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: AppBar(
              elevation: 0,
              centerTitle: false,
              title: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Tree',
                    ),
                  ],
                ),
              ),
            )),
        body: Center(
            child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 10, bottom: 10),
                    child: GradientButtonFb4(
                        text: "Manage Payment", onPressed: () {}),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 10, bottom: 10),
                    child: AddButton(text: "Add New Tree", onPressed: () {}),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 10, bottom: 10),
                    child: AddButton(text: "Track Loans", onPressed: () {}),
                  ),
                  Divider(
                    color: Colors.white,
                    thickness: 0.5,
                    endIndent: 20,
                    indent: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, right: 140),
                    child: Text('Recently Completed Jobs',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: DataTable(
                        columnSpacing: 46,
                        columns: [
                          DataColumn(
                              label: Text(
                            'Name',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12),
                          )),
                          DataColumn(
                              label: Text(
                            'Type',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12),
                          )),
                          DataColumn(
                              label: Text(
                            'DateTime',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12),
                          )),
                          DataColumn(
                              label: Text(
                            'Block',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 12),
                          )),
                        ],
                        rows: [
                          DataRow(cells: [
                            DataCell(Text('Armand')),
                            DataCell(Text('Harvest')),
                            DataCell(Text('20.5.2023')),
                            DataCell(Text('A')),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('Firdaus')),
                            DataCell(Text('Fixing')),
                            DataCell(Text('19.5.2023')),
                            DataCell(Text('B')),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('Danial')),
                            DataCell(Text('Pruning')),
                            DataCell(Text('18.5.2023')),
                            DataCell(Text('B')),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('Ikmal')),
                            DataCell(Text('Fertilize')),
                            DataCell(Text('18.5.2023')),
                            DataCell(Text('C')),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('Haziq')),
                            DataCell(Text('Harvest')),
                            DataCell(Text('15.5.2023')),
                            DataCell(Text('C')),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('Farhan')),
                            DataCell(Text('Pruning')),
                            DataCell(Text('14.5.2023')),
                            DataCell(Text('D')),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('Hasliza')),
                            DataCell(Text('Fertilize')),
                            DataCell(Text('13.5.2023')),
                            DataCell(Text('A')),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('Ainul')),
                            DataCell(Text('Fixing')),
                            DataCell(Text('12.5.2023')),
                            DataCell(Text('C')),
                          ]),
                        ],
                      ),
                    ),
                  )),
            ),
          ],
        )));
  }
}
