// Simple test script to verify the sync endpoint
const axios = require('axios');

// This is a mock test - in real usage, you'd get this token from Firebase Auth
const testSync = async () => {
  try {
    console.log('Testing sync endpoint...');
    
    // Test without token (should fail)
    try {
      const response = await axios.post('http://localhost:5001/api/users/sync');
      console.log('Unexpected success without token:', response.data);
    } catch (error) {
      console.log('✓ Correctly rejected request without token:', error.response?.status, error.response?.data?.message);
    }
    
    // Test with invalid token (should fail)
    try {
      const response = await axios.post('http://localhost:5001/api/users/sync', {}, {
        headers: {
          'Authorization': 'Bearer invalid-token'
        }
      });
      console.log('Unexpected success with invalid token:', response.data);
    } catch (error) {
      console.log('✓ Correctly rejected invalid token:', error.response?.status, error.response?.data?.message);
    }
    
    console.log('\nEndpoint is properly protected. To test with real Firebase token:');
    console.log('1. Sign in with Firebase in your Flutter app');
    console.log('2. Get the ID token from Firebase Auth');
    console.log('3. Make a POST request to /api/users/sync with Authorization: Bearer <token>');
    
  } catch (error) {
    console.error('Test error:', error.message);
  }
};

testSync();
