import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterpubsub/all_topic.dart';

import 'package:googleapis/pubsub/v1.dart';
import 'package:googleapis/translate/v3.dart';
import 'package:googleapis_auth/auth.dart';
import 'package:googleapis_auth/auth_io.dart';

class ActionsWidget extends StatefulWidget {

  final String privateKeyId;
  final String projectId = "saffair";
  final String privateKey;
  String clientEmail;
  String clientId;
  String type = 'service_account';

  ActionsWidget({this.privateKeyId, this.clientId, this.clientEmail, this.type, this.privateKey});

  @override
  _ActionsWidgetState createState() => _ActionsWidgetState();
}

class _ActionsWidgetState extends State<ActionsWidget> {

  var pubSubClient;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();









  }

  actions(_credentials) {

    const _SCOPES = const [TranslateApi.CloudTranslationScope];

    clientViaServiceAccount(_credentials, _SCOPES).then((http_client) {
      
//        var pubSubClient = new PubsubApi(http_client);
        
        var translateClient = new TranslateApi(http_client);
        
//        translateClient.projects.getSupportedLanguages('projects/${widget.projectId}', ).then((value) {
//          value.languages.map((e) {
//            print(e.displayName);
//            print(e.languageCode);
//          }).toList();
//        });

        var req = {
          "contents": [
              "what is your name"
              ],
              "sourceLanguageCode": "en",
              "targetLanguageCode": "fr",

          };

        TranslateTextRequest request = TranslateTextRequest.fromJson(req);
        
        translateClient.projects.translateText(request, 'projects/${widget.projectId}').then((value){
          value.translations.map((e) {
            print('printing');
            print(e.translatedText);
          }).toList();
        });




//      pubSubClient.projects.topics.list('projects/${widget.projectId}').then((value) {
//        value.topics.map((e){
//          print(e.name);
//        }).toList();
//      });

      

//    pubSubClient.projects.topics.create(Topic.fromJson(messages), "projects/${widget.projectId}/topics/newnew").then((value) {
//      print(value.toString());
//    });


//      pubSubClient.projects.topics
//          .publish(new PublishRequest.fromJson(messages), "projects/flutter-maps-281407/topics/starts")
//          .then((publishResponse) {
//        print(publishResponse.messageIds.length);
//      }).catchError((e,m){
//        print(m.toString());
//        debugPrint(e.toString());
//      });
//
//      pubSubClient.projects.topics.get("projects/flutter-maps-281407/topics/starts").then((value) {
//        print(value.labels);
//      }).catchError((e){
//        print(e.toString());
//      });

//      print(pubSubClient.projects.topics.snapshots.list(topic));



//      pubSubClient.projects.subscriptions.pull(PullRequest.fromJson(messages), "projects/flutter-maps-281407/subscriptions/Ssam").then((value) {
//
//        value.receivedMessages.map((e) {
//
//          print(utf8.decode(e.message.dataAsBytes));
////          print(e.message.messageId);
//        }).toList();
//
//      });
//
//      pubSubClient.projects.topics.subscriptions.list("projects/flutter-maps-281407/topics/starts").then((value) {
//        print(value.subscriptions);
//      });

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.projectId.toString()),
      ),
      body: Container(
        child: Column(
        children: [
          RaisedButton(
            color: Colors.green,
            child: Text('GET ALl TOPICS',style: TextStyle(color: Colors.white),),
            onPressed: () async {
              Navigator.push(context, MaterialPageRoute(builder: (context) => AllTopics(pubSub: pubSubClient, projectId: widget.projectId,)));
            },
          ),
          SizedBox(
            height: 20,
          ),
          RaisedButton(
            color: Colors.green,
            child: Text('All Subscriptions',style: TextStyle(color: Colors.white),),
            onPressed: () async {

            },
          )
        ]
      ),
      )
    );
  }
}
