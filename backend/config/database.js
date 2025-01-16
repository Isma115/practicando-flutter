const { Sequelize } = require('sequelize');

const sequelize = new Sequelize('app_prueba_datos', 'root', '398t3*^¿219', {
    host: 'localhost',
    dialect: 'mysql',
    define: {
        timestamps: false
    }
});

module.exports = sequelize;
