import 'package:flutter/material.dart';

class FormularioAniadirAutor extends StatefulWidget {
  final Map<String, String>? autor; // Usuario preexistente (opcional)

  FormularioAniadirAutor({this.autor});

  @override
  _FormularioAniadirAutorState createState() =>
      _FormularioAniadirAutorState();
}

class _FormularioAniadirAutorState extends State<FormularioAniadirAutor> {
  final _formKey = GlobalKey<FormState>();

  // Controladores de los campos del formulario
  late TextEditingController _nombreController;
  late TextEditingController _nacionalidadController;
  late TextEditingController _fechaNacimientoController;

  @override
  void initState() {
    super.initState();

    // Inicializamos los controladores con los datos del usuario, si existen
    _nombreController = TextEditingController(
        text: widget.autor?['nombre_apellido'] ?? '');
    _nacionalidadController =
        TextEditingController(text: widget.autor?['nacionalidad'] ?? '');
    _fechaNacimientoController =
        TextEditingController(text: widget.autor?['fecha_nacimiento'] ?? '');
  }

  @override
  void dispose() {
    // Liberamos los controladores al cerrar la ventana
    _nombreController.dispose();
    _nacionalidadController.dispose();
    _fechaNacimientoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.autor != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? "Modificar Autor" : "Añadir Autor"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Campo Nombre y Apellidos
              TextFormField(
                controller: _nombreController,
                decoration: InputDecoration(labelText: 'Nombre y Apellidos'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el nombre y los apellidos';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // Campo nacionalidad
              TextFormField(
                controller: _nacionalidadController,
                decoration: InputDecoration(labelText: 'Nacionalidad'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la nacionalidad';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // Campo Fecha de Nacimiento
              TextFormField(
                controller: _fechaNacimientoController,
                decoration: InputDecoration(labelText: 'Fecha de Nacimiento'),
                keyboardType: TextInputType.datetime,
                onTap: () async {
                  FocusScope.of(context).requestFocus(FocusNode());
                  DateTime? selectedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (selectedDate != null) {
                    setState(() {
                      _fechaNacimientoController.text =
                          "${selectedDate.toLocal()}".split(' ')[0];
                    });
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la fecha de nacimiento';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              

              // Botón Guardar
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    // Devolvemos los datos del formulario
                    Navigator.pop(context, {
                      'nombre_apellido': _nombreController.text,
                      'nacionalidad': _nacionalidadController.text,
                      'fecha_nacimiento': _fechaNacimientoController.text,
                    });
                  }
                },
                child: Text(isEditing ? 'Guardar Cambios' : 'Añadir Autor'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
