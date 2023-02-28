import express from 'express';
import dotenv from 'dotenv';
import cors from 'cors';
import bodyParser from 'body-parser';
import Response from './domain/response.js';
import logger from "./log/logger.js";
import HttpStatus from './controller/user.contoller.js';
import userRoutes from './routes/user.route.js';
// import pool from "./config/mysql.config.js";
import mysql from 'mysql';



const connection = mysql.createConnection({
  host: process.env.DB_HOST,
  port: process.env.DB_PORT,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
  // connectionLimit: process.env.DB_CONNECTION_LIMIT
});

connection.connect();
if (connection) {
  console.log('DB is connected');
}

connection.query('SELECT 1 + 1 AS solution', (err, rows, fields) => {
  if (err) throw err;

  console.log('The solution is: ', rows[0].solution);
});

connection.end();

dotenv.config();
const app = express();
const port = process.env.PORT || 3000;

app.use(cors({ origin: '*' }));
app.use(bodyParser.json());


app.use('/users', userRoutes);
app.get('/', function (req,res) {
    res.send(new Response(HttpStatus.OK.code, HttpStatus.status, 'User v1.0' ))
    console.log(process.env);
});

app.all('*', (req, res) => res.status(HttpStatus.NOT_FOUND.code)
    .send(new Response(HttpStatus.OK.code, HttpStatus.status, 'Route does not exist on the server' )));

app.listen(port, () => logger.info(`listening on port ${port}`))
