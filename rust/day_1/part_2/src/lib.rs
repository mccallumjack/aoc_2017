pub fn sum(list: Vec<u32>) -> u32 {
    let mut sum = 0;
    for i in list {
        sum += i;
    }

    sum
}


pub fn string_to_list(s: &String) -> Vec<u32> {
    s.trim().chars()
      .map(|d| d.to_digit(10).unwrap())
      .collect()
}

pub fn filter_list(list: Vec<u32>) -> Vec<u32> {
    let len = list.len();
    let mut index = len / 2;
    let mut filtered_list: Vec<u32> = Vec::new();

    for i in list.iter() {
        if i == &list[index]{
            filtered_list.push(*i);
        }

        index = (index + 1) % len;
    }

    filtered_list
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn string_to_list_works() {
        let string = String::from("12345");
        let list   = vec![1, 2, 3, 4, 5];

        assert_eq!(list, string_to_list(&string))
    }

    #[test]
    fn filter_list_works() {
        let unfiltered = vec![1, 2, 3, 4, 2, 5];
        let filtered   = vec![2, 2];
        assert_eq!(filtered, filter_list(unfiltered))
    }

    #[test]
    fn filter_list_works_2() {
        let unfiltered = vec![1, 1, 1, 1];
        let filtered   = vec![1, 1, 1, 1];
        assert_eq!(filtered, filter_list(unfiltered))
    }

    #[test]
    fn filter_list_works_circularly() {
        let unfiltered = vec![1, 2, 3, 1, 2, 3];
        let filtered   = vec![1, 2, 3, 1, 2, 3];
        assert_eq!(filtered, filter_list(unfiltered))
    }

    #[test]
    fn sum_works() {
        let list = vec![1,2,3,4,5];
        assert_eq!(15, sum(list));
    }
}

