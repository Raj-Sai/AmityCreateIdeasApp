const functions = require("firebase-functions");
const express = require("express");
const cors = require("cors");
const admin = require("firebase-admin");

admin.initializeApp();

const app = express();

// sign up in ideas app
app.post("/info", async (req, res) => {

  functions.logger.log("--------- add new user ---------");

  const user = req.body;
  const createdTimeStamp = new Date().toISOString().replace(/T/, ' ').replace(/\..+/, '') 
  const snapshot = await admin.firestore().collection("users_info").get()
  
  let users = [];
  var exist_user = false
  snapshot.forEach((doc) => {
    let user_name = doc.data().user_name;
    if (user_name.toLowerCase() == user.user_name.toLowerCase()) {
      functions.logger.log("--------- user_already_exist ---------");
      let response = {
        code: "user_already_exist",
        data: null
      };
      exist_user = true
      res.status(500).send(JSON.stringify(response));
    }
  });

  if (exist_user == false) {
    await admin.firestore().collection('users_info').doc(user.id).set({
     user_name: user.user_name,
     email: user.email,
     phone_number: user.phone_number,
     password: user.password,
     created_time_stamp: createdTimeStamp,
     updated_time_stamp: createdTimeStamp
   })
    functions.logger.log("--------- user added successfully ---------");
    let response = {
        code: "success",
        data: null
      };
      res.status(200).send(JSON.stringify(response));
  }
});

// login in ideas app
app.post("/login", async (req, res) => {
  functions.logger.log("--------- login ---------");

  const user = req.body;

  const createdTimeStamp = new Date().toISOString().replace(/T/, ' ').replace(/\..+/, '') 
  const userInfo = admin.firestore().collection("users_info").where('user_name', '==', user.user_name);

  userInfo.get().then(function (querySnapshot) {
   if (querySnapshot.empty) {
    functions.logger.log("--------- login: user name not exist ---------");
    let response = {
      code: "user_not_exist",
      data: null
    };
    res.status(404).send(JSON.stringify(response));
  } else {
    querySnapshot.forEach(function (doc) {
      console.log(doc.id, ' => ', doc.data());
      if (doc.data().password == user.password) {
        functions.logger.log("--------- login: successfully ---------");

        let response = {
          code: "success",
          data: null
        };
        res.status(200).send(JSON.stringify(response));
      } else {
       functions.logger.log("--------- login: invalid_passcode ---------");

       let response = {
        code: "invalid_passcode",
        data: null }
        res.status(500).send(JSON.stringify(response));
      }
    });

  }
})
});

// get all ideas 
app.get("/ideas", async (req, res) => {
  functions.logger.log("--------- get ideas ---------");
  const snapshot = await admin.firestore().collection("users_ideas").get()
  let users = [];
  snapshot.forEach((doc) => {
    let id = doc.id;
    let data = doc.data();

    users.push({ id, ...data });
  });

  if (users.length == 0) {
    functions.logger.log("--------- get ideas: data_not_found ---------");
    let response = {
     code: "data_not_found",
     data: null
   };
   res.status(404).send(JSON.stringify(response));

 }
 functions.logger.log("--------- get ideas: successfully ---------");
 let response = {
   code: "success",
   data: users
 };

 res.status(200).send(JSON.stringify(response));
});

// get all ideas 
app.get("/info/:id/ideas", async (req, res) => {
  functions.logger.log("--------- get ideas ---------");
  const snapshot = await admin.firestore().collection("users_ideas").where('user_name', '==', req.params.id).get()
  const userInfo = await admin.firestore().collection("users_info").where('user_name', '==', req.params.id).get();
  let responseData = {}
  responseData.user_name = req.params.id
  userInfo.forEach((doc) => {
    responseData.email = doc.data().email;
  });

  let users = [];
  snapshot.forEach((doc) => {

    let id = doc.id;
    let data = doc.data();

    users.push({ id, ...data });
  });
  responseData.ideas = users

 functions.logger.log("--------- get ideas: successfully ---------");
 let response = {
   code: "success",
   data: responseData
 };

 res.status(200).send(JSON.stringify(response));
});


// gat idea details
app.get("/ideas/:id", async (req, res) => {

  functions.logger.log("--------- get ideas details ---------");
  const snapshot = await admin.firestore().collection('users_ideas').doc(req.params.id).get();
  const userId = snapshot.id;
  const userData = snapshot.data();

  functions.logger.log("--------- get ideas details: successfully ---------");
  res.status(200).send(JSON.stringify({id: userId, ...userData}));
})


// post new ideas
app.post("/ideas", async (req, res) => {

  functions.logger.log("--------- post idea detail ---------");
  const user = req.body;
  const createdTimeStamp = new Date().toISOString().replace(/T/, ' ').replace(/\..+/, '') 

  await admin.firestore().collection('users_ideas').doc(user.id).set({
   user_name: user.user_name,
   idea_title: user.idea_title,
   idea_des: user.idea_des,
   idea_image_url: user.idea_image_url,
   idea_category: user.idea_category,
   created_time_stamp: createdTimeStamp,
   updated_time_stamp: createdTimeStamp,
   idea_comments: [],
   idea_likes: []

 })
  functions.logger.log("--------- post idea detail: successfully ---------");
  let response = {
   code: "success",
   data: null
 };

 res.status(200).send(JSON.stringify(response));
});


// add comments for ideas
app.put("/ideas/:id/comment", async (req, res) => {

  functions.logger.log("--------- add comments ---------");

  const body = req.body;
  const createdTimeStamp = new Date().toISOString().replace(/T/, ' ').replace(/\..+/, '') 
  
  await admin.firestore().collection('users_ideas').doc(req.params.id).update({
    idea_comments: admin.firestore.FieldValue.arrayUnion({
      comment: body.comment, comment_by: body.comment_by,  comment_timestamp: createdTimeStamp
    })
  }).then(() => {
    console.log('Added new comment to the idea_comments -> idea_comments array successfully');
     functions.logger.log("--------- add comments: successfully---------");
    let response = {
   		code: "success",
   		data: null
 	};

 	res.status(200).send(JSON.stringify(response));
  }).catch(error => {
     functions.logger.log("--------- add comments: successfully---------");
    let response = {
   		code: "fail",
   		data: null
 	};

 	res.status(500).send(JSON.stringify(response));
  })
});

// add likes for ideas
app.put("/ideas/:id/like", async (req, res) => {
  const body = req.body;
  functions.logger.log("--------- add likes ---------");

  const createdTimeStamp = new Date().toISOString().replace(/T/, ' ').replace(/\..+/, '') 
  await admin.firestore().collection('users_ideas').doc(req.params.id).update({
    idea_likes: admin.firestore.FieldValue.arrayUnion({
     like_by: body.vote_by,  like_timestamp: createdTimeStamp
   })
  }).then(() => {
    console.log('Added new vote to the idea_votes -> idea_votes array successfully');
    let response = {
   		code: "success",
   		data: null
 	};

 	res.status(200).send(JSON.stringify(response));
  }).catch(error => {
    console.log(error);
    let response = {
   		code: "fail",
   		data: null
 	};

 	res.status(500).send(JSON.stringify(response));
  })
  
});

// delete ideas
app.delete("/ideas/:id", async (req, res) => {
  functions.logger.log("--------- delete idea ---------");
  await admin.firestore().collection("users_ideas").doc(req.params.id).delete();
  functions.logger.log("--------- delete idea: successfully ---------");
  res.status(200).send();
})

exports.user = functions.https.onRequest(app);

