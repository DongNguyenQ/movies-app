part of 'design_system.dart';

class MGap extends StatelessWidget {
  final double? vGap;
  final double? hGap;
  const MGap.v20({Key? key})
      : vGap = 20.0,
        hGap = 0.0,
        super(key: key);
  const MGap.v16({Key? key})
      : vGap = 16.0,
        hGap = 0.0,
        super(key: key);
  const MGap.v12({Key? key})
      : vGap = 12.0,
        hGap = 0.0,
        super(key: key);
  const MGap.v08({Key? key})
      : vGap = 8.0,
        hGap = 0.0,
        super(key: key);
  const MGap.v04({Key? key})
      : vGap = 4.0,
        hGap = 0.0,
        super(key: key);

  const MGap.h20({Key? key})
      : hGap = 20.0,
        vGap = 0.0,
        super(key: key);
  const MGap.h16({Key? key})
      : hGap = 16.0,
        vGap = 0.0,
        super(key: key);
  const MGap.h12({Key? key})
      : hGap = 12.0,
        vGap = 0.0,
        super(key: key);
  const MGap.h08({Key? key})
      : hGap = 8.0,
        vGap = 0.0,
        super(key: key);
  const MGap.h04({Key? key})
      : hGap = 4.0,
        vGap = 0.0,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: vGap,
      width: hGap,
    );
  }
}