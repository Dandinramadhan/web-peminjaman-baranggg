import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TambahData extends StatefulWidget {
  @override
  _TambahDataState createState() => _TambahDataState();
}

class _TambahDataState extends State<TambahData> {
  final _formKey = GlobalKey<FormState>();

  final namaController = TextEditingController();
  final tplahirController = TextEditingController();
  final tglahirController = TextEditingController();
  final kelaminController = TextEditingController();
  final agamaController = TextEditingController();
  final alamatController = TextEditingController();

  @override
  void dispose() {
    namaController.dispose();
    tplahirController.dispose();
    tglahirController.dispose();
    kelaminController.dispose();
    agamaController.dispose();
    alamatController.dispose();
    super.dispose();
  }

  Future<void> submitData() async {
    if (_formKey.currentState!.validate()) {
      // Mengumpulkan data dari form
      final Map<String, String> formData = {
        'nama': namaController.text,
        'tplahir': tplahirController.text,
        'tglahir': tglahirController.text,
        'kelamin': kelaminController.text,
        'agama': agamaController.text,
        'alamat': alamatController.text,
      };

      // Mengirim POST request ke server PHP
      final response = await http.post(
        Uri.parse('http://192.168.137.93/biodataa/create.php'), // Ganti dengan URL servermu
        body: formData,
      );

      if (response.statusCode == 200) {
        final result = json.decode(response.body);

        if (result['success']) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Data berhasil disimpan!'),
            backgroundColor: Colors.green,
          ));
          Navigator.pop(context, true); // Kembalikan nilai true setelah data berhasil ditambahkan
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Gagal menyimpan data: ${result['message']}'),
            backgroundColor: Colors.red,
          ));
        }

      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Terjadi kesalahan saat menghubungi server'),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Data Siswa"),
        backgroundColor: Colors.cyan,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: namaController,
                decoration: InputDecoration(labelText: 'Nama'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama tidak boleh kosong';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: tplahirController,
                decoration: InputDecoration(labelText: 'Tempat Lahir'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Tempat lahir tidak boleh kosong';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: tglahirController,
                decoration: InputDecoration(labelText: 'Tanggal Lahir (DD-MM-YYYY)'),
                keyboardType: TextInputType.datetime,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Tanggal lahir tidak boleh kosong';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: kelaminController,
                decoration: InputDecoration(labelText: 'Jenis Kelamin'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Jenis kelamin tidak boleh kosong';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: agamaController,
                decoration: InputDecoration(labelText: 'Agama'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Agama tidak boleh kosong';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: alamatController,
                decoration: InputDecoration(labelText: 'Alamat'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Alamat tidak boleh kosong';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: submitData,
                child: Text('Submit'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyan,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
