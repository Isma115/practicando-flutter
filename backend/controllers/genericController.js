const { Usuario, Libro, Prestamo, Autor } = require('../models'); // Importamos todos los modelos

// Función para obtener datos de una entidad
const getEntity = async (req, res) => {
    const { entity } = req.params; // Nombre de la entidad (Usuario, Libro, etc.)
    try {
        let data;
        console.log("seleccionando entidad");
        switch (entity) {
            case 'Usuario':
                data = await Usuario.findAll();
                break;
            case 'Libro':
                data = await Libro.findAll();
                break;
            case 'Prestamo':
                data = await Prestamo.findAll();
                break;
            case 'Autor':
                data = await Autor.findAll();
                break;
            default:
                return res.status(400).json({ error: 'Entidad no válida' });
        }
        res.json(data);
    } catch (error) {
        console.log(error)
        res.status(500).json({ error: 'Error al obtener datos' });
    }
};

// Función para crear datos de una entidad
const createEntity = async (req, res) => {
    const { entity } = req.params;
    const data = req.body;
    console.log(data);
    try {
        let newEntity;
        switch (entity) {
            case 'Usuario':
                newEntity = await Usuario.create(data);
                break;
            case 'Libro':
                newEntity = await Libro.create(data);
                break;
            case 'Prestamo':
                newEntity = await Prestamo.create(data);
                break;
            case 'Autor':
                newEntity = await Autor.create(data);
                break;
            default:
                return res.status(400).json({ error: 'Entidad no válida' });
        }
        res.json(newEntity);
    } catch (error) {
        console.log(error);
        res.status(400).json({ error: 'Error al crear datos' });
    }
};

// Función para actualizar datos de una entidad
const updateEntity = async (req, res) => {
    const { entity, id } = req.params;
    const data = req.body;
    console.log("intentando actualizar")
    try {
        let entityToUpdate;
        switch (entity) {
            case 'Usuario':
                entityToUpdate = await Usuario.findByPk(id);
                break;
            case 'Libro':
                entityToUpdate = await Libro.findByPk(id);
                break;
            case 'Prestamo':
                entityToUpdate = await Prestamo.findByPk(id);
                break;
            case 'Autor':
                entityToUpdate = await Autor.findByPk(id);
                break;
            default:
                return res.status(400).json({ error: 'Entidad no válida' });
        }

        if (entityToUpdate) {         
            await entityToUpdate.update(data);
            res.json(entityToUpdate);
        } else {
            res.status(404).json({ error: 'Entidad no encontrada' });
        }
    } catch (error) {
        res.status(400).json({ error: 'Error al actualizar datos' });
    }
};

// Función para eliminar datos de una entidad
const deleteEntity = async (req, res) => {
    const { entity, id } = req.params;

    try {
        let entityToDelete;
        switch (entity) {
            case 'Usuario':
                entityToDelete = await Usuario.findByPk(id);
                break;
            case 'Libro':
                entityToDelete = await Libro.findByPk(id);
                break;
            case 'Prestamo':
                entityToDelete = await Prestamo.findByPk(id);
                break;
            case 'Autor':
                entityToDelete = await Autor.findByPk(id);
                break;
            default:
                return res.status(400).json({ error: 'Entidad no válida' });
        }

        if (entityToDelete) {
            await entityToDelete.destroy();
            res.json({ message: 'Entidad eliminada' });
        } else {
            res.status(404).json({ error: 'Entidad no encontrada' });
        }
    } catch (error) {
        res.status(400).json({ error: 'Error al eliminar datos' });
    }
};

module.exports = { getEntity, createEntity, updateEntity, deleteEntity };
