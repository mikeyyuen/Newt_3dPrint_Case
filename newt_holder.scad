board_width=91;
board_height=61;
board_depth=6;
board_roundness=4;

width=100;
bend_radius=5;
top_length=80;
base_length=70;

module screw_hole() {
  rotate([90, 90, 0]) {
    cylinder(d=4, h=20, center=true, $fn=20);
  }
}


module plate(length, depth, width, roundness, flat_bottom=true) {
  minkowski() {
    cube([length - roundness * 2,
          depth - 1,
          width - roundness * 2],
         center=true);
    rotate([90, 0, 0]) { cylinder(h=1, r=roundness, center=true); }
  }
  if(flat_bottom) {
    translate([-roundness / 2, 0, 0]) {
      cube([length - roundness, depth, width], center=true);
    }
  }
}

module top() {
  difference() {
    plate(top_length, bend_radius, width, bend_radius);
    plate(board_height - 15,
          bend_radius * 2,
          board_width - 15,
          board_roundness * 3, false);
    translate([-27.5, -3.0, -29.25]) { screw_hole(); }
    translate([-27.5, -3.0,  29.25]) { screw_hole(); }
    translate([ 27.25, -3.0, -42.5]) { screw_hole(); }
    translate([ 27.25, -3.0,  42.5]) { screw_hole(); }
  }
}

difference() {
  cylinder(h=width, r=bend_radius, center=true, $fn=50);
  translate([bend_radius / 2, bend_radius / 2, 0]) {
    cube([bend_radius, bend_radius, width * 2], center=true);
  }
}

translate([base_length / 2, -bend_radius / 2, 0]) {
  plate(base_length, bend_radius, width, bend_radius);
}

rotate([0, 0, 60]) {
  translate([top_length / 2, bend_radius / 2, 0]) {
    top();
  }
}