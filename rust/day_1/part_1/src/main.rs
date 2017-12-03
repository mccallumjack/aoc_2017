extern crate part_1;

use std::fs::File;
use std::io::Read;

fn main() {
    let mut f = File::open("input.txt").expect("its broken");
    let mut contents = String::new();

    f.read_to_string(&mut contents).expect("broken");

    let list = part_1::string_to_list(&contents);
    let list = part_1::filter_list(list);
    let sum  = part_1::sum(list);

    println!("RECAPTCHA: {}", sum);
}
