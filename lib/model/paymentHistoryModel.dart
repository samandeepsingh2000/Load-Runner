// To parse this JSON data, do
//
//     final paymentHistoryModel = paymentHistoryModelFromJson(jsonString);

import 'dart:convert';

List<PaymentHistoryModel> paymentHistoryModelFromJson(String str) => List<PaymentHistoryModel>.from(json.decode(str).map((x) => PaymentHistoryModel.fromJson(x)));

String paymentHistoryModelToJson(List<PaymentHistoryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PaymentHistoryModel {
  PaymentHistoryModel({
    this.id,
    this.walletId,
    this.userId,
    this.amount,
    this.transactionType,
    this.status,
    this.approved,
    this.startDate,
    this.v,
  });

  String? id;
  String? walletId;
  String? userId;
  int? amount;
  String? transactionType;
  String? status;
  String? approved;
  DateTime? startDate;
  int? v;

  factory PaymentHistoryModel.fromJson(Map<String, dynamic> json) => PaymentHistoryModel(
    id: json["_id"],
    walletId: json["walletId"],
    userId: json["userId"],
    amount: json["amount"],
    transactionType: json["transactionType"],
    status: json["status"],
    approved: json["approved"],
    startDate: DateTime.parse(json["startDate"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "walletId": walletId,
    "userId": userId,
    "amount": amount,
    "transactionType": transactionType,
    "status": status,
    "approved": approved,
    "startDate": startDate!.toIso8601String(),
    "__v": v,
  };
}
