const mongoose = require("mongoose");

// CONNECTION TO DATABASE //
mongoose.set('strictQuery', true);
mongoose
  .connect(process.env.MONGODB_URL)
  .then(() => {
    console.log("Database Connected Successfully.");
  })
  .catch((err) => {
    console.log("ERROR => ", err);
  });
