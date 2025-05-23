class PaymentInfo {
  final String contractCode;
  final String deviceName;
  final String deviceType;
  final String renterName;
  final double amount;

  PaymentInfo({
    required this.contractCode,
    required this.deviceName,
    required this.deviceType,
    required this.renterName,
    required this.amount,
  });
}

class BankTransferInfo {
  final String bankName;
  final String accountNumber;
  final String accountHolder;
  final String qrCodeUrl;
  final String transferContent;

  BankTransferInfo({
    required this.bankName,
    required this.accountNumber,
    required this.accountHolder,
    required this.qrCodeUrl,
    required this.transferContent,
  });
}