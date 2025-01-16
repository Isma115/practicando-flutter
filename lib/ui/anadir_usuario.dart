import 'package:flutter/material.dart';

class FormularioAniadirUsuario extends StatefulWidget {
  final Map<String, String>? usuario; // Usuario preexistente (opcional)

  FormularioAniadirUsuario({this.usuario});

  @override
  _FormularioAniadirUsuarioState createState() =>
      _FormularioAniadirUsuarioState();
}

class _FormularioAniadirUsuarioState extends State<FormularioAniadirUsuario> {
  final _formKey = GlobalKey<FormState>();

  // Controladores de los campos del formulario
  late TextEditingController _nombreController;
  late TextEditingController _emailController;
  late TextEditingController _fechaController;
  late TextEditingController _telefonoController;

  @override
  void initState() {
    super.initState();

    // Inicializamos los controladores con los datos del usuario, si existen
    _nombreController = TextEditingController(
        text: widget.usuario?['nombre_apellido'] ?? '');
    _emailController =
        TextEditingController(text: widget.usuario?['email'] ?? '');
    _fechaController =
        TextEditingController(text: widget.usuario?['fecha_registro'] ?? '');
    _telefonoController =
        TextEditingController(text: widget.usuario?['telefono'] ?? '');
  }

  @override
  void dispose() {
    // Liberamos los controladores al cerrar la ventana
    _nombreController.dispose();
    _emailController.dispose();
    _fechaController.dispose();
    _telefonoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.usuario != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? "Modificar Usuario" : "Añadir Usuario"),
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

              // Campo Email
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un correo electrónico';
                  }
                  if (!RegExp(r"^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      .hasMatch(value)) {
                    return 'Por favor ingrese un correo electrónico válido';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // Campo Fecha de Registro
              TextFormField(
                controller: _fechaController,
                decoration: InputDecoration(labelText: 'Fecha de Registro'),
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
                      _fechaController.text =
                          "${selectedDate.toLocal()}".split(' ')[0];
                    });
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la fecha de registro';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // Campo Teléfono
              TextFormField(
                controller: _telefonoController,
                decoration: InputDecoration(labelText: 'Teléfono'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un número de teléfono';
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
                      'nombre_apellido': _nombreController.text,
                      'email': _emailController.text,
                      'fecha_registro': _fechaController.text,
                      'telefono': _telefonoController.text,
                    });
                  }
                },
                child: Text(isEditing ? 'Guardar Cambios' : 'Añadir Usuario'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
