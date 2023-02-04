const express = require("express");
const app = express();
const path = require("path");
const http = require("http");
const cors = require("cors");
const cookieParser = require("cookie-parser");
const bodyParser = require("body-parser");
const server = http.createServer(app);

// PATH AND PORT //
require("dotenv").config();
require("./src/db/conn");

const port = process.env.PORT;

app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(cookieParser());

// ROUTES //
const userRoutes = require("./src/routers/user.route");
app.use("/user",userRoutes);


// SERVER LISTEN //
server.listen(port, () => {
  console.log(`Your Port ${port} Is Running Successfully.`);
});
