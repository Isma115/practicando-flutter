import 'package:app_prueba/ui/anadir_autor.dart';
import 'package:app_prueba/ui/anadir_libro.dart';
import 'package:app_prueba/ui/anadir_prestamo.dart';
import 'package:app_prueba/ui/anadir_usuario.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TablaRegistros extends StatefulWidget {
  final String entidad;

  TablaRegistros({required this.entidad});

  @override
  _TablaRegistrosState createState() => _TablaRegistrosState();
}

class _TablaRegistrosState extends State<TablaRegistros> {
  late List<Map<String, String>> datosCargados;
  bool isLoading = true; // Indicador de carga

  @override
  void initState() {
    super.initState();
    _cargarRegistros(); // Cargar datosCargados al inicializar
  }

  final columnasdatosCargados = [
    'id',
    'nombre_apellido',
    'email',
    'fecha_registro',
    'telefono'
  ];
  final columnasAutores = [
    'id',
    'nombre_apellido',
    'nacionalidad',
    'fecha_nacimiento'
  ];

  final columnasPrestamos = [
    'id',
    'id_usuario',
    'id_libro',
    'fecha_prestamo',
    'fecha_devolucion',
    'fecha_devolucion_real',
    'estado',
  ];

  final columnasLibros = [
    'id',
    'titulo',
    'id_autor',
    'anio_publicacion',
    'genero',
    'disponible',
  ];

  Future<void> _cargarRegistros() async {
    try {
      List<Map<String, String>> data = [];
      switch (widget.entidad) {
        case "Usuario":
          data = await fetchDatos(columnasdatosCargados);
          break;
        case "Autor":
          data = await fetchDatos(columnasAutores);
          break;
        case "Prestamo":
          data = await fetchDatos(columnasPrestamos);
          break;
        case "Libro":
          data = await fetchDatos(columnasLibros);
          break;
      }

      setState(() {
        datosCargados = data;
        isLoading = false;
      });
    } catch (e) {
      print('Error al cargar entidad: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _aniadirRegistro(Map<String, String> nuevoRegistro) async {
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:3000/api/${widget.entidad}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(nuevoRegistro),
      );
      if (response.statusCode == 200) {
        _cargarRegistros(); // Recargar los datosCargados después de añadir
      } else {
        throw Exception('Error al añadir registro');
      }
    } catch (e) {
      print('Error al añadir registro: $e');
    }
  }

  Future<void> _eliminarRegistro(String id) async {
    try {
      final response = await http.delete(
        Uri.parse('http://10.0.2.2:3000/api/${widget.entidad}/$id'),
      );
      if (response.statusCode == 200) {
        _cargarRegistros(); // Recargar los datosCargados después de eliminar
      } else {
        throw Exception('Error al eliminar registro');
      }
    } catch (e) {
      print('Error al eliminar registro: $e');
    }
  }

  Future<void> _modificarRegistro(
      String id, Map<String, String> registroModificado) async {
    try {
      final response = await http.put(
        Uri.parse('http://10.0.2.2:3000/api/${widget.entidad}/$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(registroModificado),
      );
      if (response.statusCode == 200) {
        _cargarRegistros(); // Recargar los datosCargados después de modificar
      } else {
        throw Exception('Error al modificar registro');
      }
    } catch (e) {
      print('Error al modificar registro: $e');
    }
  }

  Future<List<Map<String, String>>> fetchDatos(List<String> columnas) async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:3000/api/${widget.entidad}'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map<Map<String, String>>((registro) {
        // Construir el mapa dinámicamente usando las columnas
        return Map.fromEntries(columnas.map((columna) {
          return MapEntry(
            columna,
            registro[columna]?.toString() ?? '',
          );
        }));
      }).toList();
    } else {
      throw Exception('Error al cargar datos de la tabla ${widget.entidad}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tabla de ${widget.entidad}"),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Table(
                      border: TableBorder.all(),
                      children: [
                        TableRow(
                          children: [
                            ...datosCargados[0].keys.map((columnHeader) {
                              return TableCell(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    columnHeader,
                                    textAlign: TextAlign.center,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              );
                            }).toList(),
                            TableCell(
                              child: Text(
                                'Acciones',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        ...datosCargados.map((rowData) {
                          String id = rowData['id']!;
                          return TableRow(
                            children: [
                              ...rowData.values.map((cellData) {
                                return TableCell(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(cellData,
                                        textAlign: TextAlign.center),
                                  ),
                                );
                              }).toList(),
                              TableCell(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      icon:
                                          Icon(Icons.edit, color: Colors.blue),
                                      onPressed: () async {
                                        // Mapa que asocia cada entidad con su formulario correspondiente
                                        final formularios = {
                                          'Usuario': (rowData) =>
                                              FormularioAniadirUsuario(
                                                  usuario: rowData),
                                          'Autor': (rowData) =>
                                              FormularioAniadirAutor(
                                                  autor: rowData),
                                          'Prestamo': (rowData) =>
                                              FormularioAniadirPrestamo(
                                                  prestamo: rowData),
                                          'Libro': (rowData) =>
                                              FormularioAniadirLibro(
                                                  libro: rowData),

                                          // Agrega más entidades y formularios según sea necesario
                                        };

                                        // Verifica si la entidad tiene un formulario asociado
                                        if (formularios
                                            .containsKey(widget.entidad)) {
                                          final registroModificado =
                                              await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  formularios[widget.entidad]!(
                                                      rowData),
                                            ),
                                          );

                                          if (registroModificado != null) {
                                            _modificarRegistro(
                                                id, registroModificado);
                                          }
                                        } else {
                                          print(
                                              'No se encontró un formulario para la entidad ${widget.entidad}');
                                        }
                                      },
                                    ),
                                    IconButton(
                                      icon:
                                          Icon(Icons.delete, color: Colors.red),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: Text('Eliminar ${widget.entidad}'),
                                            content: Text(
                                                '¿Estás seguro de que quieres eliminar este registro?'),
                                            actions: [
                                              TextButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: Text('Cancelar'),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  _eliminarRegistro(id);
                                                },
                                                child: Text('Eliminar'),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    // Mapa que asocia cada entidad con su formulario correspondiente
                    final formularios = {
                      'Usuario': () => FormularioAniadirUsuario(),
                      'Autor': () => FormularioAniadirAutor(),
                      'Prestamo': () => FormularioAniadirPrestamo(),
                      'Libro': () => FormularioAniadirLibro(),
                      // Agrega más entidades y formularios según sea necesario
                    };

                    // Verifica si la entidad tiene un formulario asociado
                    if (formularios.containsKey(widget.entidad)) {
                      final nuevoRegistro = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => formularios[widget.entidad]!(),
                        ),
                      );

                      if (nuevoRegistro != null) {
                        _aniadirRegistro(nuevoRegistro);
                      }
                    } else {
                      print(
                          'No se encontró un formulario para la entidad ${widget.entidad}');
                    }
                  },
                  child: Text('Añadir ${widget.entidad}'),
                ),
              ],
            ),
    );
  }
}
