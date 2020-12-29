import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Typing App',
      home: TypingPage(),
    );
  }
}

class TypingPage extends StatefulWidget {
  TypingPage({Key key}) : super(key: key);

  @override
  _TypingPageState createState() => _TypingPageState();
}

class _TypingPageState extends State<TypingPage> {
  TextEditingController _controller;
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Typing'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: TextFormField(
              key: Key('your-text-field'),
              controller: _controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Your Text',
              ),
              validator: (value) =>
                  value.isEmpty ? 'Input at least one character' : null,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_forward),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return DisplayPage(
                    displayText: _controller.text,
                    doOnInit: () => Future.microtask(() => _controller.clear()),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}

class DisplayPage extends StatefulWidget {
  final String displayText;
  final void Function() doOnInit;

  const DisplayPage({
    @required this.displayText,
    @required this.doOnInit,
    Key key,
  }) : super(key: key);

  @override
  _DisplayPageState createState() => _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {
  @override
  void initState() {
    super.initState();
    widget.doOnInit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Display'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Text(
            widget.displayText,
            style: TextStyle(fontSize: 32),
          ),
        ),
      ),
    );
  }
}
