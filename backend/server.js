const express = require('express');
const { sequelize } = require('./models'); // Importa la instancia de Sequelize
const genericRoute = require('./routes/genericRoute');

const app = express();
const cors = require('cors');


app.use(express.json());
app.use(cors());
// Configurar rutas
app.use('/api', genericRoute);


// Sincronizar la base de datos
sequelize.sync()
  .then(() => {
    console.log('Base de datos sincronizada');
    app.listen(3000, () => console.log('Servidor corriendo en http://localhost:3000'));
  })
  .catch(err => {
    console.error('Error al sincronizar la base de datos:', err);
  });
