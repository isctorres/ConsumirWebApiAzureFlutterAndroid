import 'package:consumir_web_api/api/api_service.dart';
/// Bar chart example
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Grafica5 extends StatefulWidget {
  Grafica5({Key key}) : super(key: key);

  @override
  _Grafica5State createState() => _Grafica5State();
}

class _Grafica5State extends State<Grafica5> {

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
        title: Text('Bar Chart with Secondary Axis Only Bar Label'),
      ),
      body: isLoading ? Center( child: CircularProgressIndicator() ) : BarChartWithSecondaryAxisOnly.withDataFromApi(),
    );
  }
}



/// Example of using only a secondary axis (on the right) for a set of grouped
/// bars.
///
/// Both series plots using the secondary axis due to the measureAxisId of
/// secondaryMeasureAxisId.
///
/// Note: secondary may flip left and right positioning when
/// RTL.flipAxisLocations is set.
class BarChartWithSecondaryAxisOnly extends StatelessWidget {
  static const secondaryMeasureAxisId = 'secondaryMeasureAxisId';
  final List<charts.Series> seriesList;
  final bool animate;

  BarChartWithSecondaryAxisOnly(this.seriesList, {this.animate});

  factory BarChartWithSecondaryAxisOnly.withSampleData() {
    return new BarChartWithSecondaryAxisOnly(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  factory BarChartWithSecondaryAxisOnly.withDataFromApi() {
    return new BarChartWithSecondaryAxisOnly(
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
    );
  }

  static List<charts.Series<OrdinalSales, String>> _createDataFromApi() {

    return [
      new charts.Series<OrdinalSales, String>(
          id: 'Global Revenue',
          domainFn: (OrdinalSales sales, _) => sales.year,
          measureFn: (OrdinalSales sales, _) => sales.sales,
          data: _Grafica5State.data,
      )
          // Set series to use the secondary measure axis.
        ..setAttribute(charts.measureAxisIdKey, secondaryMeasureAxisId),
    ];
  }

  /// Create series list with multiple series
  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final globalSalesData = [
      new OrdinalSales('2014', 500),
      new OrdinalSales('2015', 2500),
      new OrdinalSales('2016', 1000),
      new OrdinalSales('2017', 7500),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Global Revenue',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: globalSalesData,
      )
        // Set series to use the secondary measure axis.
        ..setAttribute(charts.measureAxisIdKey, secondaryMeasureAxisId),
    ];
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}
