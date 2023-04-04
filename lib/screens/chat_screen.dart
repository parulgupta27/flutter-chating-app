import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:chat_off/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  final user=FirebaseAuth.instance;
  final _fireStore=FirebaseFirestore.instance;
  final mtc=TextEditingController();
  String message="";
  var email="";
  bool isMe=false;
  getcurrentUser() async{
 final myuser= await user.currentUser;
    if(myuser!=null){
      email="${myuser.email}";
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getcurrentUser();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                user.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: 
       Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            
          Flexible(child: 
     StreamBuilder<QuerySnapshot>(
      stream: _fireStore.collection('messages').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
       List<messageBubble>myWidgets= snapshot.data!.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
            return messageBubble(data['text'].toString(),data['email'].toString(),
            data['email'].toString()==email);
          }).toList();
          myWidgets.reversed;
        return ListView(
          reverse: true,
          children: myWidgets,
          // children: snapshot.data!.docs.map((DocumentSnapshot document) {
          // Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
          //   return Text(data['text']);
          // }).toList(),
        );
      }),),
      Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: mtc,
                      onChanged: (value) {
                        message=value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if(message.length>0){
                        mtc.clear();
                        _fireStore.collection("messages").add({
                        'text':message,
                        'email':email,
                        });
                      }
                    },
                    child: Text(
              
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class messageBubble extends StatelessWidget {
  String message;
  String sender;
  bool isMe;
  messageBubble(this.message,this.sender,this.isMe);
  @override
  Widget build(BuildContext context) {
    return Column(
    crossAxisAlignment: isMe?CrossAxisAlignment.end:CrossAxisAlignment.start,
    children: [
      Text(sender,style: TextStyle(color: Colors.grey, fontSize: 15),),
      Padding(padding: EdgeInsets.only(top:10)),
      Padding(
        padding: EdgeInsets.only(left: 10,right: 10,bottom: 30),
        child:Material(
        elevation: 5,
        color: isMe?Colors.blueAccent:Colors.white,
        borderRadius:isMe? BorderRadius.only(
          topLeft: Radius.circular(30),
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ):BorderRadius.only(
          topRight: Radius.circular(30),
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
       child: Padding(padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
       child: Text(message,style: TextStyle(color: isMe?Colors.white:Colors.blueAccent,fontSize: 15),),
       ),
      ),
      ),
    ],
    );
  }
}