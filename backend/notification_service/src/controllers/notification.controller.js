const { sendEmailWithTemplate } = require('../services/notification.service');

const sendNotification = async (req, res, next) => {
  try {
    const { email, type, data } = req.body;

    await sendEmailWithTemplate({ email, type, data });

    res.json({ message: 'Email sent successfully' });
  } catch (err) {
    next(err);
  }
};

module.exports = { sendNotification };