import 'dart:convert';
import 'package:FlutterDemo/models/message.dart';
import 'package:http/http.dart' as http;


class MessageService {
  final String _endpoint = "http://gatesman-display.win1.dev.gatesmanagency.com/api/message";
  MessageService();

  Future<List<Message>> getMessages() async {
    final response = await http.get((_endpoint));
    if(response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((m) => Message.fromJson(m)).toList();
    } else {
      throw Exception('Failed to load messages');
    }
  }
}
