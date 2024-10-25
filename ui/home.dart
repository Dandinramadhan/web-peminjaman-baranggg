// import 'dart:convert';
// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'biodata.dart';
// // import 'api.dart';
// import 'tambah_data.dart';
//
// import 'package:http/http.dart' as http;
//
// class Home extends StatefulWidget {
//   Home({Key? key}) : super(key: key);
//   @override
//   HomeState createState() => HomeState();
// }
//
// class HomeState extends State<Home> {
//   late Future<List<SiswaModel>> sw;
//   final swListkey = GlobalKey<HomeState>();
//
//   @override
//   void initState() {
//     super.initState();
//     sw = getSwList();
//   }
//
//   Future<List<SiswaModel>> getSwList() async {
//     final startTime = DateTime.now();
//     final response = await http.get(Uri.parse(BaseUrl.List)).timeout(Duration(seconds: 10));
//     final endTime = DateTime.now();
//     final items = json.decode(response.body).cast<Map<String, dynamic>>();
//     print('Network Request took ${endTime.difference(startTime).inMilliseconds} milliseconds');
//     List<SiswaModel> sw = items.map<SiswaModel>((json) {
//       return SiswaModel.fromJson(json);
//     }).toList();
//
//     return sw;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("List Data Siswa"),
//         centerTitle: true,
//         backgroundColor: Colors.cyan,
//       ),
//       body: Center(
//         child: FutureBuilder<List<SiswaModel>>(
//           future: sw,
//           builder: (BuildContext context, AsyncSnapshot<List<SiswaModel>> snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return CircularProgressIndicator();
//             } else if (snapshot.hasError) {
//               return Text("Error: ${snapshot.error}");
//             } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//               return Text("No Data Found");
//             }
//
//             return ListView.builder(
//               itemCount: snapshot.data!.length,
//               itemBuilder: (BuildContext context, int index) {
//                 var data = snapshot.data![index];
//                 return Card(
//                   child: ListTile(
//                     leading: Icon(Icons.person),
//                     trailing: Icon(Icons.view_list),
//                     title: Text(
//                       "${data.nisn}  -  ${data.nama}",
//                       style: TextStyle(fontSize: 20),
//                     ),
//                     subtitle: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text("Alamat: ${data.alamat}"),
//                         Text("Jenis Kelamin: ${data.jenis_kelamin}"),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             );
//           },
//         ),
//       ),
//
//
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.add),
//         hoverColor: Colors.grey,
//         backgroundColor: Colors.deepOrange,
//         onPressed: () {
//           // Navigasi ke halaman tambah_data.dart
//           Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (context) => TambahData(), // Pindah ke halaman tambah_data.dart
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//
import 'package:flutter/material.dart';
import 'biodata_form.dart'; // Import halaman biodata form

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Selamat Datang di Aplikasi Biodata',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      vertical: 16, horizontal: 32),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  backgroundColor: Colors.blueAccent,
                ),
                onPressed: () {
                  // Navigasi ke halaman form biodata
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BiodataForm(),
                    ),
                  );
                },
                child: const Text(
                  'Isi Biodata',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
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

