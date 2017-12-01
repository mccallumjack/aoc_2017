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
    let mut value: u32 = list[len - 1];
    let mut filtered_list: Vec<u32> = Vec::new();

    for i in list {
        if i == value {
            filtered_list.push(i);
        }
        value = i;
    }

    filtered_list
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn string_to_list_works() {
        let string = String::from("12345");
        let list   = vec![1,2,3,4,5];

        assert_eq!(list, string_to_list(&string))
    }

    #[test]
    fn filter_list_works() {
        let unfiltered = vec![1, 2, 3, 3, 5, 5];
        let filtered   = vec![3,5];
        assert_eq!(filtered, filter_list(unfiltered))
    }

    #[test]
    fn filter_list_works_2() {
        let unfiltered = vec![1,1,1,1];
        let filtered   = vec![1,1,1,1];
        assert_eq!(filtered, filter_list(unfiltered))
    }

    #[test]
    fn filter_list_works_circularly() {
        let unfiltered = vec![9,1,2,9];
        let filtered   = vec![9];
        assert_eq!(filtered, filter_list(unfiltered))
    }

    #[test]
    fn sum_works() {
        let list = vec![1,2,3,4,5];
        assert_eq!(15, sum(list));
    }
}

