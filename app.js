const express = require("express");
const app = express();

const postRouter = require("./routes/post");
const authRouter = require("./routes/auth");
const abonoRouter= require("./routes/abonos");

const PORT = 3000;

app.use(express.urlencoded({extended: false}));
app.use(express.json());
//Routes
const API_V1 = '/api/v1';
app.use(`${API_V1}/post`, postRouter);
app.use(`${API_V1}/auth`, authRouter);
app.use(`${API_V1}/abonos`, abonoRouter);

app.listen(PORT, () => {
	console.log('Connect to server 🖥️');
})
