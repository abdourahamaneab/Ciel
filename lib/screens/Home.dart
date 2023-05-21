
import 'package:ciel/screens/affiche.dart';
import 'package:flutter/material.dart';

class  Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          const  Text('Bienvenue',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),


            const SizedBox(height: 20),


            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
              )
              ,
              onPressed: () {

                // Action à effectuer lorsque le bouton est cliqué
              },
              child: const Text( 'Commencer',style: TextStyle(fontSize: 18),
              ),
            ),


            const SizedBox(height: 20),


            const  Text('cliquez sur le bouton pour connaitre la méteo',
              style: TextStyle(
                fontSize: 15,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),


          ],
        ),
      ),
    );
  }
}

/*
class  Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 10),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void startAnimation() {
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        centerTitle: true,

        title: const Text('Ciel')
        ,
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: startAnimation,
              child: Text('Start Animation'),
            ),
            SizedBox(height: 20),
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return LinearProgressIndicator(
                  value: _animationController.value,
                  backgroundColor: Colors.grey[200],
                  minHeight: 20,
                );
              },
            ),
            SizedBox(height: 20),
            //un text qui vas changer toute les 10 secondes et qui s arrete quand on appuie sur l animation termine
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Text(
                  '${(_animationController.value * 100).round()}%',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
*/
//  la barre dois contenir un pourcentage ,a chaque fois qu on appuie sur le boutton  la barre recommence le pourcentage aussi et e, dessous de celui ci ya un texte qui change en fonction du pourcentage en disant
