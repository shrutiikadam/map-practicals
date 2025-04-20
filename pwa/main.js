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
      .register('/service-worker.js')
      .then((reg) => {
        console.log('✅ Service Worker registered: ', reg);
      })
      .catch((err) => {
        console.error('❌ Service Worker registration failed: ', err);
      });
  });
}


reportWebVitals();



// Service-worker.js-in public folder

self.addEventListener('install', (e) => {
    console.log('[Service Worker] Installed');
    e.waitUntil(
      caches.open('ecom-cache').then((cache) => {
        return cache.addAll([
          '/',
          '/index.html',
          '/manifest.json',
          '/logo192.png',
          '/logo512.png',
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
 

// Manifest.json

{
  "short_name": "EcomApp",
  "name": "E-commerce PWA App",
  "icons": [
    {
      "src": "logo192.png",
      "type": "image/png",
      "sizes": "192x192"
    },
    {
      "src": "logo512.png",
      "type": "image/png",
      "sizes": "512x512"
    }
  ],
  "start_url": ".",
  "display": "standalone",
  "theme_color": "#1976d2",
  "background_color": "#ffffff"
}



// In index.html header

<link rel="manifest" href="%PUBLIC_URL%/manifest.json" />
    <meta name="theme-color" content="#1976d2" />

