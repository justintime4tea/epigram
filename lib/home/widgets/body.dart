import 'package:epigram/app/models.dart';
import 'package:epigram/colors.dart';
import 'package:epigram/home/view_models.dart';
import 'package:epigram/messages/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _homeBody2;
  }

  Widget get _homeBody2 {
    return StoreConnector<AppState, HomeViewModel>(
      converter: HomeViewModel.fromStore,
      builder: (context, vm) {
        List<Quip> quips = vm.quips.reversed.toList();
        return CustomScrollView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return _quip2(quips[index]);
                },
                childCount: quips.length,
              ),
            ),
          ],
        );
      },
    );
  }

  Widget get _homeBody {
    return StoreConnector<AppState, HomeViewModel>(
      converter: HomeViewModel.fromStore,
      builder: (context, vm) {
        return Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
            // Column is also a layout widget. It takes a list of children and
            // arranges them vertically. By default, it sizes itself to fit its
            // children horizontally, and tries to be as tall as its parent.
            //
            // Invoke "debug painting" (press "p" in the console, choose the
            // "Toggle Debug Paint" action from the Flutter Inspector in Android
            // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
            // to see the wireframe for each widget.
            //
            // Column has various properties to control how it sizes itself and
            // how it positions its children. Here we use mainAxisAlignment to
            // center the children vertically; the main axis here is the vertical
            // axis because Columns are vertical (the cross axis would be
            // horizontal).
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Divider(
                height: 2,
                thickness: 2,
                indent: 0,
                endIndent: 0,
                color: Colors.white30,
              ),
              Padding(
                padding: EdgeInsets.zero,
                child: _quips(vm.quips),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _quips(List<Quip> quips) {
    return Column(
      children: <Widget>[
        ...quips.map(
          (q) => _quip2(q),
        )
      ],
    );
  }

// Material(
//           type: MaterialType.card,
//           shadowColor: shadowColor ?? cardTheme.shadowColor ?? theme.shadowColor,
//           color: color ?? cardTheme.color ?? theme.cardColor,
//           elevation: elevation ?? cardTheme.elevation ?? _defaultElevation,
//           shape: shape ?? cardTheme.shape ?? const RoundedRectangleBorder(
//             borderRadius: BorderRadius.all(Radius.circular(4.0)),
//           ),
//           borderOnForeground: borderOnForeground,
//           clipBehavior: clipBehavior ?? cardTheme.clipBehavior ?? Clip.none,
//           child: Semantics(
//             explicitChildNodes: !semanticContainer,
//             child: child,
//           ),
//         )
  Widget _quip2(Quip quip) {
    return Center(
      child: Material(
        color: black,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              isThreeLine: true,
              minVerticalPadding: 0,
              leading: const Icon(
                Icons.donut_large,
                size: 48,
                color: white,
              ),
              title: Text(
                quip.username,
                style: const TextStyle(
                  color: white,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  letterSpacing: 1.2,
                ),
              ),
              subtitle: Text(
                quip.message,
                style: const TextStyle(
                  color: white,
                  fontSize: 12,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const SizedBox(width: 32),
                  IconButton(
                    icon: const Icon(Icons.messenger_outline),
                    iconSize: 18,
                    color: white,
                    onPressed: () {/* ... */},
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.all_inclusive_outlined),
                    iconSize: 18,
                    color: white,
                    onPressed: () {},
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.whatshot_outlined),
                    iconSize: 18,
                    color: white,
                    onPressed: () {/* ... */},
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.share_outlined),
                    iconSize: 18,
                    color: white,
                    onPressed: () {/* ... */},
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ),
            const Divider(
              height: 1,
              thickness: 1,
              indent: 0,
              endIndent: 0,
              color: Colors.white24,
            ),
          ],
        ),
      ),
    );
  }

  Widget _quip(Quip quip) {
    return Row(
      children: [
        _padRow(Text(
          quip.id,
          style: const TextStyle(
            color: white,
          ),
        )),
        _padRow(Text(
          quip.userId,
          style: const TextStyle(
            color: white,
          ),
        )),
        _padRow(Text(
          quip.message,
          style: const TextStyle(
            color: white,
          ),
        )),
        _padRow(Text(
          quip.timestamp,
          style: const TextStyle(
            color: white,
          ),
        ))
      ],
    );
  }

  Widget _padRow(Widget row) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: row,
    );
  }
}
