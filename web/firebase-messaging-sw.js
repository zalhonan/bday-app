importScripts("https://www.gstatic.com/firebasejs/8.7.1/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.7.1/firebase-messaging.js");

//Using singleton breaks instantiating messaging()
// App firebase = FirebaseWeb.instance.app;

firebase.initializeApp({
  apiKey: "api-key",
  authDomain: "project-id.firebaseapp.com",
  databaseURL: "https://project-id.firebaseio.com",
  projectId: "project-id",
  storageBucket: "project-id.appspot.com",
  messagingSenderId: "sender-id",
  appId: "app-id",
  measurementId: "G-measurement-id",
});

const messaging = firebase.messaging();
messaging.setBackgroundMessageHandler(function (payload) {
  const promiseChain = clients
    .matchAll({
      type: "window",
      includeUncontrolled: true,
    })
    .then((windowClients) => {
      for (let i = 0; i < windowClients.length; i++) {
        const windowClient = windowClients[i];
        windowClient.postMessage(payload);
      }
    })
    .then(() => {
      return registration.showNotification("New Message");
    });
  return promiseChain;
});
self.addEventListener("notificationclick", function (event) {
  console.log("notification received: ", event);
});
