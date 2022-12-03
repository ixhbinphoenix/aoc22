module main

import os

fn main() {

  content := os.read_file('./input.txt') or {
    eprintln('failed to read the file: $err')
    return
  }

  lines := content.split_into_lines()
  mut points := 0
  outer: for line in lines {
    comp1 := line.substr(0, line.len / 2)
    comp2 := line.substr(line.len / 2, line.len)

    for character in comp1.bytes() {
      if character in comp2.bytes() {
        points += get_priority(character)
        continue outer
      }
    }
  }
  println('Part 1: $points')

  points = 0
  outer2: for i := 0; i < lines.len; i +=3 {
    elf1 := lines[i]
    elf2 := lines[i + 1]
    elf3 := lines[i + 2]

    for character in elf1.bytes() {
      if character in elf2.bytes() && character in elf3.bytes() {
        points += get_priority(character)
        continue outer2
      }
    }
  }
  println('Part 2: $points')
}

fn get_priority(c byte) int {
  alphabet_order := 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'.bytes()
  for i, character in alphabet_order {
    if c == character {
      return i + 1
    }
  }
  return 0
}
