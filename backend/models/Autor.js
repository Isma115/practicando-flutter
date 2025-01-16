const { DataTypes } = require('sequelize');

module.exports = (sequelize) => {
  return sequelize.define('Autor', {
    id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
    nombre_apellido: { type: DataTypes.STRING, allowNull: false },
    nacionalidad: { type: DataTypes.STRING, allowNull: false },
    fecha_nacimiento: { type: DataTypes.DATEONLY },
  }, { tableName: 'autores', timestamps: false });
};
