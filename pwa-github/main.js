// First of all push pwa project on github and then 


// Package.json
{
  "homepage": "https://shrutiikadam.github.io/ecom-pwa",
  "name": "ecom",
  "version": "0.1.0",
  "private": true,
  "dependencies": {
    "@emotion/react": "^11.14.0",
    "@emotion/styled": "^11.14.0",
    "@mui/icons-material": "^7.0.2",
    "@mui/material": "^7.0.2",
    "@testing-library/dom": "^10.4.0",
    "@testing-library/jest-dom": "^6.6.3",
    "@testing-library/react": "^16.3.0",
    "@testing-library/user-event": "^13.5.0",
    "react": "^19.1.0",
    "react-dom": "^19.1.0",
    "react-scripts": "5.0.1",
    "web-vitals": "^2.1.4"
  },
  "scripts": {
    "start": "react-scripts start",
    "build": "react-scripts build",
    "test": "react-scripts test",
    "eject": "react-scripts eject",
    "predeploy": "npm run build",
    "deploy": "gh-pages -d build"
  },
  "eslintConfig": {
    "extends": [
      "react-app",
      "react-app/jest"
    ]
  },
  "browserslist": {
    "production": [
      ">0.2%",
      "not dead",
      "not op_mini all"
    ],
    "development": [
      "last 1 chrome version",
      "last 1 firefox version",
      "last 1 safari version"
    ]
  },
  "devDependencies": {
    "gh-pages": "^6.3.0"
  }
}



// index.js
import React from 'react';
import ReactDOM from 'react-dom/client';
import './index.css';
import App from './App';
import reportWebVitals from './reportWebVitals';


const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
);


// ✅ Register service worker
if ('serviceWorker' in navigator) {
  window.addEventListener('load', () => {
    navigator.serviceWorker
      .register('/ecom-pwa/service-worker.js')
      .then((reg) => {
        console.log('✅ Service Worker registered: ', reg);
      })
      .catch((err) => {
        console.log('❌ Service Worker registration failed: ', err);
      });
  });
}


reportWebVitals();


// service-worker.js
self.addEventListener('install', (e) => {
    console.log('[Service Worker] Installed');
    e.waitUntil(
      caches.open('ecom-cache').then((cache) => {
        return cache.addAll([
          '/ecom-pwa/',
          '/ecom-pwa/index.html',
          '/ecom-pwa/manifest.json',
          '/ecom-pwa/logo192.png',
          '/ecom-pwa/logo512.png',
        ]);
      })
    );
  });
 
  self.addEventListener('fetch', (e) => {
    e.respondWith(
      caches.match(e.request).then((response) => {
        return response || fetch(e.request);
      })
    );
  });
 

// Commands 👍
// npm install gh-pages --save-dev

//  npm run build
// >> npm run deploy
