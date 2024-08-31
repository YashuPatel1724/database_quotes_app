import 'package:database_quotes_app/controller/quotes_controller.dart';
import 'package:database_quotes_app/view/screens/category_page.dart';
import 'package:database_quotes_app/view/screens/favourite_page.dart';
import 'package:database_quotes_app/view/screens/theme_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

var quotes = Get.put(QuotesController());

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: quotes.fromList(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Stack(
              children: [
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('${quotes.img}'))),
                  child: PageView.builder(
                    itemCount: (quotes.categoryQuotes == null ||
                            quotes.categoryQuotes.isEmpty)
                        ? quotes.allQuotes.length
                        : quotes.categoryQuotes.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Obx(
                        () => Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            (quotes.categoryQuotes == null ||
                                    quotes.categoryQuotes.isEmpty)
                                ? Text(
                                    textAlign: quotes.textAlign.value,
                                    '${quotes.allQuotes[index].quote}',
                                    style: GoogleFonts.getFont(
                                        quotes.googleFont.value,
                                        fontSize: 25,
                                        color: quotes.color.value,
                                        fontWeight: FontWeight.bold))
                                : Text(
                                    textAlign: quotes.textAlign.value,
                                    '${quotes.categoryQuotes[index].quote}',
                                    style: GoogleFonts.getFont(
                                        quotes.googleFont.value,
                                        fontSize: 25,
                                        color: quotes.color.value,
                                        fontWeight: FontWeight.bold)),
                            (quotes.categoryQuotes == null ||
                                    quotes.categoryQuotes.isEmpty)
                                ? Text(
                                    textAlign: quotes.textAlign.value,
                                    '- ${quotes.allQuotes[index].author}',
                                    style: GoogleFonts.getFont(
                                        quotes.googleFont.value,
                                        color: quotes.color.value,
                                        fontSize: 20))
                                : Text(
                                    textAlign: quotes.textAlign.value,
                                    '- ${quotes.categoryQuotes[index].author}',
                                    style: GoogleFonts.getFont(
                                        quotes.googleFont.value,
                                        color: quotes.color.value,
                                        fontSize: 20))
                          ],
                        ),
                      ),
                    ),
                    onPageChanged: (value) {
                      quotes.pageviewIndex(value);
                      print(quotes.pageIndex);
                    },
                  ),
                ),
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                (quotes.categoryQuotes.isEmpty)
                                    ? quotes.checkDoubleQuote(quotes
                                        .allQuotes[quotes.pageIndex.value])
                                    : quotes.checkDoubleQuote(
                                        quotes.categoryQuotes[
                                            quotes.pageIndex.value]);
                                quotes.like(quotes.pageIndex.value);
                                // quotes.checkDoubleQuote(quotes.allQuotes[quotes.pageIndex.value]);
                                // print(quotes.pageIndex);
                              },
                              child: (quotes.allQuotes[quotes.pageIndex.value]
                                          .isLiked ==
                                      '1')
                                  ? Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                      size: 38,
                                    )
                                  : Icon(
                                      Icons.favorite_border,
                                      color: Colors.white,
                                      size: 38,
                                    ),
                            ),
                            Icon(
                              Icons.share,
                              color: Colors.white,
                              size: 38,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 150,
                      )
                    ],
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: Container(
        height: 55,
        width: 55,
        decoration: BoxDecoration(
            // color: Color(0xffE9DEFC),
            shape: BoxShape.circle),
        child: SpeedDial(
          backgroundColor: Colors.white60,
          animatedIcon: AnimatedIcons.menu_close,
          // shape: CircleBorder(),
          direction: SpeedDialDirection.down,
          spacing: 12,
          curve: Curves.easeInCubic,
          animationDuration: Duration(milliseconds: 500),
          gradientBoxShape: BoxShape.circle,
          children: [
            SpeedDialChild(
                shape: CircleBorder(),
                onTap: () {
                  Get.to(() => FavouritePage(),
                      duration: Duration(milliseconds: 500),
                      transition: Transition.leftToRight);
                },
                child: Icon(Icons.favorite_border)),
            SpeedDialChild(
                shape: CircleBorder(),
                onTap: () {
                  Get.to(() => CategoryPage(),
                      duration: Duration(milliseconds: 500),
                      transition: Transition.downToUp);
                },
                child: Icon(Icons.category)),
            SpeedDialChild(
                shape: CircleBorder(),
                onTap: () {
                  Get.to(() => ThemePage(),
                      duration: Duration(milliseconds: 500),
                      transition: Transition.downToUp);
                },
                child: Icon(Icons.image)),
            SpeedDialChild(
                shape: CircleBorder(),
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => Container(
                      height: 350,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Text Alignment',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                  onTap: () {
                                    quotes.alignText(TextAlign.left);
                                  },
                                  child: Icon(
                                    CupertinoIcons.text_alignleft,
                                    color: Colors.black,
                                    size: 32,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    quotes.alignText(TextAlign.center);
                                  },
                                  child: Icon(
                                    CupertinoIcons.text_aligncenter,
                                    color: Colors.black,
                                    size: 32,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    quotes.alignText(TextAlign.right);
                                  },
                                  child: Icon(
                                    CupertinoIcons.text_alignright,
                                    color: Colors.black,
                                    size: 32,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Font Family',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  ...List.generate(
                                    quotes.fontFamilyList.length,
                                    (index) => InkWell(
                                      onTap: () {
                                        // setState(() {
                                        //   googleFont = fontFamilyList[index];
                                        // });
                                        quotes.fontFamily(index);
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        margin: EdgeInsets.all(10),
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                        ),
                                        child: Text(
                                          "Aa",
                                          style: GoogleFonts.getFont(
                                              quotes.fontFamilyList[index],
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              'Text Color',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (context) => SimpleDialog(
                                          title: const Text(
                                            'Pick Color',
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          children: [
                                            HueRingPicker(
                                              pickerColor: quotes.color.value,
                                              onColorChanged: (value) {
                                                quotes.color.value = value;
                                              },
                                            ),
                                            Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 20.0),
                                                  child: ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text(
                                                        'Save',
                                                        style: TextStyle(
                                                            color: Colors.blue,
                                                            fontSize: 20),
                                                      )),
                                                )),
                                          ],
                                        ),
                                      );
                                    },
                                    child: Container(
                                      margin: EdgeInsets.all(10),
                                      height: 50,
                                      width: 50,
                                      decoration: const BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                                'assets/theme/360_F_411988337_xATUqAB8GmwZBMEbjqOg0lrVAcjSc5qP-removebg-preview.png'),
                                          ),
                                          shape: BoxShape.circle),
                                    ),
                                  ),
                                  ...List.generate(
                                    quotes.colorList.length,
                                    (index) => InkWell(
                                      onTap: () {
                                        quotes.colorPick(index);
                                      },
                                      child: Container(
                                        margin: EdgeInsets.all(10),
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            color: quotes.colorList[index],
                                            shape: BoxShape.circle),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                child: Icon(Icons.text_fields_sharp))
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }
}
