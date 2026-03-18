/**
*Author: 	DIEGO CASALLAS
*Date:		01/01/2026  
*Description:	Application setup for the API - NODEJS
**/
import express from 'express';
import cors from 'cors';
import userRoutes from '../routes/user.routes.js';
import userStatusRoutes from '../routes/userStatus.routes.js';
import roleRoutes from '../routes/role.routes.js';
import userApiRoutes from '../routes/apiUser.routes.js';
import profileRoutes from '../routes/profile.routes.js';
import moduleRoutes from '../routes/module.routes.js';
import roleModuleRoutes from '../routes/roleModule.routes.js';

const app = express();
const NAME_API = '/api_v1';
app.use(cors());

app.use(express.json());


app.use(NAME_API, userRoutes);
app.use(NAME_API, userStatusRoutes);
app.use(NAME_API, roleRoutes);
app.use(NAME_API, userApiRoutes);
app.use(NAME_API, profileRoutes);
app.use(NAME_API, moduleRoutes);
app.use(NAME_API, roleModuleRoutes);

app.use((req, res, next) => {
  res.status(404).json({
    message: 'Endpoint losses 404, not found'
  });
});

export default app;