import 'dart:convert';

import 'package:flutter/material.dart';

void sendREQ(TextEditingController ctlr, queue) {
  var http;
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
