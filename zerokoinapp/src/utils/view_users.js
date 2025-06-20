// view_users.js
// const dotenv = require('dotenv').config(); // Remove dotenv
const mongoose = require('mongoose');
const connectDB = require('../config/database');
const User = require('../models/User');

const MONGODB_URI = 'mongodb+srv://mstorsulam786:1nkSX6KEOBmdx0ox@cluster0.frhaken.mongodb.net/zero_koin';

(async () => {
  // Directly connect using mongoose
  try {
    await mongoose.connect(MONGODB_URI, {
      useNewUrlParser: true,
      useUnifiedTopology: true,
    });
    console.log('MongoDB Connected');
    const users = await User.find();
    if (users.length === 0) {
      console.log('No users found in the database.');
    } else {
      console.log(`Found ${users.length} user(s):\n`);
      users.forEach((user, idx) => {
        console.log(`User #${idx + 1}`);
        console.log('-------------------------');
        console.log(`ID: ${user._id}`);
        console.log(`Name: ${user.name}`);
        console.log(`Email: ${user.email}`);
        console.log(`Invite Code: ${user.inviteCode}`);
        console.log(`Referred By: ${user.referredBy}`);
        console.log(`Role: ${user.role}`);
        console.log(`Balance: ${user.balance}`);
        console.log(`Calculator Usage: ${user.calculatorUsage}`);
        console.log(`Created At: ${user.createdAt}`);
        console.log('-------------------------\n');
      });
    }
  } catch (err) {
    console.error('Error fetching users:', err);
  } finally {
    process.exit(0);
  }
})(); 