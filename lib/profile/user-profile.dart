import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enc_flutter_2020_f1/constants/app-constants.dart';
import 'package:enc_flutter_2020_f1/model/user.dart' as u;
import 'package:enc_flutter_2020_f1/util/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<u.User> fetchUserDetails() async{
  FirebaseFirestore db = FirebaseFirestore.instance;
  print("UID is ${Utils.UID}");
  DocumentSnapshot documentSnapshot = await db.collection(Constants.USERS_COLLECTION).doc(Utils.UID).get();
  u.User user = u.User.fromDocument(documentSnapshot.data());
  return user;
}

uploadImageToFirebaseStorage(String path) async{

  // Create the File Object to be Uploaded
  File file = File(path);

  // Obtain Reference to Firebase Storage
  StorageReference storageReference = FirebaseStorage.instance.ref();
  StorageReference profilePicsReference = storageReference.child("profile-pics/");

  // Upload the Image
  // In order to monitor the file upload completion we will use StorageTaskSnapshot
  StorageTaskSnapshot snapshot = await profilePicsReference.child("profile_pic_${Utils.UID}.jpg").putFile(file).onComplete;

  // If no errors get the URL of the Image which we just uploaded :)
  if(snapshot.error == null){
    String profileImageURL = await snapshot.ref.getDownloadURL(); // Get the URL of the Uploaded Image :)

    FirebaseFirestore db = FirebaseFirestore.instance;
    db.collection(Constants.USERS_COLLECTION).doc(Utils.UID).update({"imageURL": profileImageURL}).then((value){
      print("Image Uploaded and URL Saved :)");
    });
  }else {
    print("Something went Wrong");
  }
}


class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {

  // user as reference points to a default User Object
  u.User user = u.User();

  @override
  void initState() {
    super.initState();
    fetchUserDetails().then((u.User value){
      setState(() {
        user = value; // refresh i.e. re execute the build function to update UI
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(24.0),
      children: <Widget>[
        Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(padding: EdgeInsets.all(8.0),),
              InkWell(
                child: CircleAvatar(
                  backgroundImage: user.imageURL!=null ? NetworkImage(user.imageURL) : AssetImage("assets/steve.png"),
                  radius: 100,
                ),
                onTap: () async{
                  //await ImagePicker.platform.pickImage(source: ImageSource.camera);
                  PickedFile pickedFile = await ImagePicker.platform.pickImage(source: ImageSource.gallery);
                  uploadImageToFirebaseStorage(pickedFile.path); // give the path of the picked image :)
                },
              ),
              Padding(padding: EdgeInsets.all(8.0),),
              Divider(),
              Text(user.name, style: TextStyle(color: Colors.redAccent, fontSize: 20.0),),
              Text(user.email, style: TextStyle(color: Colors.blueGrey, fontSize: 18.0),),
              user.phone == null ? Text("", style: TextStyle(color: Colors.blueGrey, fontSize: 18.0),) : Text(user.phone, style: TextStyle(color: Colors.blueGrey, fontSize: 18.0),)
            ],
          ),
        ),
        ListTile(
          leading: Icon(Icons.person),
          title: Text("Manage Profile", style: TextStyle(color: Colors.blueGrey, fontSize: 18.0),),
          subtitle: Text("Update Data for your Profile"),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: (){

          },
        ),
        ListTile(
          leading: Icon(Icons.home),
          title: Text("Manage Addresses", style: TextStyle(color: Colors.blueGrey, fontSize: 18.0),),
          subtitle: Text("Add or Remove Addresses"),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: (){
            Navigator.pushNamed(context, "/addresses");
          },
        ),
        ListTile(
          leading: Icon(Icons.fastfood),
          title: Text("Manage Orders", style: TextStyle(color: Colors.blueGrey, fontSize: 18.0),),
          subtitle: Text("All the Orders History"),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: (){

          },
        ),
        ListTile(
          leading: Icon(Icons.help),
          title: Text("Help & Assist", style: TextStyle(color: Colors.blueGrey, fontSize: 18.0),),
          subtitle: Text("FAQ's about the App and Usage"),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: (){

          },
        ),
        ListTile(
          leading: Icon(Icons.import_contacts),
          title: Text("Terms & Conditions", style: TextStyle(color: Colors.blueGrey, fontSize: 18.0),),
          subtitle: Text("We are transparent with what we do"),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: (){

          },
        ),
        ListTile(
          leading: Icon(Icons.help),
          title: Text("Help & Assist", style: TextStyle(color: Colors.blueGrey, fontSize: 18.0),),
          subtitle: Text("FAQ's about the App and Usage"),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: (){

          },
        ),
        ListTile(
          leading: Icon(Icons.account_box),
          title: Text("Log Out", style: TextStyle(color: Colors.blueGrey, fontSize: 18.0),),
          subtitle: Text("Log Out your account from App"),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: (){
            // Here Firebase will remove the User token which was saved locally on the device when user registered or logged in
            // Hence, next time in splash FirebaseUser will be null after signout :)
            FirebaseAuth.instance.signOut();
            Navigator.pushReplacementNamed(context, "/"); // Take the user back to splash page again
          },
        ),
      ],
    );
  }
}
