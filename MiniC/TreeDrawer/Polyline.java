package MiniC.TreeDrawer;

class Polyline {

  int dx, dy;

  Polyline link;

  Polyline(int dx, int dy, Polyline link) {
    this.link = link;
    this.dx   = dx;
    this.dy   = dy;
  }
}
