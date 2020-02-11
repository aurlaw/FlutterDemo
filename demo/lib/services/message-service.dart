import 'dart:convert';
import 'package:FlutterDemo/models/message.dart';
import 'package:http/http.dart' as http;


class MessageService {
  final String _endpoint = "https://display.gatesmanagency.com/api/message";
  MessageService();

  Future<List<Message>> getMessages() async {
    final response = await http.get((_endpoint));
    if(response.statusCode == 200) {
      // print(response.body);
      List jsonResponse = json.decode(response.body);
      // print(jsonResponse);
      return jsonResponse.map((m) => Message.fromMap(m)).toList();
    } else {
      throw Exception('Failed to load messages');
    }
  }
}
