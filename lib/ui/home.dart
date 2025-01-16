import 'package:app_prueba/ui/tablaRegistros.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  final String _title;
  HomePage(this._title);

  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  Future<List<Map<String, String>>> fetchData(String entidad) async {
    final response = await http.get(Uri.parse('http://10.0.2.2:3000/$entidad'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map<Map<String, String>>((registro) {
        return {
          'id': registro['id'].toString(),
          ...registro, // Esto incluirá todas las claves del registro
        };
      }).toList();
    } else {
      throw Exception('Error al cargar $entidad');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestión Biblioteca'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 60),
            // Usuarios
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TablaRegistros(
                        entidad: "Usuario",
                      ),
                    ),
                  );
                },
                child: Text('Usuarios'),
              ),
            ),
            SizedBox(height: 20),
            // Libros
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TablaRegistros(
                        entidad: "Libro",
                      ),
                    ),
                  );
                },
                child: Text('Libros'),
              ),
            ),
            SizedBox(height: 20),
            // Prestaciones
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TablaRegistros(
                        entidad: "Prestamo",
                      ),
                    ),
                  );
                },
                child: Text('Prestaciones'),
              ),
            ),
            SizedBox(height: 20),
            // Autores
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TablaRegistros(
                        entidad: "Autor",
                      ),
                    ),
                  );
                },
                child: Text('Autores'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}