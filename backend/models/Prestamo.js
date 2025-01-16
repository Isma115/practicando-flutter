const { DataTypes } = require('sequelize');

module.exports = (sequelize) => {
  return sequelize.define('Prestamo', {
    id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
    id_usuario: { type: DataTypes.INTEGER, references: { model: 'usuarios', key: 'id' }, allowNull: false },
    id_libro: { type: DataTypes.INTEGER, references: { model: 'libros', key: 'id' }, allowNull: false },
    fecha_prestamo: { type: DataTypes.DATEONLY, allowNull: false },
    fecha_devolucion: { type: DataTypes.DATEONLY },
    fecha_devolucion_real: { type: DataTypes.DATEONLY },
    estado: { type: DataTypes.ENUM('pendiente', 'devuelto', 'retrasado'), defaultValue: 'pendiente' },
  }, { tableName: 'prestamos', timestamps: false });
};
