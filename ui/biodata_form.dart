import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'biodata_detail.dart';
import 'package:group_radio_button/group_radio_button.dart';

class BiodataForm extends StatefulWidget {
  const BiodataForm({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return BiodataFormState();
  }
}

class BiodataFormState extends State<BiodataForm> {
  final namaTextboxController = TextEditingController();
  final alamatTextboxController = TextEditingController();
  final status = ["Laki - Laki", "Perempuan"];
  String _verticalGroupValue = "Laki - Laki";

  final List<String> items = [
    'Islam',
    'Katolik',
    'Kristen',
    'Hindu',
    'Budda',
  ];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // Light background similar to the image
      body: Center(
        child: Container(
          width: 400, // Fixed width for the form container
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "INPUT BIODATA",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              textboxNama(),
              const SizedBox(height: 16),
              textboxAlamat(),
              const SizedBox(height: 16),
              _textboxGenderWarga(),
              const SizedBox(height: 16),
              agama(),
              const SizedBox(height: 24),
              tombolSimpan(),
            ],
          ),
        ),
      ),
    );
  }

  Widget textboxNama() {
    return TextField(
      decoration: InputDecoration(
        labelText: "Nama",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 2.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: Colors.green,
            width: 2.0,
          ),
        ),
      ),
      controller: namaTextboxController,
    );
  }

  Widget textboxAlamat() {
    return TextField(
      decoration: InputDecoration(
        labelText: "Alamat",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 2.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(
            color: Colors.green,
            width: 2.0,
          ),
        ),
      ),
      controller: alamatTextboxController,
    );
  }

  Widget _textboxGenderWarga() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Gender"),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 2.0),
            borderRadius: BorderRadius.circular(5),
          ),
          child: RadioGroup<String>.builder(
            direction: Axis.horizontal,
            groupValue: _verticalGroupValue,
            onChanged: (value) => setState(() {
              _verticalGroupValue = value!;
            }),
            items: status,
            itemBuilder: (item) => RadioButtonBuilder(
              item,
            ),
            fillColor: Colors.green,
          ),
        ),
      ],
    );
  }

  Widget agama() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Agama"),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey, width: 2.0),
            borderRadius: BorderRadius.circular(5),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              isExpanded: true,
              hint: const Text(
                'Pilih Agama',
                style: TextStyle(fontSize: 14),
              ),
              items: items
                  .map((String item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ))
                  .toList(),
              value: selectedValue,
              onChanged: (String? value) {
                setState(() {
                  selectedValue = value;
                });
              },
              buttonStyleData: const ButtonStyleData(
                padding: EdgeInsets.symmetric(horizontal: 16),
                height: 40,
                width: double.infinity,
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 40,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget tombolSimpan() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        backgroundColor: Colors.black,
      ),
      onPressed: () {
        String nama = namaTextboxController.text;
        String alamat = alamatTextboxController.text;
        String Status = _verticalGroupValue;
        String? Agama = selectedValue;

        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => BiodataDetail(
              nama: nama,
              alamat: alamat,
              Status: Status,
              Agama: Agama,
            )));
      },
      child: const Text(
        'Simpan',
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}