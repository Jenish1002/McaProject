const router = require('express').Router();
const userController = require("../controllers/user.controller");

router.post('/Register', userController.Register);
router.post('/Login', userController.login);
router.post("/sendEmail", userController.sendEmail);
router.post("/matchOTP",userController.matchOTP);
router.post("/passChange",userController.passChange);

module.exports = router;