import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
          children: [
               const Card(
                  margin: EdgeInsets.all(8.0),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 5.0,
                  child: Image(
                  image: NetworkImage(
                  'https://image.freepik.com/free-photo/impressed-surprised-man-points-away-blank-space_273609-40694.jpg'),
                  fit: BoxFit.cover,
                  height: 200.0,
                  width: double.infinity,
                  ),
                  ),

               ListView.separated(
                 shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context,index) => const SizedBox(height: 0.0,),
                  itemCount: 10,
                  itemBuilder:(context,index)=> buildPostItem(context),

      ),
          ]
      ),
    );
  }

  Widget buildPostItem(context) {
    return Column(
      children: [
        Card(
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            elevation: 5.0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 22.0,
                        backgroundImage: NetworkImage(
                          'https://image.freepik.com/free-photo/photo-positive-european-female-model-makes-okay-gesture-agrees-with-nice-idea_273609-25629.jpg',
                        ),
                      ),
                      const SizedBox(
                        width: 12.0,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Mahmoud Nabil',
                                  style: Theme
                                      .of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(height: 1.3),
                                ),
                                const SizedBox(
                                  width: 5.0,
                                ),
                                const Icon(
                                  Icons.check_circle,
                                  color: Colors.blue,
                                  size: 16.0,
                                ),
                              ],
                            ),
                            Text(
                              'October 19, 2021 at 10:23 PM',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(height: 1.3),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.more_horiz),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.symmetric(vertical: 7.0),
                    child: Container(
                      height: 1,
                      width: double.infinity,
                      color: Colors.grey[300],
                    ),
                  ),
                  Text(
                    'Sometimes to understand a word\'s meaning you need more than a definition; you need to see the word used in a sentence. At YourDictionary, we give you the tools to learn what a word means and how to use it correctly.With this sentence maker, simply type a word in the search bar and see a variety of sentences with that word used in its different ways.',
                    style: Theme
                        .of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(height: 1.4, fontSize: 15.0),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  const Image(
                    image: NetworkImage(
                        'https://image.freepik.com/free-photo/girl-with-megaphone-jumping-shouting_8087-2707.jpg'),
                    height: 150.0,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  SizedBox(
                    height: 25.0,
                    child: Row(
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: () {

                              },
                              child: const Icon(
                                Icons.favorite,
                                color: Colors.red,
                                size: 22.0,
                              ),

                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            InkWell(
                              onTap: () {

                              },
                              child: Text(
                                '1200',
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                    color: Colors.grey[700]),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {

                              },
                              child: const Icon(
                                Icons.message,
                                color: Colors.green,
                                size: 22.0,
                              ),
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            InkWell(
                              onTap: () {

                              },
                              child: Text(
                                '132  comments',
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(
                                    color: Colors.grey[700]),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        InkWell(
                          onTap: () {

                          },
                          child: const Icon(
                            Icons.share,
                            color: Colors.grey,
                            size: 22.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(top: 3.0, bottom: 10.0),
                    child: Container(
                      height: 1,
                      width: double.infinity,
                      color: Colors.grey[300],
                    ),
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {

                        },
                        child: const CircleAvatar(
                          radius: 18.0,
                          backgroundImage: NetworkImage(
                            'https://image.freepik.com/free-photo/photo-positive-european-female-model-makes-okay-gesture-agrees-with-nice-idea_273609-25629.jpg',
                          ),
                        ),
                      ),
                      const SizedBox(width: 15.0,),
                      Column(
                        children: [
                          Container(
                            child: InkWell(
                              onTap: (){

                              },
                                child: Text('write a comment ...', style: Theme
                                    .of(context)
                                    .textTheme
                                    .bodyText2,),
                              ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            )),
        const SizedBox(height: 10.0),
      ],
    );
  }
}
