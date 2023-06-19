import 'package:flutter/material.dart';
import 'package:case_12/pertemuan12/pertemuan12_screen.dart';
import 'package:case_12/pertemuan12/pertemuan12_provider.dart';
import 'package:provider/provider.dart';

class Pertemuan12DetailScreen extends StatefulWidget {
  const Pertemuan12DetailScreen({super.key});

  @override
  State<Pertemuan12DetailScreen> createState() =>
      _Pertemuan12DetailScreenState();
}

class _Pertemuan12DetailScreenState extends State<Pertemuan12DetailScreen> {
  @override
  void initState() {
    Future.microtask(() {
      Provider.of<Pertemuan12Provider>(context, listen: false).initialData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Information'),
        actions: [menuList(context)],
      ),
      body: body(context),
    );
  }
}

body(BuildContext context) {
  final prov = Provider.of<Pertemuan12Provider>(context);
  if (prov.data == null) {
    return const CircularProgressIndicator();
  } else {
    return GridView.count(
      crossAxisCount: 2,
      children: List.generate(prov.data['data']!.length, (index) {
        var item = prov.data['data']![index];
        return Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              ListTile(
                
                title: Text(item['model'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    )),
                    
                subtitle: Text(
                  item['developer'],
                  style: TextStyle(color: Colors.grey),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                tileColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // Ubah border radius
                  side: BorderSide(
                      color: Colors.grey.shade300), // Ubah warna border
                ),
              ),
              const SizedBox(height: 15.0),
              Padding(padding: const EdgeInsets.all(1.0),
              
              child: Image.network('https://picsum.photos/250?image=9'),
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  item['desc'],
                  style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.normal),
                ),
              ),
              
              Padding(
                padding: EdgeInsets.all(15.0),
                child: ButtonBar(
                  alignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Rp. ${item['price'].toString()},-',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            SizedBox(height: 8),
                            const Icon(Icons.star, color: (Colors.yellow)),
                            Text('${item['rating'].toString()}'),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

menuList(BuildContext context) {
  final prov = Provider.of<Pertemuan12Provider>(context);

  return PopupMenuButton(
    icon: const Icon(Icons.more_vert),
    itemBuilder: (BuildContext context) {
      return <PopupMenuEntry>[
        PopupMenuItem(
          child: ListTile(
            onTap: () => prov.ubahList('hp'),
            leading: const Icon(Icons.phone),
            title: const Text('HP'),
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem(
          child: ListTile(
            onTap: () => prov.ubahList('laptop'),
            leading: const Icon(Icons.laptop),
            title: const Text('Laptop'),
          ),
        ),
        PopupMenuItem(
          child: ListTile(
            onTap: () {
              prov.ubahList('clear');
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Clear'),
                    content: Text('Data tidak ditemukan.'),
                    actions: [
                      TextButton(
                        child: Text('OK'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
            leading: Icon(Icons.clear),
            title: Text('Clear'),
          ),
        ),
      ];
    },
  );
}