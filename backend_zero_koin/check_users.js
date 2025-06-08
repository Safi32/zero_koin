// Script to check users in MongoDB
const mongoose = require('mongoose');
require('dotenv').config();

const MONGODB_URI = process.env.MONGODB_URI || 'mongodb+srv://admin:root@cluster0.ye7aj3h.mongodb.net/zero_koin';

const userSchema = new mongoose.Schema({
  firebaseUid: {
    type: String,
    unique: true,
    sparse: true
  },
  name: {
    type: String,
    default: null
  },
  email: {
    type: String,
    default: null
  },
  inviteCode: {
    type: String,
    unique: true,
    required: true
  },
  referredBy: {
    type: String,
    default: null
  },
  recentAmount: {
    type: Number,
    default: 0
  },
  createdAt: {
    type: Date,
    default: Date.now
  }
});

const User = mongoose.model('User', userSchema);

const checkUsers = async () => {
  try {
    await mongoose.connect(MONGODB_URI);
    console.log('Connected to MongoDB');
    
    const users = await User.find({});
    console.log(`\nFound ${users.length} users in database:`);
    
    users.forEach((user, index) => {
      console.log(`\n--- User ${index + 1} ---`);
      console.log(`Firebase UID: ${user.firebaseUid || 'Not set'}`);
      console.log(`Name: ${user.name || 'Not set'}`);
      console.log(`Email: ${user.email || 'Not set'}`);
      console.log(`Invite Code: ${user.inviteCode}`);
      console.log(`Recent Amount: ${user.recentAmount}`);
      console.log(`Created: ${user.createdAt}`);
    });
    
    // Check for Firebase users specifically
    const firebaseUsers = await User.find({ firebaseUid: { $ne: null } });
    console.log(`\n🔥 Firebase users: ${firebaseUsers.length}`);
    
    await mongoose.disconnect();
    console.log('\nDisconnected from MongoDB');
    
  } catch (error) {
    console.error('Error:', error);
  }
};

checkUsers();
