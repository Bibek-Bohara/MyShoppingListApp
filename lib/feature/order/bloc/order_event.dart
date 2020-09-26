part of 'order_bloc.dart';

@immutable
abstract class OrderEvent {}

class FetchOrders extends OrderEvent{}
