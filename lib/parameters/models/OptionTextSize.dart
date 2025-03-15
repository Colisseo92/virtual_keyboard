enum OptionTextSize{
  small(display:"small",number:0,factor:0.6),
  medium(display:"medium",number:1,factor:0.8),
  large(display:"large",number:2,factor:1.0),
  none(display:"none",number:-1,factor:-1.0);

  const OptionTextSize({
    required this.display,
    required this.number,
    required this.factor,
  });

  final String display;
  final int number;
  final double factor;

  static OptionTextSize fromString(String value){
    return OptionTextSize.values.firstWhere((e) => e.display == value, orElse: () => OptionTextSize.none);
  }

  static OptionTextSize fromNumber(int value){
    return OptionTextSize.values.firstWhere((e) => e.number == value, orElse: () => OptionTextSize.none);
  }
}