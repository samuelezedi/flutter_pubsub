import 'package:flutter/material.dart';

class AllTopics extends StatefulWidget {
  var projectId;
  var pubSub;
  var credentials;
  var scope;
  AllTopics({this.projectId, this.pubSub, this.credentials, this.scope});
  @override
  _AllTopicsState createState() => _AllTopicsState();
}

class _AllTopicsState extends State<AllTopics> {

  bool hasData = false;
  var data = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.projectId);
    print(widget.pubSub);
    widget.pubSub.projects.topics.list('projects/${widget.projectId}').then((value) {
      setState(() {
        hasData = true;
      });
      value.topics.map((e){
        print(e.name);
        setState(() {

        });
      }).toList();
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Topics'),
      ),
      body: Container(
        child: hasData ? ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index){
            return Text('df');
          },
        ) : Container(),
      ),
    );
  }
}
