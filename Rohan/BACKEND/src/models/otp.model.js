const mongoose = require("mongoose");

const otpSchema = new mongoose.Schema({
  user_id: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "Otp",
  },
  otp_data: {
    type: Array,
  },
});

module.exports = mongoose.model("Otp", otpSchema);
