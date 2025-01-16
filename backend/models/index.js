const { Sequelize } = require('sequelize');
const sequelize = require('../config/database'); // Conexión configurada 

// Importar modelos
const defineUsuario = require('./Usuario');
const defineAutor = require('./Autor');
const defineLibro = require('./Libro');
const definePrestamo = require('./Prestamo');

// Inicializar modelos
const Usuario = defineUsuario(sequelize);
const Autor = defineAutor(sequelize);
const Libro = defineLibro(sequelize);
const Prestamo = definePrestamo(sequelize);

// Configurar relaciones
Usuario.hasMany(Prestamo, { foreignKey: 'id_usuario' });
Prestamo.belongsTo(Usuario, { foreignKey: 'id_usuario' });

Autor.hasMany(Libro, { foreignKey: 'id_autor' });
Libro.belongsTo(Autor, { foreignKey: 'id_autor' });

Libro.hasMany(Prestamo, { foreignKey: 'id_libro' });
Prestamo.belongsTo(Libro, { foreignKey: 'id_libro' });

// Exportar modelos e instancia de Sequelize
module.exports = {
  Usuario,
  Autor,
  Libro,
  Prestamo,
  sequelize,
};
