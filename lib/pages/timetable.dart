import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:resentral_flutter/pages/timetable_colours.dart';

class Timetable extends StatefulWidget {
  const Timetable({Key? key}) : super(key: key);

  @override
  State<Timetable> createState() => _TimetableState();
}

class _TimetableState extends State<Timetable> {
  var client = http.Client();

  Future<DTimetable>? _dtimetable;

  @override
  void initState() {
    setState(() {
      _dtimetable = getFromRemote(PLACEHOLDER);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: timetableBody(),
      ),
    );
  }

  FutureBuilder<DTimetable> timetableBody() {
    return FutureBuilder<DTimetable>(
      future: _dtimetable,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Response> response = snapshot.data!.response;
          List<SizedBox> content = [];
          for (int i = 0; i < response.length; i++) {
            content.add(
              SizedBox(
                height: 148,
                child: Card(
                  elevation: 8,
                  margin: const EdgeInsets.fromLTRB(6, 16, 6, 0),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: getColours(response[i].subject),
                      width: 5,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          response[i].responseClass + ", " + response[i].period,
                          style: const TextStyle(
                              fontSize: 21, fontWeight: FontWeight.w600),
                        ),
                        subtitle: Text(
                            response[i].room +
                                "\n" +
                                response[i].teacher +
                                "\n\n" +
                                "time",
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.w400)),
                      )
                    ],
                  ),
                ),
              ),
            );
          }
          return RefreshIndicator(
            // TODO: make the refresh work
            // NOTE: needs the get shared preferences to work
            onRefresh: () async {
              setState(() {
                _dtimetable = getFromRemote('jackson.ly', '192837465');
              });
            },
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            child: ListView.builder(
              itemCount: content.length,
              itemBuilder: (BuildContext context, int index) {
                return content[index];
              },
            ),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return CircularProgressIndicator.adaptive(
            valueColor: AlwaysStoppedAnimation<Color>(
                Theme.of(context).colorScheme.onSurfaceVariant));
      },
    );
  }
}

Future<DTimetable> getFromRemote(String username, String password) async {
  final String url =
      'https://resentral-server.herokuapp.com/api/daily_timetable/' +
          const Uuid().v4().toString();
  final response = await http.post(
    Uri.parse(url),
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: jsonEncode(<String, dynamic>{
      'username': username,
      'password': password,
    }),
  );
  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return DTimetable.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create list.');
  }
}

// Classes for utilising the JSON response

DTimetable dTimetableFromJson(String str) =>
    DTimetable.fromJson(json.decode(str));

String dTimetableToJson(DTimetable data) => json.encode(data.toJson());

class DTimetable {
  DTimetable({
    required this.response,
  });

  List<Response> response;

  factory DTimetable.fromJson(Map<String, dynamic> json) => DTimetable(
        response: List<Response>.from(
            json["response"].map((x) => Response.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "response": List<dynamic>.from(response.map((x) => x.toJson())),
      };
}

class Response {
  Response({
    required this.period,
    required this.subject,
    required this.responseClass,
    required this.room,
    required this.teacher,
  });

  String period;
  String subject;
  String responseClass;
  String room;
  String teacher;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        period: json["period"],
        subject: json["subject"],
        responseClass: json["class"],
        room: json["room"],
        teacher: json["teacher"],
      );

  Map<String, dynamic> toJson() => {
        "period": period,
        "subject": subject,
        "class": responseClass,
        "room": room,
        "teacher": teacher,
      };
}