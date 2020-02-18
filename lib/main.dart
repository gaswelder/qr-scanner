import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:qr_flutter/qr_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR Scanner',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'QR Scanner'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String code = '';

  _scan() {
    scanner.scan().then((val) {
      setState(() {
        code = val;
      });
    });
  }

  _enter() {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
              title: Text("Enter value"),
              contentPadding: EdgeInsets.fromLTRB(12, 16, 12, 10),
              children: <Widget>[
                TextField(
                  autofocus: true,
                  onSubmitted: (value) {
                    Navigator.pop(context, value);
                  },
                ),
              ]);
        }).then((String value) {
      if (value == null) {
        return;
      }
      setState(() {
        code = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Code(value: code),
            RaisedButton(child: Text("Enter Manually"), onPressed: _enter)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _scan,
        child: Icon(Icons.add),
      ),
    );
  }
}

class Code extends StatelessWidget {
  final String value;
  Code({this.value});

  @override
  Widget build(BuildContext context) {
    if (value == '') {
      return Container();
    }
    return Column(
      children: <Widget>[
        QrImage(
          data: value,
          version: QrVersions.auto,
          size: 200.0,
        ),
        Text(value),
      ],
    );
  }
}
