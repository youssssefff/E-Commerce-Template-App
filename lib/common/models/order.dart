import 'package:shop/common/models/orderItem.dart';
class OrderModel {
  final String city; // City of the order
  final String postalCode; // Postal code of the order
  final String country; // Country of the order
  final String phone; // Phone number associated with the order
  final String paymentId; // Payment ID for the order
  final double totalAmount; // Total amount of the order
  final String status; // Status of the order
  final List<String> statusHistory; // Status history of the order
  final DateTime dateOrdered; // Date when the order was placed
  final String userId; // User ID associated with the order
  final List<OrderItem> orderItems; // List of items in the order

  OrderModel({
    required this.city,
    required this.postalCode,
    required this.country,
    required this.phone,
    required this.paymentId,
    required this.totalAmount,
    required this.status,
    required this.statusHistory,
    required this.dateOrdered,
    required this.userId,
    required this.orderItems,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      city: json['city'],
      postalCode: json['postalCode'],
      country: json['country'],
      phone: json['phone'],
      paymentId: json['paymentId'],
      totalAmount: json['totalAmount'].toDouble(),
      status: json['status'],
      statusHistory: List<String>.from(json['statusHistory']),
      dateOrdered: DateTime.parse(json['dateOrdered']),
      userId: json['userId'],
      orderItems: (json['orderItems'] as List<dynamic>)
          .map((item) => OrderItem.fromJson(item as Map<String, dynamic>)) // Cast to Map<String, dynamic>
          .toList(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'postalCode': postalCode,
      'country': country,
      'phone': phone,
      'paymentId': paymentId,
      'totalAmount': totalAmount,
      'status': status,
      'statusHistory': statusHistory,
      'dateOrdered': dateOrdered.toIso8601String(),
      'userId': userId,
      'orderItems': orderItems.map((item) => item.toJson()).toList(),
    };
  }
}
