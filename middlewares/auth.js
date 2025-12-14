const jwt = require('jsonwebtoken');

module.exports = (req, res, next) => {
    // 1. Extraer el token del header
    const authHeader = req.headers['authorization'];
    const token = authHeader && authHeader.split(' ')[1];

    if (!token) {
        return res.status(401).json({ error: 'Acceso denegado. No hay token.' });
    }

    try {
        // 2. Verificar si el token es válido y no ha expirado
        const decoded = jwt.verify(token, process.env.JWT_SECRET);

        // 3. REINICIO DEL TOKEN: Generamos uno nuevo con los mismos datos
        // pero con una nueva fecha de expiración (1 hora desde ahora)
        const newToken = jwt.sign(
            { 
                id_user: decoded.id_user, 
                nombreUser: decoded.nombreUser, 
                email: decoded.email 
            },
            process.env.JWT_SECRET,
            { expiresIn: '1h' }
        );

        // 4. Devolver el nuevo token al cliente en el header
        res.setHeader('Authorization', `Bearer ${newToken}`);
        // Importante para que Flutter pueda leer este header personalizado
        res.setHeader('Access-Control-Expose-Headers', 'Authorization');

        // Guardamos los datos del usuario en el objeto request para usarlo en las rutas
        req.user = decoded;
        
        next(); // Continuar a la ruta (recetas o comentarios)
    } catch (error) {
        return res.status(403).json({ error: 'Token inválido o expirado.' });
    }
};