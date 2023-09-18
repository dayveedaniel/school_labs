part of '../lab6.dart';

class _TrackedCoordinatesWidget extends StatelessWidget {
  const _TrackedCoordinatesWidget({
    required this.positionsStream,
    required this.positionsToTrack,
  });

  final Stream<Position>? positionsStream;
  final List<CroppedPosition> positionsToTrack;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: positionsStream,
      builder: (context, snapshot) {
        return Column(
          children: positionsToTrack.map((e) {
            final double? distance;
            if (snapshot.data != null) {
              distance = Geolocator.distanceBetween(
                snapshot.data!.latitude,
                snapshot.data!.longitude,
                e.latitude,
                e.longitude,
              );
            } else {
              distance = null;
            }
            final bool isDistanceNear =
                distance != null && distance < _minDistance;
            return Card(
              color: isDistanceNear ? Colors.green[100] : Colors.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: isDistanceNear ? Colors.green : Colors.grey,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              margin: const EdgeInsets.symmetric(vertical: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text(
                      e.name,
                      style: const TextStyle(fontSize: 21),
                    ),
                    subtitle: Text('Lat: ${e.latitude}\nLon: ${e.longitude}'),
                  ),
                  if (distance != null) ...[
                    Divider(
                      indent: 10,
                      endIndent: 10,
                      color: Colors.grey[600],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Distance: ${distance.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 12)
                  ],
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
