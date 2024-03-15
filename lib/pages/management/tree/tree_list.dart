import 'package:flutter/material.dart';
import 'package:sawitcare_app/main.dart';
import 'package:sawitcare_app/pages/management/tree/tree_list_widget.dart';
import 'package:sawitcare_app/pages/management/tree/tree_screen.dart';
import 'package:sawitcare_app/services/tree.dart';

class TreeList extends StatefulWidget {
  const TreeList({super.key});

  @override
  State<TreeList> createState() => _TreeListState();
}

class _TreeListState extends State<TreeList> {
  List? _treeList;
  bool _isLoading = true; // Initialize as true to show loading initially

  @override
  void initState() {
    super.initState();
    _fetchTreeList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 60),
        child: AppBar(
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "Tree List",
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/treeadd');
                },
                icon: const Icon(Icons.add_circle),
              ),
            ),
          ],
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: ListView.separated(
                separatorBuilder: (context, index) => const Divider(
                  height: 1, // Adjust separator height as needed
                  color: Color.fromARGB(
                      255, 218, 218, 218), // Customize separator color
                ),
                itemCount: _treeList?.length ?? 0,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: (BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    )),
                    height: 75,
                    child: // Tree List Widget
                        TreeListWidget(
                      treeId: _treeList![index]['block'].toString() +
                          _treeList![index]['tree_number'].toString(),
                      harvest: _treeList![index]['daysHarvested'],
                      fertilize: _treeList![index]['daysFertilized'],
                      prune: _treeList![index]['daysPruned'],
                    ),
                  );
                },
              ),
            ),
    );
  }

  Future<void> _fetchTreeList() async {
    setState(() {
      _isLoading = true; // Set loading to true before fetching
    });
    try {
      final data = await fetchTreeList(); // Call the service function
      setState(() {
        _treeList = data ?? []; // Assign fetched data to _treeList
        _isLoading = false; // Set loading to false after fetching
      });
      print(_treeList);
    } catch (e) {
      print(e);
    }
  }
}
