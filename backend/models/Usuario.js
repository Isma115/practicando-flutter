const { DataTypes } = require('sequelize');

module.exports = (sequelize) => {
  return sequelize.define('Usuario', {
    id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
    nombre_apellido: { type: DataTypes.STRING, allowNull: false },
    email: { type: DataTypes.STRING, allowNull: false, unique: true },
    fecha_registro: { type: DataTypes.DATEONLY, allowNull: false },
    telefono: { type: DataTypes.STRING, allowNull: false },
  }, { tableName: 'usuarios', timestamps: false });
};
