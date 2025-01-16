const { DataTypes } = require('sequelize');

module.exports = (sequelize) => {
  return sequelize.define('Libro', {
    id: { type: DataTypes.INTEGER, primaryKey: true, autoIncrement: true },
    titulo: { type: DataTypes.STRING, allowNull: false },
    id_autor: { type: DataTypes.INTEGER, references: { model: 'autores', key: 'id' }, allowNull: true },
    anio_publicacion: { type: DataTypes.INTEGER },
    genero: { type: DataTypes.STRING },
    disponible: { type: DataTypes.BOOLEAN, defaultValue: true },
  }, { tableName: 'libros', timestamps: false });
};
