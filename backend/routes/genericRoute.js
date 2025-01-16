const express = require('express');
const router = express.Router();
const { getEntity, createEntity, updateEntity, deleteEntity } = require('../controllers/genericController');

// Rutas para obtener, crear, actualizar y eliminar entidades
router.get('/:entity', getEntity); // Obtener todas las entidades (usuarios, libros, etc.)
router.post('/:entity', createEntity); // Crear una nueva entidad
router.put('/:entity/:id', updateEntity); // Actualizar una entidad por ID
router.delete('/:entity/:id', deleteEntity); // Eliminar una entidad por ID

module.exports = router;
