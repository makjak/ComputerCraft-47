# Turtle quarry in lua for computercraft

## Requirements

* 4 Computers with running gps program
* Turtle with quarry code or with strip mine code
* Quarry turtle must have coal in first slot and enderchest in second

## Howto run gps hosts

Run 4 gps hosts with command
``` lua
gps host x y z
```
or on startup
``` lua
shell.run('gps', 'host', x, y, z)
```

## Howto run strip mine

1. Save program `turtle_mine` on turtle

2. Run this program
``` lua
mine x 0 0
```
or
``` lua
mine 0 0 z
```
on one of turtles

## Howto run quarry turtle

1. Save program `turtle_quarry` on turtle

2. Run this program with
``` lua
quarry 30
```
or
``` lua
quarry 10 30
```
or
``` lua
quarry 10 20 30
```
where first is squary until bottom, second - rectangle until bottom,
third - cuboid
