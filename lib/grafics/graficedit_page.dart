
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';

class Graficoeditpage {

  void initControllers(TextEditingController edadController, TextEditingController pasosController) {
    edadController = edadController;
    pasosController = pasosController;
  }

  
  Widget creargraficohome(){
    
      return SfCartesianChart(
      
      primaryXAxis: NumericAxis(title: AxisTitle(
          text: '   Años',
          textStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        majorTickLines: MajorTickLines(size: 10),
        desiredIntervals: 5,
        //intervalos minimos 5
        minimum: 6,
        maximum: 17,
        //solo numeros enteros
        numberFormat: NumberFormat('#'),
      ),
      primaryYAxis: NumericAxis(
        title: AxisTitle(
          text: '   Pasos',
          textStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      series: <ChartSeries>[
        LineSeries<SalesData, int>(
          dataSource: salesData,
          xValueMapper: (SalesData sales, _) => sales.year,
          yValueMapper: (SalesData sales, _) => sales.pasos,
        ),
        LineSeries<SalesData, int>(
          dataSource: salesData2,
          xValueMapper: (SalesData sales, _) => sales.year,
          yValueMapper: (SalesData sales, _) => sales.pasos,
        ),
        LineSeries<SalesData, int>(
          dataSource: salesData3,
          xValueMapper: (SalesData sales, _) => sales.year,
          yValueMapper: (SalesData sales, _) => sales.pasos,
        ),
        LineSeries<SalesData, int>(
          dataSource: salesData4,
          xValueMapper: (SalesData sales, _) => sales.year,
          yValueMapper: (SalesData sales, _) => sales.pasos,
        ),
        LineSeries<SalesData, int>(
          dataSource: salesData5,
          xValueMapper: (SalesData sales, _) => sales.year,
          yValueMapper: (SalesData sales, _) => sales.pasos,
        ),
        ScatterSeries<SalesData, int>(
          dataSource: profitData,
          xValueMapper: (SalesData sales, _) => sales.year,
          yValueMapper: (SalesData sales, _) => sales.pasos,
          markerSettings: MarkerSettings(
            isVisible: true,
          ),
        )
      ],
    );
  }

  void updatePointgrafico(int pasosd,int edadd) {
    try {
      int year = edadd;
      int pasos = pasosd;

      print('object: $year');
      if (profitData.isNotEmpty) {
        profitData.removeAt(0); // Supongo que deseas eliminar el primer elemento de la lista
      }

      // Actualiza la lista de datos con los nuevos valores
      profitData.add(SalesData(year, pasos));

      // Imprime la lista actualizada
      print("Profit Data: $profitData");
    } catch (e) {
      print("Error al convertir los valores de entrada a números.");
    }
  }

  /*_inputedad(){
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            TextField(
              controller: _edadController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Year',
              ),
              onChanged: (valor) {
                setState(() {
                    _updatePointgrafico();
                  });
              },
            ),
          ],
        ),
      ),
    );
  }

  _inputanos(){
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            TextField(
              controller: _pasosController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Sales',
              ),
              onChanged: (valor) {
                  setState(() {
                    _updatePointgrafico();
                  });
              },
            ),
          ],
        ),
      ),
    );
  }*/
}
  
  //Datos para las lineas
  /*final List<SalesData> salesData = [
  SalesData(3, 656),SalesData(5, 762),SalesData(10, 917),SalesData(15, 1016),SalesData(30, 1157)
  ];
  final List<SalesData> salesData2 = [
  SalesData(3, 407),SalesData(5, 522),SalesData(10, 696),SalesData(25, 812),SalesData(30, 980)
  ];
  final List<SalesData> salesData3 = [
  SalesData(3, 305),SalesData(5, 396),SalesData(10, 543),SalesData(25, 646),SalesData(30, 803)
  ];
  final List<SalesData> salesData4 = [
  SalesData(3, 263),SalesData(5, 333),SalesData(10, 451),SalesData(25, 539),SalesData(30, 681)
  ];
  final List<SalesData> salesData5 = [
  SalesData(3, 178),SalesData(5, 218),SalesData(10, 289),SalesData(25, 344),SalesData(30, 439)
  ];
  final List<SalesData> profitData = [
    SalesData(15, 450),
  ];*/
  
  //intento de datos 2
  final List<SalesData> salesData = [
  SalesData(6, 2034),SalesData(8, 2119),SalesData(10, 2028),SalesData(12, 2013),SalesData(14, 1599),SalesData(17, 1523)
  ];
  final List<SalesData> salesData2 = [
  SalesData(6, 1762),SalesData(8, 1750),SalesData(10, 1604),SalesData(12, 1512),SalesData(14, 1109),SalesData(17, 955)
  ];
  final List<SalesData> salesData3 = [
  SalesData(6, 1406),SalesData(8, 1288),SalesData(10, 1108),SalesData(12, 977),SalesData(14, 656),SalesData(17, 515)
  ];
  final List<SalesData> salesData4 = [
  SalesData(6, 1016),SalesData(8, 812),SalesData(10, 646),SalesData(12, 539),SalesData(14, 344),SalesData(17, 262)
  ];
  final List<SalesData> salesData5 = [
  SalesData(6, 656),SalesData(8, 407),SalesData(10, 305),SalesData(12, 263),SalesData(14, 178),SalesData(17, 143)
  ];
  final List<SalesData> profitData = [
    SalesData(15, 450),
  ];
class SalesData {
  SalesData(this.year, this.pasos);
  final int year;
  final int pasos;
}