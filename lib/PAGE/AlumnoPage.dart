
import 'package:motrizac/grafics/graficedit_page.dart';

import '../POO/AlumnoJSON.dart';
import '../PAGE/listpageAlumnoJSON.dart';
import 'package:flutter/material.dart';
import '../SERVICIO/CRUD_ALUMNO.dart';
import '../FUNCTION/utils.dart' as utils;

import 'package:tflite_flutter/tflite_flutter.dart';

class AlumnoPage extends StatefulWidget {
  @override
  State<AlumnoPage> createState() => _AlumnoPageState();
}

class _AlumnoPageState extends State<AlumnoPage> {
  final formKey = GlobalKey<FormState>();

  final ScaffoldKey = GlobalKey<ScaffoldState>();

  final AlumnoProvider = new AlumnosProvider();

  AlumnoModel alumno = new AlumnoModel();

  bool _guardando = false;

  //inicializadores del grafico
  final _graficoeditpage = Graficoeditpage();
  int edadgrafico=0;
  int pasosgrafico=0;
  
  //inicializadores de calcular BMI
  /*double pesobmi=0.0;
  double alturabmi=0.0;*/
  
  final TextEditingController _bmiController = TextEditingController();
  

  //inicializadores de la IA
  Interpreter? _interpreter;
  //TextEditingController alturaController = TextEditingController();
  String _result = '';
  double outputValue = 0;


  //inicializadores de tabla imc
  final List<Map<String, dynamic>> imcTable = [
    {'IMC': 'IMC abajo de 18.5', 'Estado': 'Bajo de peso', 'Color': const Color.fromARGB(255, 87, 169, 236)},
    {'IMC': '18.5–24.9', 'Estado': 'Peso normal', 'Color': const Color.fromARGB(255, 98, 180, 101)},
    {'IMC': '25.0–29.9', 'Estado': 'Sobrepeso', 'Color': Color.fromARGB(255, 230, 214, 74)},
    {'IMC': '30.0–34.9', 'Estado': 'Obesidad clase I', 'Color': const Color.fromARGB(255, 252, 179, 70)},
    {'IMC': '35.0–39.9', 'Estado': 'Obesidad clase II', 'Color': const Color.fromARGB(255, 253, 108, 98)},
    {'IMC': 'IMC arriba de 40', 'Estado': 'Obesidad clase III', 'Color': const Color.fromARGB(255, 255, 34, 34)},
  ];
  @override
  void initState() {
    super.initState();
    _bmiController.text = alumno.bmi.toString();
    loadModel();
  }

  

  loadModel() async {
    _interpreter = await Interpreter.fromAsset('assets/modelo_entrenado2.tflite');
  }

  void _submitIA(){
    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();
    var alturaia = alumno.altura;
    var pesoia = alumno.peso;
    var edadia = alumno.edad;
    var circuncinturaia = alumno.circuncintura;
    var bmiia = alumno.bmi;
    var velocidadia = alumno.velocidad;
    var zancadaia = alumno.zancada;
    var cadenciaia = alumno.cadencia;
    var pasosia = alumno.pasos;
    //unir datos de alumno en una lista
    var datosia = [edadia,pesoia,alturaia,circuncinturaia,bmiia,cadenciaia,pasosia,velocidadia,zancadaia];
    // convertir datosia en una cadena de valores separados por coma
    String datosiastring = datosia.join(',');
    //mostrarSnackbar('Valor de IA: $datosiastring');
    var datosiafloat = datosia.map((e) => e.toDouble()).toList();

    
    //mostrarSnackbar('Valor de IA: $datosia');
    try{
      
      var output = List<double>.filled(1, 0).reshape([1, 1]);
      _interpreter!.run(datosiafloat,output);
      setState(() {
        _result = 'Resultado: ${output[0]}';
        //convertir output a double
        outputValue = output[0][0];
        mostrarSnackbar('mensaje: $_result');
        if (outputValue < -0.3 ) {
            _result = 'Arriba fuera de rango';
        } else if (outputValue > 3.2) {
            _result = 'Abajo fuera de rango';
        }else if (outputValue >= -0.3 && outputValue < 0.8) {
            _result = 'Por encima de la media';
        } else if (outputValue >= 0.8 && outputValue < 2) {
            _result = 'Competencia motora ideal';
        } else if (outputValue >= 2 && outputValue <= 3.2) {
            _result = 'Por debajo de la media';
        }
      });

    }catch(e){
      setState(() {
        _result = 'Error: $e';
        mostrarSnackbar('mensaje: $_result');
      });

    }
  }
  @override
  
  Widget build(BuildContext context) {

    final AlumnoModel? prodData =
        ModalRoute.of(context)!.settings.arguments as AlumnoModel?;
    if (prodData != null) {
      alumno = prodData;
    }
    TextEditingController alturaController = TextEditingController(text: alumno.altura.toString());
    _bmiController.text = alumno.bmi.toStringAsFixed(2);

    edadgrafico = alumno.edad;
    pasosgrafico = alumno.pasos;
    _graficoeditpage.updatePointgrafico(pasosgrafico,edadgrafico);
    
    return Scaffold(
      key: ScaffoldKey,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 2, 70, 16),
        title: Text('Alumno'),
        actions: <Widget>[
          /*IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: () {},
          ),*/
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                Row(
                  children: [
                    Expanded(child: _crearNombre()),
                    SizedBox(width: 16.0), // Espacio entre los TextFields
                    Expanded(child: _crearApellido()),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: _crearAltura()),
                    SizedBox(width: 16.0),
                    Expanded(child: _crearPeso()),
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: _crearcircuncintura()),
                    SizedBox(width: 16.0),
                    Expanded(child: _crearEdad()),
                  ],
                ),
                Row(
                  children:<Widget> [
                    
                    //if (alumno.id != null)
                      //Expanded(child: _crearBMI()),
                    //if (alumno.id == null)
                      Expanded(child: _crearBMI2()),
                    SizedBox(width: 16.0),
                    //if (alumno.id == null)
                    Expanded(child: _crearBotonbmi()),
                  ],
                ),
                
                if (alumno.id != null)
                Column(
                  children: [
                    Row(
                    children: [
                      Expanded(child: _crearVelocidad()),
                      SizedBox(width: 16.0),
                      Expanded(child: _crearZancada()),
                    ],
                    ),
                    Row(
                      children: [
                        Expanded(child: _crearCadencia()) ,
                        SizedBox(width: 16.0),
                        Expanded(child: _crearPasos()),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 18.0),
                Row(
                  children: [
                    Expanded(child: _crearBoton(),) ,
                    SizedBox(width: 16.0),
                    if (alumno.id != null)
                    Expanded(child: _crearBotonIA()),
                  ],
                ),
                
                Text(_result),
                SizedBox(height: 18.0),
                if (alumno.id == null)
                _crearTablaIMC(),
                if (alumno.id != null)
                _graficoeditpage.creargraficohome(),
                if (alumno.id != null)
                _crearleyenda(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearNombre() {
    return TextFormField(
      initialValue: alumno.nombre,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Nombre',
      ),
      onSaved: (value) => alumno.nombre = value!,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Ingrese el nombre del alumno';
        } else if (value.length < 3) {
          return 'El nombre del alumno debe tener al menos 3 caracteres';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearApellido() {
    return TextFormField(
      initialValue: alumno.apellido,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Apellido',
      ),
      onSaved: (value) => alumno.apellido = value!,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Ingrese el nombre del alumno';
        } else if (value.length < 3) {
          return 'El nombre del alumno debe tener al menos 3 caracteres';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearSeccion() {
    return TextFormField(
      initialValue: alumno.seccion,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Seccion',
      ),
      onSaved: (value) => alumno.seccion = value!,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Ingrese el nombre del alumno';
        } else if (value.length > 1) {
          return 'Debe tener un caracter';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearGrado() {
    return TextFormField(
      initialValue: alumno.grado,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Grado',
      ),
      onSaved: (value) => alumno.grado = value!,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Ingrese el nombre del alumno';
        } else if (value.length < 3) {
          return 'El nombre del alumno debe tener al menos 3 caracteres';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearAltura() {
    return TextFormField(
      initialValue: alumno.altura != 0.0 ? alumno.altura.toString() : null,
      textCapitalization: TextCapitalization.sentences,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: 
      InputDecoration(
        labelText: 'Altura (metros)',
        hintText: '0.00' // Texto de ayuda
        ),
      onSaved: (value) => alumno.altura = double.parse(value!),
      validator: (value) {
        if (utils.isNumeric(value!)) {
          return null;
        } else {
          return 'Solo numeros';
        }
      },
    );
  }

  Widget _crearPeso() {
    return TextFormField(
      initialValue: alumno.peso != 0.0 ? alumno.peso.toString(): null,
      textCapitalization: TextCapitalization.sentences,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(labelText: 'Peso (kilogramos)',hintText: '0.00'),
      onSaved: (value) => alumno.peso = double.parse(value!),
      validator: (value) {
        if (utils.isNumeric(value!)) {
          return null;
        } else {
          return 'Solo numeros';
        }
      },
    );
  }

  Widget _crearcircuncintura(){
    return TextFormField(
      initialValue: alumno.circuncintura != 0.0 ? alumno.circuncintura.toString(): null,
      textCapitalization: TextCapitalization.sentences,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Circuferencia de cintura (metros)',hintText: '0.00'
      ),
      onSaved: (value)=> alumno.circuncintura = double.parse(value!),
      validator: (value) {
        if (utils.isNumeric(value!)) {
          return null;
        } else {
          return 'Solo numeros';
        }
      },
    );
  }

  Widget _crearEdad() {

  return TextFormField(
    initialValue: alumno.edad != 0 ? alumno.edad.toString(): null,
    textCapitalization: TextCapitalization.sentences,
    keyboardType: TextInputType.numberWithOptions(decimal: true),
    decoration: InputDecoration(
      labelText: 'Edad (años)',hintText: '00'
    ),
    onSaved: (value) => alumno.edad = int.parse(value!),
    validator: (value) {
      if (utils.isNumeric(value!)) {
        return null;
      } else {
        return 'Solo números';
      }
      
    },
  );
  }

  /*Widget _crearcalcularBMI(){
    return ElevatedButton(
      onPressed: onPressed, child: child
      )
  }*/

  
  Widget _crearBMI() {
    return TextFormField(
      initialValue: alumno.bmi.toString(),
      textCapitalization: TextCapitalization.sentences,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(labelText: 'IMC'),
      onSaved: (value) => alumno.bmi = double.parse(value!),
      validator: (value) {
        if (utils.isNumeric(value!)) {
          return null;
        } else {
          return 'Solo numeros';
        }
      },
    );
  }

  Widget _crearBMI2() {
    return TextFormField(
      controller: _bmiController,
      textCapitalization: TextCapitalization.sentences,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(labelText: 'IMC'),
      onSaved: (value) => alumno.bmi = double.parse(value!),
      validator: (value) {
        if (utils.isNumeric(value!)) {
          return null;
        } else {
          return 'Solo numeros';
        }
      },
    );
  }

  Widget _crearVelocidad(){
    return TextFormField(
      initialValue: alumno.velocidad != 0.0 ? alumno.velocidad.toString(): null,
      textCapitalization: TextCapitalization.sentences,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Velocidad (Kilometros por hora)',hintText: '0.00'
      ),
      onSaved: (value)=> alumno.velocidad = double.parse(value!),
      validator: (value) {
        if (utils.isNumeric(value!)) {
          return null;
        } else {
          return 'Solo numeros';
        }
      },
    );
  }

  Widget _crearZancada(){
    return TextFormField(
      initialValue: alumno.zancada != 0.0 ? alumno.zancada.toString(): null,
      textCapitalization: TextCapitalization.sentences,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Zancada (centrimetros por paso)',hintText: '0.00'
      ),
      onSaved: (value)=> alumno.zancada = int.parse(value!),
      validator: (value) {
        if (utils.isNumeric(value!)) {
          return null;
        } else {
          return 'Solo numeros';
        }
      },
    );
  }
  
  Widget _crearCadencia(){
    return TextFormField(
      initialValue: alumno.cadencia != 0.0 ? alumno.cadencia.toString(): null,
      textCapitalization: TextCapitalization.sentences,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Cadencia (pasos por minuto)',
        hintText: '0.00', // Texto de ayuda
      ),

      onSaved: (value)=> alumno.cadencia = int.parse(value!),
      validator: (value) {
        if (utils.isNumeric(value!)) {
          return null;
        } else {
          return 'Solo numeros';
        }
      },
    );
  }

  Widget _crearPasos(){
    return TextFormField(
      initialValue: alumno.pasos != 0.0 ? alumno.pasos.toString(): null,
      textCapitalization: TextCapitalization.sentences,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: 'Pasos (Pasos en 15 minutos)',hintText: '00'
      ),
      onSaved: (value)=> alumno.pasos = int.parse(value!),
      validator: (value) {
        if (utils.isNumeric(value!)) {
          return null;
        } else {
          return 'Solo numeros';
        }
      },
    );
  }



  Widget _crearBoton(){
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        primary: Color.fromARGB(255, 6, 151, 25),
        onPrimary: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0)
        )
      ),
      icon: Icon(Icons.save),
      onPressed: (_guardando)
        ? null
        : () {
            setState(() {
              // Coloca aquí el código que quieras ejecutar al presionar el botón
              _submit();
            });
          },
       
      label: Text('Guardar'),
      );

  }

  Widget _crearBotonbmi(){
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        primary: Color.fromARGB(255, 6, 151, 25),
        onPrimary: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0)
        )
      ),
      icon: Icon(Icons.code_off_sharp),
      onPressed: _submitbmi, 
      label: Text('Indice de Masa Corporal'),
    );
  }

  Widget _crearBotonIA(){
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        primary: Color.fromARGB(255, 6, 151, 25),
        onPrimary: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0)
        )
      ),
      icon: Icon(Icons.save),
      onPressed: (_guardando)
        ? null
        : () {
            setState(() {
              // Coloca aquí el código que quieras ejecutar al presionar el botón
              _submitIA();
            });
          },
      label: Text('IA'),
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
  void _submit() {
    setState(() {});
    if (!formKey.currentState!.validate()) return;

    formKey.currentState!.save();

    setState(() {
      _guardando = true;
    });

    if (alumno.id == null) {
      AlumnoProvider.crearAlumno(alumno);
    } else {
      AlumnoProvider.editarAlumno(alumno);
    }

    setState(() {
      _guardando = false;
    });

    mostrarSnackbar('Registro guardado');

    Navigator.pop(context, true);
    //actualizar datos de lista en otra pantalla
    Navigator.pushReplacementNamed(context, 'listaalumno');
  }

  _crearleyenda(){
    return RichText(
    text: TextSpan(
      children: <TextSpan>[
        TextSpan(text: '------  Muy por encima \n', style: TextStyle(color: Colors.cyan)),
        TextSpan(text: '------  Por encima \n', style: TextStyle(color: Colors.red[800])),
        TextSpan(text: '------  Estado medio \n', style: TextStyle(color: Colors.red)),
        TextSpan(text: '------  Por debajo \n', style: TextStyle(color: Colors.orange)),
        TextSpan(text: '------  Muy por debajo \n', style: TextStyle(color: Colors.green)),
      ],
    ),
  );
  }

  void _submitbmi() {
    if (!formKey.currentState!.validate()) return;
    formKey.currentState!.save();
    double alturabmi = alumno.altura.toDouble();
    double pesobmi = alumno.peso.toDouble();
    double bmifinal = pesobmi / (alturabmi * alturabmi);
    print('El valor de BMI es: $bmifinal');
    setState(() {
      alumno.bmi = bmifinal;
      //solo 2 decimales
      bmifinal.toStringAsFixed(2);
      _bmiController.text = bmifinal.toString();
      //_bmiController.text = bmifinal.toString();
    });
  }

  void mostrarSnackbar(String mensaje) {
    final snackbar = SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 1500),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  @override
  void dispose() {
    //_textEditingController.dispose();
    if (_interpreter != null) {
      _interpreter!.close();
    }
    _bmiController.dispose();
    super.dispose();
  }
}
