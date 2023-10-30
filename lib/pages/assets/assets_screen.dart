import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Assets extends StatefulWidget {
  const Assets({super.key});

  @override
  State<Assets> createState() => _AssetsState();
}

class _AssetsState extends State<Assets> {
  final _treeStream =
      Supabase.instance.client.from('tree').stream(primaryKey: ['id']);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 47, 47, 47),
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            backgroundColor: Color.fromARGB(255, 47, 47, 47),
            elevation: 0,
            centerTitle: false,
            title: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Assets',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          )),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _treeStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final tree = snapshot.data!;
          return ListView.builder(
              itemCount: tree.length,
              itemBuilder: (contex, index) {
                return ListTile(
                  title: Text(tree[index]['block']),
                  textColor: Colors.white,
                );
              });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: ((context) {
                return SimpleDialog(
                  title: const Text('Add Tree'),
                  contentPadding: EdgeInsets.symmetric(horizontal: 100),
                  children: [
                    TextFormField(onFieldSubmitted: (value) async {
                      await Supabase.instance.client
                          .from('tree')
                          .insert({'block': value});
                    }),
                  ],
                );
              }));
        },
        child: const Icon(Icons.add),
        backgroundColor: Color.fromARGB(255, 99, 201, 142),
      ),
    );
  }
}
