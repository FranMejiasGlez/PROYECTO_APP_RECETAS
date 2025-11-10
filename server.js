const express = require('express');
const app = express();
app.use(express.json());

app.use('/api/movies', require('./routes/moviesRoutes.js'));
app.use('/api/recetas', require('./routes/recetasRoutes.js'));

const { connect } = require('./db');

connect().then(() => {
    app.listen(3000, () => {
        console.log('Server listening on port 3000');
    });
}).catch(console.error);
