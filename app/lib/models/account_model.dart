// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

AccountResponse welcomeFromJson(String str) => AccountResponse.fromJson(json.decode(str));

String welcomeToJson(AccountResponse data) => json.encode(data.toJson());

class AccountResponse {
    final String? name;
    final String? email;
    final String? password;
    final String? password1;
    final int? id;

    AccountResponse({
        this.name,
        this.email,
        this.password,
        this.password1,
        this.id,
    });

    factory AccountResponse.fromJson(Map<String, dynamic> json) => AccountResponse(
        name: json["name"],
        email: json["email"],
        password: json["password"],
        password1: json["password1"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "password": password,
        "password1": password1,
        "id": id,
    };
}
