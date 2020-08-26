import 'package:flutter/material.dart';

class TweenPage extends StatefulWidget{
  createState() => _TweenPageState();
}

class _TweenPageState extends State<TweenPage>
    with SingleTickerProviderStateMixin{

  Duration duration = Duration(seconds: 1);
  AnimationController animationController;
  double end = 100000;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
        duration: duration,
        vsync: this
    )..addListener(() {
      // For any change in Animation Controller State we will re-build the UI
     setState(() {});
    });

    animation = Tween(begin: 0.0, end: end).animate(animationController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("TWEEN PAGE"),
        ),
      body: Center(
        child: Column(
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 240),
              child: Text("Hello ${animation.value.toStringAsFixed(2)}",
                      style: TextStyle(fontSize: 16.0),
              ),
            ),
            RaisedButton(
              child: Text(
                  animationController.status == AnimationStatus.completed ? "REVERSE ANIMATE" : "FORWARD ANIMATE"
              ),
              onPressed: (){
                if(animationController.status == AnimationStatus.completed){
                  animationController.reverse();
                }else{
                  animationController.forward();
                }
              },
            )
          ],
        )
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }
}

class TweenSequencePage extends StatefulWidget{
  createState() => _TweenSequencePageState();
}

class _TweenSequencePageState extends State<TweenSequencePage>
    with SingleTickerProviderStateMixin {

  Duration duration = Duration(seconds: 10);
  AnimationController animationController;
  Animation<Color> animation;

  final colors = <Color>[
    Colors.purpleAccent,
    Colors.indigo,
    Colors.blueAccent,
    Colors.indigoAccent,
    Colors.deepPurpleAccent,
    Colors.deepPurple,
    Colors.purpleAccent,
    Colors.indigo
  ];

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
        duration: duration,
        vsync: this
    );
    
    final tweenSequenceItems = <TweenSequenceItem<Color>>[];
    
    for(int i=0;i<colors.length;i++){
      TweenSequenceItem<Color> item = TweenSequenceItem(
        tween: ColorTween(begin: colors[i], end: colors[(i+1)%colors.length]),
        weight: 1/colors.length    
      );

      tweenSequenceItems.add(item);
    }

    animation = TweenSequence<Color>(tweenSequenceItems).animate(animationController);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tween Sequence Page"),
      ),
      body: Center(
        child: AnimatedBuilder(
          child: Text("ANIMATE", style: TextStyle(color: Colors.white),),
          animation: animation,
          builder: (context, child) {
            return RaisedButton(
              color: animation.value,
              onPressed: () async{
                await animationController.forward();
                animationController.reset();
              },
              child: child,
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }
}

class FadeTransitionPage extends StatefulWidget{
  createState() => _FadeTransitionPageState();
}

class _FadeTransitionPageState extends State<FadeTransitionPage>
    with SingleTickerProviderStateMixin{

  Duration duration = Duration(milliseconds: 600);
  AnimationController animationController;
  CurvedAnimation curvedAnimation;

  Animation<double> animation;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
        duration: duration,
        vsync: this
    );

    curvedAnimation = CurvedAnimation(parent: animationController, curve: Curves.easeIn);

    animation = Tween(begin: 1.0, end: 0.0).animate(curvedAnimation);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TWEEN PAGE"),
      ),
      body: Center(
          child: Column(
            children: [
              FadeTransition(
                opacity: animation,
                child: Icon(
                  Icons.notifications,
                  color: Colors.deepPurpleAccent,
                  size: 120,
                ),
              ),
              RaisedButton(
                child: Text("ANIMATE"),
                onPressed: (){
                  animationController.animateTo(1.0).then<TickerFuture>((value) => animationController.animateBack(0.0));
                },
              )
            ],
          )
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }
}