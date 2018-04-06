require('./sitePage')

const { Chromeless } = require('chromeless')
const fs = require('fs');

let url = 'https://kteich88.github.io';

sitePage.forEach(async function run(page) {
  const chromeless = new Chromeless()
    .goto(url + page)

    console.log(page);

  let dir = './screenshots/' + page ;
  if (!fs.existsSync(dir)) {
      fs.mkdirSync(dir);
  }
  const screenshot = await chromeless
    .screenshot('body', { filePath: dir + 'page.png' })

    console.log(screenshot) // prints local file path or S3 url
  await chromeless.end()
})
