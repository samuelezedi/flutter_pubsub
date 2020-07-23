import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterpubsub/actions.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
    
        primarySwatch: Colors.blue,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ActionsWidget(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  getCredentials() async {
    SharedPreferences local = await SharedPreferences.getInstance();
    setState(() {
      privateKeyId = local.getString('pki');
      privateKey = local.getString('pk');
      clientEmail = local.getString('ce');
      clientId = local.getString('ci');
      projectId = local.getString('pi');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCredentials();

    //create topic
    //publish message to topic
    //create subscription
    // accept creditials
    // pull messages

  }

  String projectId;
  String privateKeyId;
  String privateKey;
  String clientEmail;
  String clientId;
  String type = 'service_account';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pub Sub Text'),
      ),
      body: Container(
          color: Colors.white,
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              TextFormField(
                onChanged: (input ){
                  projectId = input;
                },
                initialValue: projectId == null ? '' : projectId,
                decoration: InputDecoration(
                    hintText: 'project_id',
                    labelText: 'Project ID'
                ),
              ),
              TextFormField(
                onChanged: (input ){
                  privateKeyId = input;
                },
                initialValue: privateKeyId == null ? '' : privateKeyId,
                decoration: InputDecoration(
                  hintText: 'private_key_id',
                  labelText: 'Private Key ID'
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                onChanged: (input ){
                  privateKey = input;
                },
                initialValue: privateKey == null ? '' : privateKey,
                decoration: InputDecoration(
                    hintText: 'private_key',
                    labelText: 'Private Key'
                ),
              ),

              TextFormField(
                onChanged: (input ){
                  clientEmail = input;
                },
                initialValue: clientEmail == null ? '' : clientEmail,
                decoration: InputDecoration(
                    hintText: 'client_email',
                    labelText: 'Client Email'
                ),
              ),

              TextFormField(
                onChanged: (input ){
                  clientId = input;
                },
                initialValue: clientId == null ? '' : clientId,
                decoration: InputDecoration(
                    hintText: 'client_id',
                    labelText: 'Client ID'
                ),
              ),

              TextFormField(
                onChanged: (input ){
                },
                initialValue: type,
                readOnly: true,
                decoration: InputDecoration(
                    hintText: 'type',
                    labelText: 'Type'
                ),
              ),

              SizedBox(
                height: 20,
              ),
              RaisedButton(
                color: Colors.green,
                child: Text('INITIATE',style: TextStyle(color: Colors.white),),
                onPressed: () async {
                  if( projectId != null && projectId != '' && privateKeyId != null && privateKeyId != '' && privateKey != null && privateKey != '' && clientId != null && clientId != '' && clientEmail != null && clientEmail != '') {

                    saveCredentials();

                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) =>
                            ActionsWidget(privateKey: privateKey,
                                privateKeyId: privateKeyId,
                                clientId: clientId,
                                clientEmail: clientEmail,
                                type: type)));
                  } else {
                    print('errors');
                  }
                },
              )
            ],
          )
      ),
    );
  }

  saveCredentials() async {
    SharedPreferences local = await SharedPreferences.getInstance();
    local.setString('pki', privateKeyId);
    local.setString('pk', privateKey);
    local.setString('ce', clientEmail);
    local.setString('ci', clientId);
    local.setString('pi', projectId);
  }
}

