import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'Functions/chargement.dart';
import 'class/message.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key, required this.title});
  final String title;
  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  Widget createWidget(Message message) {
    return Column();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
