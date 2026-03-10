enum TaxType { income, gst }

extension TaxTypeExtension on TaxType {
  String get title {
    switch (this) {
      case TaxType.income:
        return 'Income Tax Calculator';
      case TaxType.gst:
        return 'GST Calculator';
    }
  }
}
