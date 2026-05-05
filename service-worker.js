// TaxiTN Service Worker - PWA & Offline Support
const CACHE_NAME = 'taxitn-v1';
const STATIC_ASSETS = [
  '/',
  '/index.html',
  '/taxitn_clone.html',
  '/taxitn_maps.html',
  '/driver_register.html',
  '/admin_dashboard.html',
  '/css/driver_register.css',
  '/css/admin_dashboard.css',
  '/css/taxitn_clone.css',
  '/css/taxitn_maps.css',
  '/manifest.json',
  'https://fonts.googleapis.com/css2?family=Tajawal:wght@300;400;500;700;800;900&display=swap',
  'https://unpkg.com/leaflet@1.9.4/dist/leaflet.css'
];

// Install event - cache static assets
self.addEventListener('install', (event) => {
  console.log('[SW] Installing Service Worker...');
  event.waitUntil(
    caches.open(CACHE_NAME)
      .then((cache) => {
        console.log('[SW] Caching static assets');
        return cache.addAll(STATIC_ASSETS);
      })
      .then(() => {
        console.log('[SW] Static assets cached successfully');
        return self.skipWaiting();
      })
      .catch((error) => {
        console.error('[SW] Cache failed:', error);
      })
  );
});

// Activate event - clean up old caches
self.addEventListener('activate', (event) => {
  console.log('[SW] Activating Service Worker...');
  event.waitUntil(
    caches.keys().then((cacheNames) => {
      return Promise.all(
        cacheNames
          .filter((name) => name !== CACHE_NAME)
          .map((name) => {
            console.log('[SW] Deleting old cache:', name);
            return caches.delete(name);
          })
      );
    }).then(() => {
      console.log('[SW] Service Worker activated');
      return self.clients.claim();
    })
  );
});

// Fetch event - serve from cache or network
self.addEventListener('fetch', (event) => {
  const { request } = event;
  const url = new URL(request.url);

  // Skip non-GET requests
  if (request.method !== 'GET') {
    return;
  }

  // Cache-first strategy for static assets
  if (isStaticAsset(url)) {
    event.respondWith(
      caches.match(request)
        .then((cachedResponse) => {
          if (cachedResponse) {
            // Return cached version and update in background
            fetchAndCache(request);
            return cachedResponse;
          }
          return fetchAndCache(request);
        })
        .catch(() => {
          // Return offline fallback if available
          return caches.match('/index.html');
        })
    );
    return;
  }

  // Network-first strategy for API calls
  if (isAPIRequest(url)) {
    event.respondWith(
      fetch(request)
        .then((response) => {
          if (response.ok) {
            const clonedResponse = response.clone();
            caches.open(CACHE_NAME).then((cache) => {
              cache.put(request, clonedResponse);
            });
          }
          return response;
        })
        .catch(() => {
          return caches.match(request);
        })
    );
    return;
  }

  // Default: network with cache fallback
  event.respondWith(
    fetch(request)
      .catch(() => caches.match(request))
  );
});

// Helper functions
function isStaticAsset(url) {
  const staticExtensions = ['.html', '.css', '.js', '.png', '.jpg', '.jpeg', '.gif', '.svg', '.ico', '.woff', '.woff2', '.ttf'];
  return staticExtensions.some(ext => url.pathname.endsWith(ext)) ||
         url.hostname.includes('fonts.googleapis.com') ||
         url.hostname.includes('fonts.gstatic.com');
}

function isAPIRequest(url) {
  return url.pathname.startsWith('/api/') || 
         url.hostname.includes('api.') ||
         url.hostname.includes('unpkg.com') ||
         url.hostname.includes('cdn.');
}

function fetchAndCache(request) {
  return fetch(request)
    .then((response) => {
      if (!response || response.status !== 200 || response.type !== 'basic') {
        return response;
      }
      const clonedResponse = response.clone();
      caches.open(CACHE_NAME).then((cache) => {
        cache.put(request, clonedResponse);
      });
      return response;
    });
}

// Background sync for offline form submissions
self.addEventListener('sync', (event) => {
  if (event.tag === 'sync-forms') {
    event.waitUntil(syncFormSubmissions());
  }
});

function syncFormSubmissions() {
  // Placeholder for form sync logic
  console.log('[SW] Syncing form submissions...');
  return Promise.resolve();
}

// Push notifications (placeholder)
self.addEventListener('push', (event) => {
  if (event.data) {
    const data = event.data.json();
    const options = {
      body: data.body,
      icon: '/icons/icon-192x192.png',
      badge: '/icons/icon-72x72.png',
      vibrate: [100, 50, 100],
      data: data.url
    };
    event.waitUntil(
      self.registration.showNotification(data.title, options)
    );
  }
});

// Notification click handler
self.addEventListener('notificationclick', (event) => {
  event.notification.close();
  event.waitUntil(
    clients.openWindow(event.notification.data || '/')
  );
});
