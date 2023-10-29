import 'individual_bar.dart';

class BarData {
  final double JanuaryAmount;
  final double FebruaryAmount;
  final double MarchAmount;
  final double AprilAmount;
  final double MayAmount;
  final double JuneAmount;
  final double JulyAmount;
  final double AugustAmount;
  final double SeptemberAmount;
  final double OctoberAmount;
  final double NovemberAmount;
  final double DecemberAmount;

  BarData({
    required this.JanuaryAmount,
    required this.FebruaryAmount,
    required this.MarchAmount,
    required this.AprilAmount,
    required this.MayAmount,
    required this.JuneAmount,
    required this.JulyAmount,
    required this.AugustAmount,
    required this.SeptemberAmount,
    required this.OctoberAmount,
    required this.NovemberAmount,
    required this.DecemberAmount,
  });

  List<BarGraph> barData = [];

  void initializeBarData() {
    barData = [
      BarGraph(x: 0, y: JanuaryAmount),
      BarGraph(x: 1, y: FebruaryAmount),
      BarGraph(x: 2, y: MarchAmount),
      BarGraph(x: 3, y: AprilAmount),
      BarGraph(x: 4, y: MayAmount),
      BarGraph(x: 5, y: JuneAmount),
      BarGraph(x: 6, y: JulyAmount),
      BarGraph(x: 7, y: AugustAmount),
      BarGraph(x: 8, y: SeptemberAmount),
      BarGraph(x: 9, y: OctoberAmount),
      BarGraph(x: 10, y: NovemberAmount),
      BarGraph(x: 11, y: DecemberAmount),
    ];
  }
}
