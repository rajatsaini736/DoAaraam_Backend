const mongoose = require('mongoose');

/* User Schema */
const UserSchema = new mongoose.Schema({
    name: {
        type : String,
        minlength: 3
    },
    email: {
        type : String,
        minlength: 3
    },
    contact: {
        type : Number,
        minlength: 10
    },
    password: {
        type : String,
        minlength: 3
    }
});

const User = mongoose.model('users', UserSchema);

module.exports = User;