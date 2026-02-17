

import 'package:appwrite/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagramclone/models/message.dart';
import 'package:instagramclone/resources/firestor_methods.dart';
import 'package:instagramclone/widget/chat_profile.dart';
import 'package:instagramclone/widget/comment_card.dart';
import 'package:instagramclone/widget/own_message.dart';
import 'package:instagramclone/widget/received_message.dart';
import 'package:provider/provider.dart';
import '../models/user.dart' as Model;
import '../providers/user_provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class PrivateScreen extends StatefulWidget {
  final snapSource;
  final snapTarget;

  const PrivateScreen({super.key, required this.snapSource, required this.snapTarget});

  @override
  State<PrivateScreen> createState() => _PrivateScreenState();
}

class _PrivateScreenState extends State<PrivateScreen> {
  final TextEditingController _messageController = TextEditingController();
  late IO.Socket socket;
  List<MessageModel> messages =[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    connect();
  }

  @override
  void dispose(){
    super.dispose();
    _messageController.dispose();
  }
  void connect(){
    socket = IO.io("http://10.0.2.2:4000", <String, dynamic>{
      "transports": ["websocket"],
      "autoconnect" : false,
    });
    socket.connect();
    socket.emit("signin", widget.snapSource.uid);
    socket.onConnect((data) {
      print("connected");
      socket.on("message", (msg){
        print(msg["message"]);
        setMessage("destination", msg["message"]);//khi se aara h
      });
    });
    print(socket.connected);

  }
  void sendMessage(String message, String receiverId, String sourceId){
    setMessage("source", message); //yha se jaa ra h khi
    socket.emit("message",
              {"message" : message,
                "sourceId" : sourceId,
                "receiverId" : receiverId
              }
              );
    FirestoreMethods().saveMessage(sourceId, receiverId, message);
  }

  void setMessage(String type, String message) {
    MessageModel messageModel = MessageModel(type: type, message: message);
    setState(() {
      messages.add(messageModel);
    });
  }
  @override
  Widget build(BuildContext context) {

    //current user = user
    //jiske sath karni baat voh snap
    final user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar:  AppBar(
        title: const Text('Chat Now ',
          style: TextStyle(color: Colors.lightGreenAccent),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
            Center(
              child: Card(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 18,
                    horizontal: 18,
                  ),
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                              backgroundImage: NetworkImage(widget.snapTarget['photoUrl'] ?? ''),
                              radius: 24
                          ),
                          Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.green
                                ),
                              )),
                        ],
                      ),
                      Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  textAlign: TextAlign.center,
                                  '${widget.snapTarget['username'] ?? 'Unknown'} is active now',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18
                                  ),
                                ),
                              ],
                            ),
                          )
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.call_end_outlined
                          ),
                          Padding(padding: EdgeInsets.symmetric(horizontal: 10)),
                          Icon(
                            Icons.video_call
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          Expanded(
            child: FutureBuilder<QuerySnapshot>(
              future: FirestoreMethods().getMessages(
                  widget.snapSource.uid,
                  widget.snapTarget['uid']
              ),
              builder: (context, snapshot) {
                // Loading state
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                // Error state
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }

                // No data or empty chat
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: const Text('Chat Now'),
                      )
                    ],
                  );
                }

                // Display messages
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var doc = snapshot.data!.docs[index];
                    var messageData = doc.data() as Map<String, dynamic>;

                    String senderId = messageData['senderId'] ?? '';
                    String message = messageData['message'] ?? '';

                    // Check if message is from current user (source)
                    if (senderId == widget.snapSource.uid) {
                      return OwnMessage(
                          message: message,
                          type: "source"
                      );
                    } else {
                      return ReceivedMessage(
                          message: message,
                          type: "destination"
                      );
                    }
                  },
                );
              },
            )
          )
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: kToolbarHeight,
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          padding: const EdgeInsets.only(
            left: 16,
            right: 8,
          ),
          child: Row(
            children: [
              Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 8),
                    child:  TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: 'Message ...',
                        border: InputBorder.none,
                      ),
                    ),
                  )
              ),
              InkWell(
                // onTap: () async{ //sending message logic to user
                //   await FirestoreMethods().postComment(
                //       widget.snap['postId'],
                //       _commentController.text,
                //       user.uid,
                //       user.username,
                //       user.photoUrl
                //   );
                //   setState(() {
                //     _commentController.text = '';
                //   });
                // },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: IconButton(
                      onPressed: (){
                          sendMessage(
                              _messageController.text,
                              widget.snapTarget['uid'],
                              widget.snapSource.uid);
                          _messageController.clear();
                      },
                      icon: const Icon(
                    Icons.send,
                    color: Colors.blueAccent,
                  ))
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
