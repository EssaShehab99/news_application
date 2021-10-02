import 'package:flutter/material.dart';
import 'package:news_application/cubits/post_cubit.dart';
import 'package:news_application/cubits/title_cubit.dart';
import 'package:news_application/models/post/post.dart';
import 'package:news_application/models/title/news_title.dart';
import 'package:news_application/modules/news_screen/news_screen.dart';
import 'package:news_application/shared/components/constants.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    TitleCubit.get(context).titles.add(
        NewsTitle(id: 1, title: "اخر الاخبار", typeTitle: TypeTitle.MIXED));
    TitleCubit.get(context)
        .titles
        .add(NewsTitle(id: 2, title: "عاجل", typeTitle: TypeTitle.CLOUD));
    TitleCubit.get(context)
        .titles
        .add(NewsTitle(id: 3, title: "طوائ", typeTitle: TypeTitle.CLOUD));
    TitleCubit.get(context)
        .titles
        .add(NewsTitle(id: 4, title: "الجنوب", typeTitle: TypeTitle.CLOUD));
    TitleCubit.get(context)
        .titles
        .add(NewsTitle(id: 5, title: "الشمال", typeTitle: TypeTitle.CLOUD));
    TitleCubit.get(context)
        .titles
        .add(NewsTitle(id: 6, title: "السعودية", typeTitle: TypeTitle.CLOUD));
    TitleCubit.get(context)
        .titles
        .add(NewsTitle(id: 7, title: "الخليج", typeTitle: TypeTitle.CLOUD));
    TitleCubit.get(context)
        .titles
        .add(NewsTitle(id: 8, title: "الصرف", typeTitle: TypeTitle.CLOUD));
    TitleCubit.get(context)
        .titles
        .add(NewsTitle(id: 9, title: "عالمية", typeTitle: TypeTitle.CLOUD));

    TitleCubit.get(context).titles.add(
        NewsTitle(id: 10, title: "المفضلات", typeTitle: TypeTitle.FAVORITE));

    PostCubit.get(context).insertPost(post: Post(
          id: 1,
          title:
              "صنعاء: مركز شرطة 26 سبتمبر بمديرية شعوب في أمانة العاصمة، تلقي القبض على متهم باختراق هاتف إحدى النساء ونسخ صورها الشخصية وابتزازها،  وذلك بعد تلقي البلاغ من المرأة.".trim(),
          remoteImageTitle:
              "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg",
          remoteImageList: [
            'https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg',
            'https://cdn.pixabay.com/photo/2016/05/05/02/37/sunset-1373171__340.jpg',
            'https://images.ctfassets.net/hrltx12pl8hq/7yQR5uJhwEkRfjwMFJ7bUK/dc52a0913e8ff8b5c276177890eb0129/offset_comp_772626-opt.jpg?fit=fill&w=800&h=300'
          ],
          detail: """صنعاء: مركز شرطة 26 سبتمبر بمديرية شعوب في أمانة العاصمة، تلقي القبض على متهم باختراق هاتف إحدى النساء ونسخ صورها الشخصية وابتزازها، وذلك بعد تلقي البلاغ من المرأة.

الشرطة: عقب البلاغ تم إجراء التحريات والمتابعة اللازمة حتى تم القبض على المتهم المدعو ( ع . ح . ج ) والذي يعمل سائق دراجة نارية، قام بارسال رسالة تتضمن رابط إلى حساب واتس المواطنة ( غ . ر ) وعند فتحها للرابط تمكن المتهم من اختراق هاتفها ونسخ ما بداخله من صور شخصية لها، ثم قام بالإتصال بها طالبا منها دفع مبالغ مالية وهددها بأنه سيقوم بنشر صورها في مواقع التواصل الإجتماعي في حال رفضها الدفع.

الشرطة تحذر المواطنين من التجاوب مع الرسائل الالكترونية المشبوهة والمجهولة، وتدعو جميع النساء إلى توخي الحذر، وعدم الاحتفاظ بصورهن الشخصية في هواتفهن حتى لا يقعن ضحية للابتزاز من قبل المجرمين في حال ضياع الهاتف أو اختراقه، كما دعت جميع المواطنين إلى سرعة إبلاغ الشرطة في حال تعرضهم لمثل هذا النوع من الجرائم.            """,
          isSync: true,
          date: "${DateTime.now()}",
          type: TitleCubit.get(context).titles[0],
          isRead: false,
          isFavorite: false,
        ));
    PostCubit.get(context).insertPost(post: Post(
          id: 2,
          title:
              "مصدر مطلع: قيادة اللواء التاسع التابع لقوات المجلس الانتقالي، ترفض تقديم المتهمين بقتل الشاب عبدالملك السنباني.. ومطالبات النيابة الجزائية بتسليم المتورطين في جريمة القتل، لم تلق تجاوبا من السلطات المعنية حتى الآن.".trim(),
          remoteImageTitle:
              "https://images.ctfassets.net/hrltx12pl8hq/7yQR5uJhwEkRfjwMFJ7bUK/dc52a0913e8ff8b5c276177890eb0129/offset_comp_772626-opt.jpg?fit=fill&w=800&h=300",
          remoteImageList: [
            'https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg',
            'https://cdn.pixabay.com/photo/2016/05/05/02/37/sunset-1373171__340.jpg',
            'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg'
          ],
          detail: """مصدر مطلع: قيادة اللواء التاسع التابع لقوات المجلس الانتقالي، ترفض تقديم المتهمين بقتل الشاب عبدالملك السنباني.. ومطالبات النيابة الجزائية بتسليم المتورطين في جريمة القتل، لم تلق تجاوبا من السلطات المعنية حتى الآن.""",
          isSync: true,
          date: "${DateTime.now()}",
          type: TitleCubit.get(context).titles[1],
          isRead: false,
          isFavorite: false,
        ));
    PostCubit.get(context).insertPost(
          post: Post(
            id: 3,
            title:
                "I have some text, maybe long and a box, WxH fixed size. I've calculated that given my font size and height scale, I can fit L lines of text. So I put maxLines and ellipsize and it works in Android app (since line height is predictable), but doesn't in Flutter app.",
            remoteImageTitle:
            'https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg',
            remoteImageList: [
              'https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg',
              'https://cdn.pixabay.com/photo/2016/05/05/02/37/sunset-1373171__340.jpg',
              'https://images.ctfassets.net/hrltx12pl8hq/7yQR5uJhwEkRfjwMFJ7bUK/dc52a0913e8ff8b5c276177890eb0129/offset_comp_772626-opt.jpg?fit=fill&w=800&h=300'
            ],
            detail: """
There are many ways to repurpose a piece of content, and not all of them are effective. In general, spun content replaces the vocabulary used in original texts, employing synonyms where appropriate, or varying sentence structure.

So, a phrase like "run faster with turbo sneakers" could become "gain velocity with turbo sneakers", or "turbo sneakers allow runners to beat their personal best." When slotted into existing text structures, alterations like this retain its meaning but should be categorised by crawlers as separate pieces of content.

However, and this is really important: most spun content emerges from the process as spam with very low SEO value, and the potential to damage your brand reputation.

Much of the time, spun texts read poorly, lose the crispness and clarity of the original, and are penalised by search engines like Google. But that doesn't mean that spinning is dead. It just means that it's a risky strategy.            """,
            isSync: true,
            date: "${DateTime.now()}",
            type: TitleCubit.get(context).titles[2],
            isRead: false,
            isFavorite: false,
          ),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NewsScreen();
  }
}
