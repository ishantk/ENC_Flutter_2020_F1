import 'package:flutter/material.dart';
import 'dart:math';
/*
Animations in Flutter
	We can enrich the user experience

	Animation
		-> the animation object to animate the widget
		   maintains animation state | start, stop, move, forward and reverse

	AnimationController
		manages animation object

	CurvedAnimation
		non linear animation

	Tween
		eg: changing the color of some view from red to green may be

	Listener
		basically to maintain and monitor states of animation to perform some action

	Implicit Animaitions
		Here, we are give set of AnimationWidgets which we can use and diretly work
		eg: Container ==> AnimatedContainer
		    Padding ==> AnimatedPadding
		    Opacity ==> AnimatedOpacity
		    .
		    ...
		    .....

		For Some of the built-in widgets, we have Animated Versions
		and we call them as Implcit Animations

	Explicit Animations
		As a developer we create few ways to achieve some probable animation sequence
			Animation
			AnimationController
			Curve

	Lottie
		Get an animation effect which is pre-built
		https://lottiefiles.com/

		Download JSON
		And use it with the pub -> lottie in your app :)

	Hero Animation
		Where one of the widget is common between 2 different UIs
		And keeping that widget central, we manage some animation effect

	Staggered Animations
		Sequence of Animations which will be overlapped to each other

	PS: Animations are suppose to be Stateful Widgets as UI will change its behaviours
	    So, always create animations in separate widgets
 */

class AnimationPage extends StatefulWidget{
  createState() => _AnimatedContainerPageState();
}

class _AnimatedContainerPageState extends State<AnimationPage>{

  Color color;
  double borderRadius;
  double margin;

  void changeProperties(){
    color = Color(0xFFFFFFFF & Random().nextInt(0xFFFFFFFF));
    borderRadius = Random().nextDouble() * 128;
    margin = Random().nextDouble() * 128;
  }

  @override
  void initState() {
    super.initState();
    changeProperties();
  }

  void animate(){
    setState(() {
      changeProperties();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AnimatedContainerPage"),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: SizedBox(
                width: 256,
                height: 256,
                child: AnimatedContainer(
                  margin: EdgeInsets.all(margin),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(borderRadius)
                  ),
                  duration: Duration(milliseconds: 500),
                ),
              ),
            ),
            RaisedButton(
              child: Text("Animate Container"),
              onPressed: () => animate(),
            )
          ],
        ),
      ),
    ); 
  }
}

Route getAnimatedRoute(Widget page){

  return PageRouteBuilder<SlideTransition>(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var tween = Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset.zero);
      var curveTween = CurveTween(curve: Curves.ease);
      
      return SlideTransition(
        position: animation.drive(curveTween).drive(tween),
        child: child,
      );
    },
  );

}

class PageOne extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Page One"),
        ),
        body: Center(
          child: RaisedButton(
            child: Text("Navigate to Page Two"),
            onPressed: (){
              Navigator.of(context).push(getAnimatedRoute(PageTwo()));
            },
          ),
        )
    );
  }
}

class PageTwo extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Page Two"),
        ),
        body: Center(
          child: Text("Welcome to Page Two"),
        )
    );
  }
}

class AnimationControllerPage extends StatefulWidget{
  createState() => _AnimationControllerPageState();
}

class _AnimationControllerPageState extends State<AnimationControllerPage>
    with SingleTickerProviderStateMixin{

  // SingleTickerProviderStateMixin -> AnimationController will now optimize the resources in case
  // widget is not visible on the UI i.e. animation must not play in the background

  Duration duration = Duration(seconds: 1);
  AnimationController controller;

  @override
  void initState() {
    super.initState();

    // why we have put two .. and what this operator means :)

    controller = AnimationController(duration: duration, vsync: this)
      ..addListener(() {
      setState(() {

      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Animation Controller"),
        ),
        body: Center(
          child: Column(
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 200,),
                child: Text(
                    "Welcome ${controller.value.toStringAsFixed(2)}",
                    style: Theme.of(context).textTheme.headline4,
                    textScaleFactor: 1 + controller.value,
                ),
              ),
              RaisedButton(
                child: Text("ANIMATE"),
                onPressed: (){
                  if(controller.status == AnimationStatus.completed){
                    controller.reverse(); // start the animation from 1 to 0
                  }else{
                    controller.forward(); // start the animation from 0 to 1
                  }
                },
              )
            ],
          ),
        ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
}
