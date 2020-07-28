/// Simple pie chart with outside labels example.
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:consumir_web_api/api/api_service.dart';
import 'package:flutter/material.dart';

class Grafica4 extends StatefulWidget {
  Grafica4({Key key}) : super(key: key);

  @override
  _Grafica4State createState() => _Grafica4State();
}

class _Grafica4State extends State<Grafica4> {

  ApiService apiservice;
  static List<OrdinalSales> data;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    apiservice = ApiService();
    //var materias = apiservice.getMaterias(); 
    getAllMaterias();
  }

  void getAllMaterias() async {
    data = List();
    var materias = await apiservice.getMaterias();
    setState(() {
        materias.forEach((element) { data.add(new OrdinalSales(element.Nombre, element.Calificacion));});
        isLoading = false;
    }); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Font Size & Color'),
      ),
      body: isLoading ? Center( child: CircularProgressIndicator() ) : CustomFontSizeAndColor.withDataFromApi(),
    );
  }
}

/// Example of using a custom primary measure and domain axis replacing the
/// renderSpec with one with a custom font size and a custom color.
///
/// There are many axis styling options in the SmallTickRenderer allowing you
/// to customize the font, tick lengths, and offsets.
class CustomFontSizeAndColor extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  CustomFontSizeAndColor(this.seriesList, {this.animate});

  factory CustomFontSizeAndColor.withSampleData() {
    return new CustomFontSizeAndColor(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  factory CustomFontSizeAndColor.withDataFromApi() {
    return new CustomFontSizeAndColor(
      _createDataFromApi(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      animate: animate,

      /// Assign a custom style for the domain axis.
      ///
      /// This is an OrdinalAxisSpec to match up with BarChart's default
      /// ordinal domain axis (use NumericAxisSpec or DateTimeAxisSpec for
      /// other charts).
      domainAxis: new charts.OrdinalAxisSpec(
          renderSpec: new charts.SmallTickRendererSpec(

              // Tick and Label styling here.
              labelStyle: new charts.TextStyleSpec(
                  fontSize: 15, // size in Pts.
                  color: charts.Color.black),

              // Change the line colors to match text color.
              lineStyle: new charts.LineStyleSpec(
                  color: charts.MaterialPalette.black))),

      /// Assign a custom style for the measure axis.
      primaryMeasureAxis: new charts.NumericAxisSpec(
          renderSpec: new charts.GridlineRendererSpec(

              // Tick and Label styling here.
              labelStyle: new charts.TextStyleSpec(
                  fontSize: 18, // size in Pts.
                  color: charts.MaterialPalette.black),

              // Change the line colors to match text color.
              lineStyle: new charts.LineStyleSpec(
                  color: charts.MaterialPalette.black))),
    );
  }

  static List<charts.Series<OrdinalSales, String>> _createDataFromApi() {

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Global Revenue',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: _Grafica4State.data,
      )
    ];
  }

  /// Create series list with single series
  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final globalSalesData = [
      new OrdinalSales('2014', 5000),
      new OrdinalSales('2015', 25000),
      new OrdinalSales('2016', 100000),
      new OrdinalSales('2017', 750000),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Global Revenue',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: globalSalesData,
      ),
    ];
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}