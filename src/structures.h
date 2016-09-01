#ifndef STRUCTURES_H
#define STRUCTURES_H

// vertex, a (x, y) pair.
struct vertex {

  vertex() : x(0), y(0) {}
  vertex(double x, double y) : x(x), y(y) {}

  double x, y;

  bool operator <(const vertex &v) const {
    return x < v.x || (x == v.x && y < v.y);
  }
};

#endif
