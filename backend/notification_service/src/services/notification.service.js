const sgMail = require('../config/sendgrid');
const { loadTemplate } = require('../utils');

const sendEmailWithTemplate = async ({ email, type, data }) => {
  let templateName = '';
  let subject = '';

  switch (type) {
    case 'USER_REGISTERED':
      templateName = 'welcome';
      subject = 'Welcome!';
      break;

    case 'TRANSACTION_CREATED':
      templateName = 'transaction-created';
      subject = 'Transaction Success';
      break;

    default:
      throw new Error('Unsupported notification type');
  }

  const html = loadTemplate(templateName, data);

  await sgMail.send({
    to: email,
    from: process.env.FROM_EMAIL,
    subject,
    html,
  });
};

module.exports = {
  sendEmailWithTemplate
};