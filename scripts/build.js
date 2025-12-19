#!/usr/bin/env node
const fs = require('fs');
const path = require('path');

const src = path.join(__dirname, '../src');
const html = fs.readFileSync(path.join(src, 'index.html'), 'utf8');
const css = fs.readFileSync(path.join(src, 'css/style.css'), 'utf8');
const logic = fs.readFileSync(path.join(src, 'js/clock-logic.js'), 'utf8');
const app = fs.readFileSync(path.join(src, 'js/app.js'), 'utf8');

let output = html
  // Remove dev-only external references
  .replace(/\s*<link rel="stylesheet" href="css\/style\.css">\n/g, '')
  .replace(/\s*<script src="js\/clock-logic\.js"><\/script>\n/g, '')
  .replace(/\s*<script src="js\/app\.js"><\/script>\n/g, '')
  // Inject combined content
  .replace('<!-- BUILD:CSS -->', `<style>\n${css}  </style>`)
  .replace('<!-- BUILD:JS -->', `<script>\n${logic}\n${app}  </script>`);

const outPath = path.join(__dirname, '../TaskTimer.html');
fs.writeFileSync(outPath, output);
console.log('Built TaskTimer.html (' + output.length + ' bytes)');
