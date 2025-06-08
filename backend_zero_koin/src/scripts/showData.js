const mongoose = require('mongoose');
require('dotenv').config();

const User = require('../models/User');
const Token = require('../models/Token');

const MONGODB_URI = process.env.MONGODB_URI || 'mongodb+srv://admin:root@cluster0.ye7aj3h.mongodb.net/zero_koin';

async function showData() {
  try {
    await mongoose.connect(MONGODB_URI);
    console.log('Connected to MongoDB successfully');

    // Get all users
    const users = await User.find({});
    console.log('\n=== Users ===');
    console.log(JSON.stringify(users, null, 2));

    // Get all tokens
    const tokens = await Token.find({});
    console.log('\n=== Tokens ===');
    console.log(JSON.stringify(tokens, null, 2));

  } catch (error) {
    console.error('Error:', error);
  } finally {
    await mongoose.disconnect();
    console.log('\nDisconnected from MongoDB');
  }
}

showData(); 