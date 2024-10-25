import 'dart:convert';

import 'package:biodata/ui/tambah_data.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'siswa.dart';
import 'api.dart'; // Sesuaikan dengan file API Anda
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  late Future<List<SiswaModel>> sw;

  @override
  void initState() {
    super.initState();
    sw = getSwList();
  }

  Future<List<SiswaModel>> getSwList() async {
    final response = await http.get(Uri.parse(BaseUrl.List));

    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();
      return items.map<SiswaModel>((json) => SiswaModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<void> _refreshData() async {
    setState(() {
      sw = getSwList();
    });
  }

  // Fungsi untuk navigasi ke halaman TambahData dan menangkap hasilnya
  Future<void> _navigateAndRefresh(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TambahData()),
    );

    // Jika result adalah true, lakukan refresh
    if (result == true) {
      _refreshData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Data Siswa"),
        centerTitle: true,
        backgroundColor: Colors.cyan,
      ),
      body: Center(
        child: FutureBuilder<List<SiswaModel>>(
          future: sw,
          builder: (BuildContext context, AsyncSnapshot<List<SiswaModel>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Text("No Data Found");
            }

            return RefreshIndicator(
              onRefresh: _refreshData,
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  var data = snapshot.data![index];
                  return Card(
                    child: ListTile(
                      leading: Icon(Icons.person),
                      trailing: Icon(Icons.view_list),
                      title: Text(
                        "${data.alamat} - ${data.nama}",
                        style: TextStyle(fontSize: 20),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Alamat: ${data.alamat}"),
                          Text("Jenis Kelamin: ${data.kelamin}"),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateAndRefresh(context),
        child: Icon(Icons.add),
        backgroundColor: Colors.cyan,
      ),
    );
  }
}
