const std = @import("std");
const io = std.io;
const print = std.debug.print;

pub fn main() anyerror!void {
  var file = try std.fs.cwd().openFile("input.txt", .{});
  defer file.close();
  var buf_reader = io.bufferedReader(file.reader());
  var in_stream = buf_reader.reader();
  var buf: [1024]u8 = undefined;
  
  var points: u64 = 0;
  var part2_points: u64 = 0;
  while (try in_stream.readUntilDelimiterOrEof(&buf, '\n')) |line| {
    var elves = std.mem.split(u8, line, ",");
    var elf1 = std.mem.split(u8, elves.next().?, "-");
    const elf1_min: u64 = try parseU64(elf1.next().?, 10);
    const elf1_max: u64 = try parseU64(elf1.next().?, 10);
    var elf2 = std.mem.split(u8, elves.next().?, "-");
    const elf2_min: u64 = try parseU64(elf2.next().?, 10);
    const elf2_max: u64 = try parseU64(elf2.next().?, 10);

    // Part 1
    if (elf1_min <= elf2_min and elf1_max >= elf2_max) {
      points += 1;
    } else if (elf2_min <= elf1_min and elf2_max >= elf1_max) {
      points += 1;
    }
    
    // Part 2
    if (elf1_min < elf2_min and elf1_max >= elf2_min) { part2_points += 1;} 
    else if (elf1_min > elf2_min and elf2_max >= elf1_min) { part2_points += 1; }
    else if (elf1_min == elf2_min) part2_points += 1;
  }

  print("Part 1: {}\n", .{points});
  print("Part 2: {}\n", .{part2_points});
}

pub fn min(a: u64, b: u64) u64 {
  if (a < b) {
    return a;
  } else {
    return b;
  }
}

pub fn max(a: u64, b: u64) u64 {
  if (a > b) {
    return a;
  } else {
    return b;
  }
}

// Credit to the zig docs
// https://ziglang.org/documentation/0.2.0/
pub fn parseU64(buf: []const u8, radix: u8) !u64 {
  var x: u64 = 0;

  for (buf) |c| {
    const digit = charToDigit(c);

    if (digit >= radix) {
      return error.InvalidChar;
    }

    if (@mulWithOverflow(u64, x, radix, &x)) {
      return error.Overflow;
    }

    if (@addWithOverflow(u64, x, digit, &x)) {
      return error.Overflow;
    }
  }

  return x;
}

fn charToDigit(c: u8) u8 {
  return switch (c) {
    '0' ... '9' => c - '0',
    'A' ... 'Z' => c - 'A' + 10,
    'a' ... 'z' => c - 'a' + 10,
    else => 255,
  };
}
