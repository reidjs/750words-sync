// Pass the readdir 
const dotfilePath = `${__dirname}/.env`

require('dotenv').config({path: dotfilePath})
var https = require('follow-redirects').https;
var fs = require('fs');
const EMAIL = process.env.EMAIL
const PASSWORD = process.env.PASSWORD
const puppeteer = require('puppeteer');

const getBrowserData = async () => {
  const browser = await puppeteer.launch();
  const page = await browser.newPage();
  await page.goto('https://750words.com/auth');
  const fn = function(el, value) { el.value = value }
  await page.$eval('#person_email_address', fn, EMAIL);
  await page.$eval('#person_password', fn, PASSWORD);
  await page.click('input[type="submit"]');
  await page.waitForSelector('#entry_body');
  const cookies = await page.cookies()
  let cookie = ''
  for(let i = 0; i < cookies.length; i++) {
    const c = cookies[i]
    cookie += c.name + '=' + c.value + "; "
  }
  const COOKIE = cookie.slice(0, -1)
  const entry_id_element = await page.$('#entry_id')
  const ENTRY_ID = await page.evaluate(element => element.value, entry_id_element);
  const rv_element = await page.$('#entry_record_version')
  const RV = await page.evaluate(element => element.value, rv_element);
  await browser.close();

  return { ENTRY_ID, RV, COOKIE }
}

const save = (text, entry_id, rv, cookie) => {
  var options = {
    'method': 'POST',
    'hostname': '750words.com',
    'path': '/autosave',
    'headers': {
      'authority': '750words.com',
      'accept': 'text/javascript, application/javascript, application/ecmascript, application/x-ecmascript, */*; q=0.01',
      'x-requested-with': 'XMLHttpRequest',
      'user-agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_14_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.138 Safari/537.36',
      'content-type': 'application/x-www-form-urlencoded; charset=UTF-8',
      'origin': 'https://750words.com',
      'sec-fetch-site': 'same-origin',
      'sec-fetch-mode': 'cors',
      'sec-fetch-dest': 'empty',
      'referer': 'https://750words.com/',
      'accept-language': 'en-US,en;q=0.9,la;q=0.8',
      cookie
    },
    'maxRedirects': 20
  };

  var req = https.request(options, function (res) {
    var chunks = [];

    res.on("data", function (chunk) {
      chunks.push(chunk);
    });

    res.on("end", function (chunk) {
      var body = Buffer.concat(chunks);
      console.log(body.toString());
    });

    res.on("error", function (error) {
      console.error(error);
    });
  });
  console.log('text written to website: \n', text)
  var postData =  `entry[id]=${entry_id}&entry[num_words]=${text.split(' ').length}&entry[body]=${encodeURIComponent(text)}&v=ctrls&rv=${rv}`;

  req.write(postData);

  req.end();
}

const getText = () => {
  const dir = process.argv[2] ? process.argv[2] : __dirname
  const text = fs.readFileSync(`${dir}/TODAY.md`, 'utf8');
  return text
}

(async() => {
  const { ENTRY_ID, RV, COOKIE } = await getBrowserData()
  const TEXT = getText()
  save(TEXT, ENTRY_ID, RV, COOKIE)
})();

