import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sawitcare_app/main.dart';
import 'package:sawitcare_app/pages/management/tree/tree_add.dart';
import 'package:sawitcare_app/pages/management/tree/tree_list_widget.dart';
import 'package:sawitcare_app/pages/management/tree/tree_screen.dart';
import 'package:sawitcare_app/services/tree.dart';

class TreeList extends StatefulWidget {
  final List? treeList;

  const TreeList({
    Key? key,
    required this.treeList,
  }) : super(key: key);

  @override
  State<TreeList> createState() => _TreeListState();
}

class _TreeListState extends State<TreeList> {
  List? _treeList;
  bool _isLoading = true; // Initialize as true to show loading initially
  List? _originalTreeList; // Store original unfiltered list
  bool _sortByDescending = true; // Added for sorting
  bool _filterByBlock = false; // Added for filtering
  String _selectedBlock = 'Block'; // Added for filtering
  String _selectedSortOption = 'Sort by'; // Added for sorting
  List<String> _blockTypes = ['Block']; // Initialize with 'Block'

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
                  // Navigator.pushNamed(context, '/treeadd');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TreeAddPage(
                                treeList: widget.treeList,
                              )));
                },
                icon: const Icon(Icons.add_circle),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            // Added for filtering and sorting
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(230, 252, 242, 1),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: Color.fromRGBO(43, 128, 90, 0.5), width: 2),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedBlock, // Default value
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _selectedBlock =
                              newValue; // Update selected sorting option
                          _filterTreeListByBlock(newValue);
                        });
                      }
                    },
                    items: _blockTypes
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text('$value'),
                      );
                    }).toList(),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(230, 252, 242, 1),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: Color.fromRGBO(43, 128, 90, 0.5), width: 2),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedSortOption, // Default value
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _selectedSortOption =
                              newValue; // Update selected sorting option
                        });
                      }
                    },
                    items: <String>[
                      'Sort by',
                      'Harvested',
                      'Pruned',
                      'Fertilized'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text('$value'),
                      );
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(
                width: 75,
                height: 50,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      _sortByDescending = !_sortByDescending;
                      _sortTreeList(_selectedSortOption);
                    });
                  },
                  child: Row(
                    children: [
                      _sortByDescending
                          ? const Icon(Icons
                              .filter_list_off_rounded) // Icon for descending order
                          : const Icon(Icons
                              .filter_list_rounded), // Icon for ascending order
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Center(
                    child: ListView.builder(
                      itemCount: _treeList?.length ?? 0,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.all(10),
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
          ),
        ],
      ),
    );
  }

  void _sortTreeList(String? sortOption) {
    if (_sortByDescending) {
      _treeList?.sort((a, b) {
        // Handle null values by putting them at the bottom
        if (a['days$sortOption'] == null && b['days$sortOption'] == null) {
          return 0;
        } else if (a['days$sortOption'] == null) {
          return 1;
        } else if (b['days$sortOption'] == null) {
          return -1;
        } else {
          return b['days$sortOption'].compareTo(a['days$sortOption']);
        }
      });
    } else {
      _treeList?.sort((a, b) {
        // Handle null values by putting them at the bottom
        if (a['days$sortOption'] == null && b['days$sortOption'] == null) {
          return 0;
        } else if (a['days$sortOption'] == null) {
          return 1;
        } else if (b['days$sortOption'] == null) {
          return -1;
        } else {
          return a['days$sortOption'].compareTo(b['days$sortOption']);
        }
      });
    }
  }

  void _filterTreeListByBlock(String blockType) {
    setState(() {
      if (blockType == 'Block') {
        // If 'Block' is selected, show all trees
        _treeList = _originalTreeList;
      } else {
        // Filter the tree list to contain only trees with the selected block type
        _treeList = _originalTreeList
            ?.where((tree) => tree['block'] == blockType)
            .toList();
      }
    });
  }

  Future<void> _fetchTreeList() async {
    setState(() {
      _isLoading = true; // Set loading to true before fetching
    });
    try {
      setState(() {
        _treeList = widget.treeList ?? []; // Assign fetched data to _treeList
        _blockTypes = ['Block']; // Reset the list before updating
        _originalTreeList =
            widget.treeList ?? []; // Store the original unfiltered list
        if (_treeList != null) {
          // Extract unique block types
          _treeList!.forEach((tree) {
            if (!_blockTypes.contains(tree['block'].toString())) {
              _blockTypes.add(tree['block'].toString());
            }
          });
          // Sort block types alphabetically
          _blockTypes.remove('Block'); // Remove 'Block' temporarily
          _blockTypes.sort(); // Sort remaining block types
          _blockTypes.insert(0, 'Block'); // Add 'Block' back at the beginning
        }
        // Sort the tree list immediately after fetching
        _sortTreeList(_selectedSortOption);
        _isLoading = false;
        // Set loading to false after fetching
      });
      print(_treeList);
    } catch (e) {
      print(e);
    }
  }
}
