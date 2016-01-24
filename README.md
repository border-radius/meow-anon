# 6nw ![meow](https://meow.bnw.im/static/favicon-big.png)

Anonymized fork of kawaii single-page web interface for [BnW](https://github.com/stiletto/bnw) built on top of great Chaplin framework.

## See it in action

https://6nw.im/

## Use with bnw.im

Send the following message to the bot:
```
set baseurl http://6nw.im
```
Now all links that you get from bot will have correct prefix.

## Manual build

You could easily build and host you own version of bnw-meow. bnw-meow uses Brunch for build automation so you will need nodejs and npm installed.

### Quick & dirty way

```bash
% sudo npm install -g brunch bower
% git clone https://github.com/border-radius/meow-anon.git && cd meow-anon
% npm install && bower install
% cp app/scripts/config.coffee.example app/scripts/config.coffee
% cp server.example.json server.json
% brunch build -P  # Build minified version in public/
```
Edit `server.json` (set up your login-key) and `app/scripts/config.coffee` (set up API address) and after all launch server:

```bash
% node index
```

## License

bnw-meow - kawaii single-page web interface for BnW

Written in 2013-2014 by Kagami Hiiragi <kagami@genshiken.org>

To the extent possible under law, the author(s) have dedicated all copyright and related and neighboring rights to this software to the public domain worldwide. This software is distributed without any warranty.

You should have received a copy of the CC0 Public Domain Dedication along with this software. If not, see <http://creativecommons.org/publicdomain/zero/1.0/>.

---

**NOTE:** This license applied only to the bnw-meow code itself (this repository). You may not redistribute entire bnw-meow build under the CC0. Instead see the comments inside the generated files (`/static/*.css`, `/static/*.js`). Basically it's all MIT and BSD, so you will need to keep this comments in order to legally redistribute it.
