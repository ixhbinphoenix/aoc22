use std::fs::read_to_string;
fn main() {
    println!("Loading file");
    let input = read_to_string("./input.txt").unwrap();
    let inputv = input.split("\n").collect::<Vec<&str>>();
    let mut sumv: Vec<u64> = Vec::new();

    let mut x = 0;
    println!("Parsing {} lines", inputv.len());
    for line in inputv {
        if !line.is_empty() {
            if sumv.get(x).is_none() {
                sumv.push(line.parse::<u64>().unwrap());
            } else {
                sumv[x] = sumv[x] + line.parse::<u64>().unwrap();
            }
        } else {
            x += 1;
        }
    }

    println!("Sorting...");
    sumv.sort();
    let highest = sumv[sumv.len() - 1];
    println!("Highest calories carried by a single Elf: {}", highest);
    let topthree = sumv[sumv.len() - 1] + sumv[sumv.len() - 2] + sumv[sumv.len() - 3];
    println!("Calories of Top 3 Elves: {}", topthree);
}
