const fs = require('fs');
const path = require('path');

const loadTemplate = (templateName, data = {}) => {
  const filePath = path.join(
    __dirname,
    '../templates',
    `${templateName}.html`
  );

  let html = fs.readFileSync(filePath, 'utf8');

  for (const key in data) {
    html = html.replace(
      new RegExp(`{{${key}}}`, 'g'),
      data[key]
    );
  }

  return html;
};

module.exports = {
  loadTemplate
};