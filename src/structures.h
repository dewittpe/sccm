#ifndef STRUCTURES_H
#define STRUCTURES_H

// vertex, a (x, y) pair.
struct vertex {

  vertex() : x(0), y(0), id(0){}
  vertex(double x, double y, int id) : x(x), y(y), id(id){}

  double x, y;
  int id;

  bool operator <(const vertex &v) const {
    return x < v.x || (x == v.x && y < v.y);
  }
};

#endif
