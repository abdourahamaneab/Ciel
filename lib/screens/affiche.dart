import 'package:flutter/material.dart';

class ProgressPage extends StatefulWidget {
  @override
  _ProgressPageState createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> with SingleTickerProviderStateMixin {
late  AnimationController _animationController;
  late Animation<double> _animation;

  String _progressMessage = 'Nous téléchargeons les données...';
  bool _isLoading = true;
  bool _showResults = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() {
        setState(() {
          if (_animationController.status == AnimationStatus.completed) {
            _isLoading = false;
            _showResults = true;
            _progressMessage = 'Téléchargement terminé';
          } else if (_animationController.status == AnimationStatus.forward) {
            final progress = (_animation.value * 100).toInt();
            _progressMessage = 'C\'est presque fini... $progress%';
          }
        });
      });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void startAnimation() {
    setState(() {
      _isLoading = true;
      _showResults = false;
      _progressMessage = 'Nous téléchargeons les données...';
    });
    _animationController.reset();
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Progress Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!_showResults)
              CircularProgressIndicator(
                value: _isLoading ? _animation.value : null,
              ),
            SizedBox(height: 20),
            Text(
              _progressMessage,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            if (_showResults)
              Column(
                children: [
                  ResultTable(),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: startAnimation,
                    child: Text('Recommencer'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class ResultTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Table(
        border: TableBorder.all(),
        children: [
    TableRow(
    children: [
    TableCell(child: Text('Ville')),
    TableCell(child: Text('Température')),
    TableCell(child: Text('Couverture nuageuse')),
    ],
    ),
    TableRow(
    children: [
    TableCell(child: Text('Rennes')),
    TableCell(child: Text('20°C')),
    TableCell(child: Icon(Icons.cloud)),
    ],
    ),
    TableRow(
    children: [
    TableCell(child: Text('Paris')),
    TableCell(child: Text('18°C')),
    TableCell(child: Icon(Icons.cloud)),
    ],
    ),
    TableRow(
    children: [
    TableCell(child: Text('Nantes')),
    TableCell(child: Text('21°C')),
    TableCell(child: Icon(Icons.cloud)),
    ],
    ),
    TableRow(
    children: [
    TableCell(child: Text('Bordeaux')),
    TableCell(child: Text('22°C')),
    TableCell(child: Icon(Icons.cloud)),
    ],
    )
    ],
    );

}

  }
