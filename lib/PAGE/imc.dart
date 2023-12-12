import 'package:flutter/material.dart';

class ImcApp extends StatefulWidget {
  @override
  _ImcAppState createState() => _ImcAppState();
}

class _ImcAppState extends State<ImcApp> {
  double _height = 150;
  double _weight = 50;
  double _imc = 0;

  void calculateImc() {
    double heightInMeter = _height / 100;
    setState(() {
      _imc = _weight / (heightInMeter * heightInMeter);
    });
  }
  //inicializadores de tabla imc
  final List<Map<String, dynamic>> imcTable = [
    {'IMC': 'Por debajo de 18.5', 'Estado': 'Bajo peso', 'Color': const Color.fromARGB(255, 87, 169, 236)},
    {'IMC': '18.5–24.9', 'Estado': 'Peso normal', 'Color': const Color.fromARGB(255, 98, 180, 101)},
    {'IMC': '25.0–29.9', 'Estado': 'Pre-obesidad o Sobrepeso', 'Color': Color.fromARGB(255, 230, 214, 74)},
    {'IMC': '30.0–34.9', 'Estado': 'Obesidad clase I', 'Color': const Color.fromARGB(255, 252, 179, 70)},
    {'IMC': '35.0–39.9', 'Estado': 'Obesidad clase II', 'Color': const Color.fromARGB(255, 253, 108, 98)},
    {'IMC': 'Por encima de 40', 'Estado': 'Obesidad clase III', 'Color': const Color.fromARGB(255, 255, 34, 34)},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CALCULADORA IMC'),
        backgroundColor: Color.fromARGB(255, 2, 70, 16),
      ),
      body: SingleChildScrollView(
        child:Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Ingrese su altura y peso', style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            Text('Altura (cm): ${_height.round()}'),
            Slider(
              value: _height,
              min: 100,
              max: 220,
              divisions: 150,
              label: _height.round().toString(),
              onChanged: (double value) {
                setState(() {
                  _height = value;
                });
              },
              activeColor: Color.fromARGB(255, 14, 150, 25),
            ),
            Text('Peso (kg): ${_weight.round()}'),
            Slider(
              value: _weight,
              min: 20,
              max: 170,
              divisions: 120,
              label: _weight.round().toString(),
              onChanged: (double value) {
                setState(() {
                  _weight = value;
                });
              },
              //color verde
              activeColor: Color.fromARGB(255, 15, 209, 31),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                calculateImc();
              },
              style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 15, 143, 26),
                    onPrimary: Colors.white,
                  ),
              child: Text('Calcular IMC'),
            ),
            SizedBox(height: 10),
            Text(
              'IMC: ${_imc.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 24),
            ),
            _crearTablaIMC(),
          ],
        ),
      ),
      ),
    );
  }
  _crearTablaIMC(){
    return SingleChildScrollView(
          child: DataTable(
            columns: const <DataColumn>[
              DataColumn(
                label: Text(
                  'IMC',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'Estado',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
            rows: imcTable
                .map(
                  (data) => DataRow(
                    color: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
                      if (states.contains(MaterialState.selected)) {
                        return Theme.of(context).colorScheme.primary.withOpacity(0.08);
                      }
                      return (data['Color'] as Color?)!;
                    }),
                    cells: [
                      DataCell(
                        Text(data['IMC'] as String, style: TextStyle(color: const Color.fromARGB(255, 20, 20, 20))),
                      ),
                      DataCell(
                        Text(data['Estado'] as String, style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0))),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
    );
  }
}
