import 'package:flutter/material.dart';

class FormularioAniadirPrestamo extends StatefulWidget {
  final Map<String, String>? prestamo; // Préstamo preexistente (opcional)

  FormularioAniadirPrestamo({this.prestamo});

  @override
  _FormularioAniadirPrestamoState createState() =>
      _FormularioAniadirPrestamoState();
}

class _FormularioAniadirPrestamoState extends State<FormularioAniadirPrestamo> {
  final _formKey = GlobalKey<FormState>();

  // Controladores de los campos del formulario
  late TextEditingController _idUsuarioController;
  late TextEditingController _idLibroController;
  late TextEditingController _fechaPrestamoController;
  late TextEditingController _fechaDevolucionController;
  late TextEditingController _fechaDevolucionRealController;
  late String _estado;

  @override
  void initState() {
    super.initState();

    // Inicializamos los controladores con los datos del préstamo, si existen
    _idUsuarioController =
        TextEditingController(text: widget.prestamo?['id_usuario'] ?? '');
    _idLibroController =
        TextEditingController(text: widget.prestamo?['id_libro'] ?? '');
    _fechaPrestamoController =
        TextEditingController(text: widget.prestamo?['fecha_prestamo'] ?? '');
    _fechaDevolucionController =
        TextEditingController(text: widget.prestamo?['fecha_devolucion'] ?? '');
    _fechaDevolucionRealController = TextEditingController(
        text: widget.prestamo?['fecha_devolucion_real'] ?? '');
    _estado = widget.prestamo?['estado'] ?? 'pendiente';
  }

  @override
  void dispose() {
    // Liberamos los controladores al cerrar la ventana
    _idUsuarioController.dispose();
    _idLibroController.dispose();
    _fechaPrestamoController.dispose();
    _fechaDevolucionController.dispose();
    _fechaDevolucionRealController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.prestamo != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? "Modificar Préstamo" : "Añadir Préstamo"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Campo ID Usuario
              TextFormField(
                controller: _idUsuarioController,
                decoration: InputDecoration(labelText: 'ID Usuario'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el ID del usuario';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // Campo ID Libro
              TextFormField(
                controller: _idLibroController,
                decoration: InputDecoration(labelText: 'ID Libro'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el ID del libro';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // Campo Fecha de Préstamo
              TextFormField(
                controller: _fechaPrestamoController,
                decoration: InputDecoration(labelText: 'Fecha de Préstamo'),
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
                      _fechaPrestamoController.text =
                          "${selectedDate.toLocal()}".split(' ')[0];
                    });
                  }
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la fecha de préstamo';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // Campo Fecha de Devolución
              TextFormField(
                controller: _fechaDevolucionController,
                decoration: InputDecoration(labelText: 'Fecha de Devolución'),
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
                      _fechaDevolucionController.text =
                          "${selectedDate.toLocal()}".split(' ')[0];
                    });
                  }
                },
              ),
              SizedBox(height: 20),

              // Campo Fecha de Devolución Real
              TextFormField(
                controller: _fechaDevolucionRealController,
                decoration: InputDecoration(labelText: 'Fecha de Devolución Real'),
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
                      _fechaDevolucionRealController.text =
                          "${selectedDate.toLocal()}".split(' ')[0];
                    });
                  }
                },
              ),
              SizedBox(height: 20),

              // Campo Estado
              DropdownButtonFormField<String>(
                value: _estado,
                decoration: InputDecoration(labelText: 'Estado'),
                items: ['pendiente', 'devuelto', 'retrasado']
                    .map((estado) => DropdownMenuItem(
                          value: estado,
                          child: Text(estado),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _estado = value!;
                  });
                },
              ),
              SizedBox(height: 20),

              // Botón Guardar
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    // Devolvemos los datos del formulario
                    Navigator.pop(context, {
                      'id_usuario': _idUsuarioController.text,
                      'id_libro': _idLibroController.text,
                      'fecha_prestamo': _fechaPrestamoController.text,
                      'fecha_devolucion': _fechaDevolucionController.text,
                      'fecha_devolucion_real': _fechaDevolucionRealController.text,
                      'estado': _estado,
                    });
                  }
                },
                child: Text(isEditing ? 'Guardar Cambios' : 'Añadir Préstamo'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
