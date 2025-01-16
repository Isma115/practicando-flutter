import 'package:flutter/material.dart';

class FormularioAniadirLibro extends StatefulWidget {
  final Map<String, String>? libro; // Libro preexistente (opcional)

  FormularioAniadirLibro({this.libro});

  @override
  _FormularioAniadirLibroState createState() => _FormularioAniadirLibroState();
}

class _FormularioAniadirLibroState extends State<FormularioAniadirLibro> {
  final _formKey = GlobalKey<FormState>();

  // Controladores de los campos del formulario
  late TextEditingController _tituloController;
  late TextEditingController _autorController;
  late TextEditingController _anioPublicacionController;
  late TextEditingController _generoController;

  @override
  void initState() {
    super.initState();

    // Inicializamos los controladores con los datos del libro, si existen
    _tituloController =
        TextEditingController(text: widget.libro?['titulo'] ?? '');
    _autorController =
        TextEditingController(text: widget.libro?['id_autor'] ?? '');
    _anioPublicacionController =
        TextEditingController(text: widget.libro?['anio_publicacion'] ?? '');
    _generoController =
        TextEditingController(text: widget.libro?['genero'] ?? '');
  }

  @override
  void dispose() {
    // Liberamos los controladores al cerrar la ventana
    _tituloController.dispose();
    _autorController.dispose();
    _anioPublicacionController.dispose();
    _generoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.libro != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? "Modificar Libro" : "Añadir Libro"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Campo Título
              TextFormField(
                controller: _tituloController,
                decoration: InputDecoration(labelText: 'Título'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el título del libro';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // Campo Autor
              TextFormField(
                controller: _autorController,
                decoration: InputDecoration(labelText: 'ID Autor'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el ID del autor';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Por favor ingrese un ID válido';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // Campo Año de Publicación
              TextFormField(
                controller: _anioPublicacionController,
                decoration: InputDecoration(labelText: 'Año de Publicación'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el año de publicación';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Por favor ingrese un año válido';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // Campo Género
              TextFormField(
                controller: _generoController,
                decoration: InputDecoration(labelText: 'Género'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el género del libro';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),

              // Botón Guardar
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    // Devolvemos los datos del formulario
                    Navigator.pop(context, {
                      'titulo': _tituloController.text,
                      'id_autor': _autorController.text,
                      'anio_publicacion': _anioPublicacionController.text,
                      'genero': _generoController.text,
                    });
                  }
                },
                child: Text(isEditing ? 'Guardar Cambios' : 'Añadir Libro'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
