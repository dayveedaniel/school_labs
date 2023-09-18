part of '../lab6.dart';

class CurrentCoordinatesWidget extends StatelessWidget {
  const CurrentCoordinatesWidget({
    super.key,
    required this.positionsStream,
  });

  final Stream<Position>? positionsStream;

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(fontSize: 16, fontWeight: FontWeight.w500);
    const titleStyle = TextStyle(fontSize: 21, fontWeight: FontWeight.w500);
    return StreamBuilder<Position>(
      stream: positionsStream,
      builder: (context, snapshot) {
        return switch (snapshot.connectionState) {
          ConnectionState.active => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Current coordinates: ',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  'In dms:',
                  style: titleStyle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  'Latitude: ${snapshot.data != null ? latDpToDms(snapshot.data!.latitude) : ''}',
                  style: style,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Longitude: ${snapshot.data != null ? longDpToDms(snapshot.data!.longitude) : ''}',
                  style: style,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                const Text(
                  'In decimals: ',
                  style: titleStyle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  'Latitude: ${snapshot.data?.latitude.toString() ?? ''}',
                  style: style,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'Longitude: ${snapshot.data?.longitude.toString() ?? ''}',
                  style: style,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ConnectionState.waiting => const CircularProgressIndicator.adaptive(),
          _ => const Text(
              'Something gone wrong',
              style: titleStyle,
              textAlign: TextAlign.center,
            )
        };
      },
    );
  }
}
