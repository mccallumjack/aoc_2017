extern crate part_2;

use std::fs::File;
use std::io::Read;

fn main() {
    let mut f = File::open("input.txt").expect("its broken");
    let mut contents = String::new();

    f.read_to_string(&mut contents).expect("broken");

    let list = part_2::string_to_list(&contents);
    let list = part_2::filter_list(list);
    let sum  = part_2::sum(list);

    println!("RECAPTCHA: {}", sum);
}
