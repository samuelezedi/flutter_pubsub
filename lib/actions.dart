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


    final _credentials = new ServiceAccountCredentials.fromJson(r'''
        {
    "private_key_id": "466d66f832d7bedb781816b9fca6fb6cedebf9f6",
    "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDxMlhNKvLtEkV5\nycUlANEALNxcfq9untV4wpqL+g/94JRKsl+HvfpCywqXx5YxTQXw7NAlpJnl+0jf\nupfVf5xLBfNyNqg9dd7uA9rO30YifiYTFkaMghZX56uaLe7k1uIMYkd7rixUa6jg\nTAABtw3IXXsklS0I7eQRSlM+w6zC1JfXXUbjB0LeBkMzkas81v+cLBFL2irvCsmF\nhwXXUGT/RR+O2Z6VbIMaO0w2OnTN0m36Y9nWEedc7lWkxsC3ObkOUAXueCxEqrGA\nGPAdr9an1qvp0cNY7UjcRzOmvaU6sa7pLQQSeJNnjismMFLfjay0bBJOHth0NUzq\n+ZnyIB9jAgMBAAECggEAX6VTv9IiwCEpPNjm3TwcJSIlBmbUYZ0J0Rf2mkCA+++F\nTrO6T0VmSvtiSXsDk6xUCUyXY/4Ia1tA9Dt1v1uZ2mRTPDzxbWHjE+aia7u9f6sf\npR0Fv+1MN/KuKXdCjyupOzjz2NdiS93fe4aX0BZLmGN9lC21zJ8tfC/JoA+PYDiR\nn0VOMqz/XQO5U1qiOrh8VEouZATtAFCmLoc9GdeiW00TcjYTjnLnjivSv0HgQgIk\n1Iouk37yaZ6ja9ZhrSGib1IoKJiUsucE3BeyUEaUwPUeJ95mJczUQnccVtujnvQD\njXGztd0p8VwY82uTYtC8rrXMCes6c9gB/CU+fGvEZQKBgQD7+TYJikdCfjKnN5sm\nurhIMDy9cSNVHCFI9hw3gno8ZCUnL6R0XG+qCyxHDlKx4tn3rW0fzfXr6xsokV41\nrEpXWrvAX8+KM+y7G0gEHUuJ+nyI87LYafouXwXNe9YnzZaE+s25Ibc8Rc4HlVJ4\ndOVtsx3jfxXgrNgO+6ha0IQL/QKBgQD1DQwfGdKxQoP6t0BJiiVigevN4WjQZ1pY\nQU7xSkE6Doi84H2QRMs9nLIIOTinVSe07ao2MhPCB7/KNNuTx617J9gHVYI1T52e\n5AAbVB4EDct3MDav1BAZDZnoaU61b282laQpOznxK0GB7wC0yeuYFXMsin4Xe19z\nPAQgK2TG3wKBgF9G24z98XYOG/8owo0Be58oRj9n4XFUQq3BCehfePMO9xF7LVcm\ngL6unN59Zv2Ght7lf+bPzVaYvts3JIVtEWs4jtfuIp7ihXg2l6OepCqXQbHTXGQC\npqwUGDCby92fGnRMFbAUNKIgzwgFCXss0HgLi5izPEWJdeUseXtlbxjNAoGBAOez\nyYVStlwy53XVdazTOZwV+m91tdRwFQWj4s/VhS0u9u2YWkFiOsXr9o4+BKp7owq5\nOhr6aKIrD5ZTOldWE1uChgoROQfNWt0U+mDcvXDZ1kvBQ8QnAH2f1anigLCfSAnV\nnh36SUQWwV7pLMLEtcXcakVwQd9UISFlWwVL4oMDAoGBAJJjC9aD2q2VO9/P1UXZ\nU+9zMHdT6UVOvNqskfCkzMklGR0Bl/Wfpm+r5CcEppkTm6f7f//EHZyglX1pIS7l\n4v0zi1NEJ2bHPQpP9Nh/5jgeLk38PtlXbPZyq+ymkbvSWG6y+124+AZ4EaykjaXC\nzjqTu51Y4+zhwxoeTn45uxQt\n-----END PRIVATE KEY-----\n",
        "client_email": "saffairtranslate@saffair.iam.gserviceaccount.com",
        "client_id": "100902019528293920942",
        "type": "service_account"
    }
    ''');




//        final _credentials = new ServiceAccountCredentials.fromJson(r'''
//        {
//    "private_key_id": "4c7ca64a49035e8349f050ff566abdb07fd7f449",
//    "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCP11rU8uGwy+N9\n+o1gyRramckRsaqgi+XdtYY2q+KHJbOpygPyQwD/AE3vOkfEPiXhW1tap7TtuHxG\nVtejzhoBEl6gVPV0x1JHtuLo9gOVhVZ5I+mgsHbyUGoyjIbyrZ7y4uK9v/MRxgkP\nEabrq8qlkW09RybGV70201CVJ1r+pBHXsXiCy2j4PtdWl71/uF/qEcpZI1Fi7fL3\ngbN1aQTLztaL8cFknTAjzpsmiHUvhDBW+YxZzeb6UjO9NTF0MUX/odemNryRuMUz\nbFMjDxqtmIIdpKY8oKdLWO2MZH1et9iws6z/+UEd8BrrkuVSueTEHimpqWtXgSpV\nuTMp8pOFAgMBAAECggEAAvCzkNmEIsbL5PTpZvpwDw3MskiYZtp2SoOIfggzO064\nN51QFlaN9MIM72BL1biGkAh7zHegqnYc1yS1GP2EsbGDqssByqaruENbiZUzZPRW\n9hHTW+bAmDiwHjy8IhtSPdCzqifAeNmRwgj/PKfQ9A5SUgWTrSmjxWg6MOPsBWoi\n1zgC0yGN6wM/0Da+0mmW8olL/+TBbw+UgbsHNrDDDomS00RrdoJXjf5qEr49rVgw\nqJfJ4SAT+1DnfuWvrrEZtLiJTFuMHP839yXtmyhJFPJBvhlzrdgFK07SftlNXxVA\naNUYlt1Fna1H5goRZc5RTUe5I6AmGw73SbeeEUzDQwKBgQDBh1qqKH+WHKAvOAuq\nea4wB8lTx+TeIuL9k4/OB4WNcOkxrkDBOue8GiM+J4uK+voOXrYC69pUuRSttXZj\nZC1q966uIsHHu0IXewuIGPQis638/mTXuAFMwD1zV9p0BE+eGMocl70dRJ69QaMt\nmH5eR/M72bFsazaGJt2uoVCP0wKBgQC+RfjD54b7+14CjbJ1eNyHZSGp4PWHWBSF\nBFUWFDleOdZ8AgxvT+vAOKjio2r7n5KslQSiCkboS1OZcgfVWPkL2i/QDkYXm+SC\nX35j2y+utbzuyBjo6m7JfS2RNmSt94xZAAB6lcffvSt7fX5dVK/evy/f6qrTJ23E\n01vzWPyQRwKBgAhrPft3BY3fMuy68G77GiPGwvBdGsy7EcrcN35L/3hWuB5MKU7+\npAQf0vaqO7zRDD3BywM3hWj4IDkqUrsiKYOkwLmck3d/4vEojijehQhZbrE50+M6\ngvv2xPWWlc9EPL5w76Hsy/JRAOLUzyd1odGyKZep8bj4tQeC+1PUeq+3AoGAN9SU\nP/eJthp15U3qlWmXW+siy5QEt2fy7WzuAoKAqtNRyiVXvLm4tThq5cWJuLeD9Dvt\nlhZp4/NmXloFTmbC/OVSrjvh+T9294JJtcc04JDXFUGFfaJ8S4b9feR1+k3u0pab\njVyxv0bkoWGbWItm53c19wAGi9q/7McP7gGoajUCgYBgf5ELlZyQXNNjYCyn/L+q\nFsFqNmzoqEZRHmCRJSGVquWSPHr2/OMkLHvdT8u3i3yVxAGTHmX6J+ReK1A6Iq1F\nysWl+Ni8tRzJzlyuGdb8odanSQwKbXHT6JWl8Rb0Wj5iYPaantgdKyMBrW1j4tBl\ntYSBlIYYe2FDayPobzFbFw==\n-----END PRIVATE KEY-----\n",
//        "client_email": "flutter-maps-281407@appspot.gserviceaccount.com",
//        "client_id": "110675953679362480044",
//        "type": "service_account"
//    }
//    ''');

    actions(_credentials);

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
