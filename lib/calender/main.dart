import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void main() {
  runApp(const MaterialApp(home: CalenderWidgtet()));
}

class CalenderWidgtet extends HookWidget {
  const CalenderWidgtet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dayOfOneWeekList = useState<List<DateTime>>([]);
    final today = DateTime.now();
    final targetDate = useState<DateTime?>(null);

    List<DateTime> getWeekDays() {
      //周始まりを取得する
      final startOfWeekAdjusted = (today.weekday == 7)
          ? today
          : today.subtract(Duration(days: today.weekday));
      List<DateTime> weekDays = [];
      for (int i = 0; i < 7; i++) {
        weekDays.add(startOfWeekAdjusted.add(Duration(days: i)));
      }
      return weekDays;
    }

    Color getBackgroundColor({required DateTime dayOfOneWeek}) {
      //背景色を取得する
      if (dayOfOneWeek.day == today.day && dayOfOneWeek.month == today.month) {
        return Colors.grey;
      }
      if (dayOfOneWeek.day == targetDate.value?.day &&
          dayOfOneWeek.month == targetDate.value?.month) {
        return Colors.blue;
      } else {
        return Colors.white;
      }
    }

    useEffect(() {
      dayOfOneWeekList.value = getWeekDays();
      return null;
    }, []);

    var daysOfWeekWidget = Flexible(
      flex: 7,
      child: Row(
        children: <Widget>[
          for (final dayOfOneWeek in dayOfOneWeekList.value)
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  targetDate.value = dayOfOneWeek;
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      getBackgroundColor(dayOfOneWeek: dayOfOneWeek),
                  shape: const CircleBorder(),
                  padding: EdgeInsets.zero,
                ),
                child: Text(
                  "${dayOfOneWeek.day}",
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            )
        ],
      ),
    );
    var monthWidget = Flexible(
        flex: 2,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            elevation: 0,
            padding: EdgeInsets.zero,
            shape: const StadiumBorder(),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${today.month}月",
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
              const Icon(
                Icons.calendar_month,
                color: Colors.black,
              ),
            ],
          ),
        ));
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            monthWidget,
            daysOfWeekWidget,
          ],
        ),
      ),
    );
  }
}
