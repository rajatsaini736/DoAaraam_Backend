var Mailgen = require('mailgen');

var mailGenerator = new Mailgen({
    theme: 'default',
    product: {
        name: 'Mailgen',
        link: 'https://mailgen.js/'
    }
});

var signup = {
    body: {
        name: 'Rajat Saini',
        intro: 'Welcome to DOAARAAM! We\'re very excited to have you on board.',
        action: {
            instructions: 'To get started with DOAARAAM, Please click here:',
            button: {
                color: '#22BC66',
                text: 'Confirm your account',
                link: ''
            }
        },
        outro: 'Need help, or have questions? Just reply to this email, we\'d love to help.'
    }
};

var signUpBody = mailGenerator.generate(signup);

module.exports = {
    signUpBody: signUpBody
}