import 'package:flutter/material.dart';

class PaymentMethodModel {
  final String id;
  final String name;
  final String asset; 
  final IconData fallbackIcon; 
  final Color fallbackColor;

  const PaymentMethodModel({
    required this.id,
    required this.name,
    required this.asset,
    required this.fallbackIcon,
    required this.fallbackColor,
  });
}