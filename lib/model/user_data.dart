
import 'dart:convert';

UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));

String userDataToJson(UserData data) => json.encode(data.toJson());

class UserData {
    UserData({
        required this.result,
        required this.userId,
        required this.encId,
        required this.xsId,
        required this.accessToken,
        required this.refreshToken,
    });

    bool result;
    int userId;
    String encId;
    String xsId;
    String accessToken;
    String refreshToken;

    factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        result: json["result"] == null ? null : json["result"],
        userId: json["user_id"] == null ? null : json["user_id"],
        encId: json["enc_id"] == null ? null : json["enc_id"],
        xsId: json["xs_id"] == null ? null : json["xs_id"],
        accessToken: json["accessToken"] ?? "",
        refreshToken: json["refreshToken"] ?? "",
    );

    Map<String, dynamic> toJson() => {
        "result": result == null ? null : result,
        "user_id": userId == null ? null : userId,
        "enc_id": encId == null ? null : encId,
        "xs_id": xsId == null ? null : xsId,
        "accessToken": accessToken,
        "refreshToken": refreshToken,
    };
}
