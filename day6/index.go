package main;

import (
  "fmt"
  "log"
  "os"
  "strings"
)

func main() {
  content, err := os.ReadFile("input.txt")
  if err != nil {
    log.Fatal(err)
  }
  text := string(content)
  index := 4
  outer: for index < len(text) {
    slice := text[index-4:index]
    for i := 0; i < len(slice); i++ {
      character := slice[i]
      if strings.Count(slice, string(character)) > 1 {
        index++
        continue outer
      }
    }
    break
  }
  fmt.Printf("Part 1: %d\n", index)

  index = 14
  outertwo: for index < len(text) {
    slice := text[index-14:index]
    for i := 0; i < len(slice); i++ {
      character := slice[i]
      if strings.Count(slice, string(character)) > 1 {
        index++
        continue outertwo
      }
    }
    break
  }
  fmt.Printf("Part 2: %d\n", index)
}
