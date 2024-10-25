import 'package:flutter/material.dart';



class BiodataDetail extends StatefulWidget {
  final String? nama;
  final String? alamat;
  final String? Status;
  final String? Agama;


  const BiodataDetail({Key? key, this.nama, this.alamat, this.Status, this.Agama})
      : super(key : key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ItemDetailState();
  }
}

class ItemDetailState extends State<BiodataDetail>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Biodata'),
        centerTitle: true,
        backgroundColor: Colors.indigoAccent,
      ),
      body: Column(
        children: [
          Text("Nama = " + widget.nama.toString()),
          Text("Alamat = ${widget.alamat}"),
          Text("Jenis Kelamin = ${widget.Status}"),
          Text("Agama = ${widget.Agama}")
        ],
      ),
    );
  }
}