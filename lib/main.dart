import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: firstpage(),
  ));
}
                                                          // map ni andsar list eni andar map
class firstpage extends StatefulWidget {
  const firstpage({Key? key}) : super(key: key);

  @override
  State<firstpage> createState() => _firstpageState();
}
                                                       // map ni andar list hoy tyare
class _firstpageState extends State<firstpage> {

  viveresponce? ll;
  bool status = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewdata();
  }

  Future<void> viewdata() async {
    var url = Uri.parse('https://invicainfotech.com/apicall/mydata');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');


    var rr = jsonDecode(response.body);
    ll = viveresponce.fromJson(rr);

    setState(() {
     status=true;
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: status?ListView.builder(
        itemCount: ll!.contacts!.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              onTap: () {
                setState(() {
                  ll!.contacts!.removeAt(index);
                });
              },
              title: Text("${ll!.contacts![index].name}"),
              subtitle: Text("${ll!.contacts![index].id}"),
              leading: Expanded(
                child: ClipRect(
                    child: Image.network("${ll!.contacts![index].userimage}")),
              ),
            ),
          );
        },
      ):Center(child: CircularProgressIndicator()),
    );
  }
}

class viveresponce {
  List<Contacts>? contacts;

  viveresponce({this.contacts});

  viveresponce.fromJson(Map json) {
    if (json['contacts'] != null) {
      contacts = <Contacts>[];
      json['contacts'].forEach((v) {
        contacts!.add(new Contacts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.contacts != null) {
      data['contacts'] = this.contacts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Contacts {
  String? id;
  String? name;
  String? email;
  String? userimage;
  String? address;
  String? gender;
  Phone? phone;

  Contacts(
      {this.id,
      this.name,
      this.email,
      this.userimage,
      this.address,
      this.gender,
      this.phone});

  Contacts.fromJson(Map <String , dynamic>json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    userimage = json['userimage'];
    address = json['address'];
    gender = json['gender'];
    phone = json['phone'] != null ? new Phone.fromJson(json['phone']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['userimage'] = this.userimage;
    data['address'] = this.address;
    data['gender'] = this.gender;
    if (this.phone != null) {
      data['phone'] = this.phone!.toJson();
    }
    return data;
  }
}

class Phone {
  String? mobile;
  String? home;

  Phone({this.mobile, this.home});

  Phone.fromJson(Map<String, dynamic> json) {
    mobile = json['mobile'];
    home = json['home'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobile'] = this.mobile;
    data['home'] = this.home;
    return data;
  }
}
