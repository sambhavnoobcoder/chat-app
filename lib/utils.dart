import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

void sendREQ(TextEditingController ctlr, queue) {
  http.post(
    Uri.parse('http://141.148.198.149:7777/newMessage'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({
      "status": "ok",
      "channel": "divya",
      "ID": 69,
      "body": ctlr.text,
      "queue": queue
    }),
  );
}
