const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
  // Firebase user data
  firebaseUid: {
    type: String,
    unique: true,
    sparse: true // Allows null values while maintaining uniqueness for non-null values
  },
  name: {
    type: String,
    default: null
  },
  email: {
    type: String,
    default: null
  },
  // Existing fields
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

module.exports = mongoose.model('User', userSchema);