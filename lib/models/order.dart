class Order {

  Order.fromJson(Map<String, dynamic> json):
      id = json['id'],
      qrCodeImage = json['qrCodeImage'],
      total = json['total'],
      copiaecola = json['copiaecola'],
      due = DateTime.parse(json['due']),
      status = json['status'];





  final String id;
  final String qrCodeImage;
  final num total;
  final String copiaecola;
  final DateTime due;
  final String status;
}