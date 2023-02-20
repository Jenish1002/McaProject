const mongoose = require("mongoose");
const ObjectId = mongoose.Types.ObjectId;
const status = require("http-status");
const nodemailer = require("nodemailer");
const smtpTransport = require("nodemailer-smtp-transport");
const APIResponse = require("../helpers/APIResponse");
const validator = require("validator");
const bcrypt = require("bcryptjs");
const userData = require("../models/user.model");
const otpData = require("../models/otp.model");
const date = require("date-and-time");

exports.Register = async (req, res) => {
  try {
    const data = new userData({
      name: req.body.name,
      email: req.body.email,
      gender: req.body.gender,
      phone: req.body.phone,
      username: req.body.username,
      password: req.body.password,
    });
    email = req.body.email;
    username = req.body.username;

    if (!validator.isEmail(req.body.email)) {
      return res
        .status(400)
        .json(
          new APIResponse("Please Give Email In Propewr Formate.", true, 400)
        );
    } else {
      userData.findOne({ email: email }).then((useremail) => {
        if (useremail) {
          return res
            .status(400)
            .json(new APIResponse("Email Is Already Save", true, 400));
        } else {
          if (username) {
            userData.findOne({ username: username }).then(async (usern) => {
              if (usern) {
                return res
                  .status(400)
                  .json(
                    new APIResponse("Username Is Already Taken", true, 400)
                  );
              } else {
                await data.save(async function (err, result) {
                  if (err) {
                    return res
                      .status(404)
                      .json(
                        new APIResponse(
                          "User Data Is Not Save.",
                          true,
                          404,
                          error.message
                        )
                      );
                  } else {
                    P_user_id = result._id;
                    const otp_data = new otpData({
                      user_id: P_user_id,
                    });
                    await otp_data.save(async function (err, result) {
                      if (err) {
                        const del_data = userData.findByIdAndDelete({
                          P_user_id,
                        });
                        return res
                          .status(404)
                          .json(
                            new APIResponse(
                              "User Data Is Not Save.",
                              true,
                              404,
                              error.message
                            )
                          );
                      } else {
                        return res
                          .status(200)
                          .json(
                            new APIResponse(
                              "User Register Successfully",
                              false,
                              200,
                              data
                            )
                          );
                      }
                    });
                  }
                });
              }
            });
          }
        }
      });
    }
  } catch (error) {
    return res
      .status(404)
      .json(
        new APIResponse("User Data Is Not Save.", true, 404, error.message)
      );
  }
};

exports.login = async (req, res) => {
  try {
    email = req.body.email;
    password = req.body.password;

    const data = await userData.findOne({ email: email });
    const match = await bcrypt.compare(password, data.password);

    if (!data.tokens[0]) {
      const token = await data.generate();
    }

    if (match && email === data.email) {
      return res.status(200).json({
        message: "User Login Successfully",
        status: 200,
        id: data._id,
        token: data.tokens[0].token,
      });
    } else {
      return res
        .status(400)
        .json(new APIResponse("Enter Valid Username Or Password", true, 400));
    }
  } catch (error) {
    console.log(error);
    return res
      .status(404)
      .json(new APIResponse("User Not Login.", true, 404, error.message));
  }
};

exports.sendEmail = async (req, res) => {
  try {
    email = req.body.email;
    const otp_user = await userData.findOne({ email });
    const otp_user_id = otp_user._id;

    const now = new Date();
    const createDate = date.format(now, "YYYY-MM-DD HH:mm:ss");

    var otp = 9999;

    var query = { user_id: ObjectId(otp_user_id) };
    var updates = {
      $set: { otp_data: [] },
    };
    var order = { new: true };

    const Emp_data = await otpData.updateOne(query, updates, order);

    var query1 = { user_id: ObjectId(otp_user_id) };
    var updates1 = {
      $push: {
        otp_data: { [createDate]: otp },
      },
    };
    var order1 = { new: true };

    const data = await otpData.updateOne(query1, updates1, order1);

    const transport = nodemailer.createTransport(
      smtpTransport({
        service: "gmail",
        auth: {
          // user: process.env.USER_EMAIL, // please enter your email address.//
          // pass: process.env.EMAIL_PASS, // please enter your email address password.//
          user: "testabctest47@gmail.com",
          pass: "wcdyytsexohrgfdi",
        },
      })
    );

    const mailoption = {
      // from: process.env.USER_EMAIL, // please enter your email address.//
      from: "testabctest47@gmail.com",
      to: req.body.email,
      subject: "send otp in your mail",
      text: `Your otp is :- ${otp}, please don't give other person for your safety.`,
    };

    transport.sendMail(mailoption);
    return res
      .status(200)
      .json(new APIResponse("OTP Send Successfully.", false, 200));
  } catch (error) {
    console.log(error);
    return res
      .status(404)
      .json(new APIResponse("OTP Not Send.", true, 404, error.message));
  }
};

exports.matchOTP = async (req, res) => {
  try {
    const user_id = req.body.user_id;
    const u_otp = req.body.u_otp;

    const data = await otpData.findOne({ user_id });

    if (Object.values(data.otp_data[0])[0] === +u_otp) {
      return res
        .status(200)
        .json(new APIResponse("OTP Match Successfully.", false, 200));
    } else {
      return res.status(400).json(new APIResponse("OTP Not Match.", true, 400));
    }
  } catch (error) {
    console.log(error);
    return res
      .status(404)
      .json(
        new APIResponse(
          "Some Error Occur In OTP Match.",
          true,
          404,
          error.message
        )
      );
  }
};

exports.passChange = async (req, res) => {
  try {
    const user_id = req.body.user_id;
    const password = req.body.password;
    const conPassword = req.body.conPassword;

    if (password === conPassword) {
      req.body.password = await bcrypt.hash(password, 10);
      const data = await userData.findByIdAndUpdate(
        { _id: user_id },
        req.body,
        { new: true }
      );
      return res
        .status(200)
        .json(new APIResponse("Password Update Successfully.", false, 200));
    } else {
      return res
        .status(400)
        .json(
          new APIResponse(
            "Password And Confirm Password Doesn't Match.",
            true,
            400
          )
        );
    }
  } catch (error) {
    return res
      .status(404)
      .json(
        new APIResponse(
          "Some Error Occur In OTP Match.",
          true,
          404,
          error.message
        )
      );
  }
};


