const functions = require("firebase-functions");
const admin = require("firebase-admin");
// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

admin.initializeApp();

exports.myFunction = functions.firestore
    .document("chats/{messages}")
    .onCreate((snapshot, context) => {
      return admin.messaging().send({
        notification: {
          title: snapshot.data().username,
          body: snapshot.data().text,
          clickAction: "FLUTTER_NOTIFICATION_CLICK",
        },
      });
    });
