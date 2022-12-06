fn stacks_from_layout(crate_layout: &str) -> Vec<Vec<char>> {
    let mut stacks = (0..10).map(|_| vec![]).collect::<Vec<Vec<char>>>();
    let crates = crate_layout.split("\n").collect::<Vec<&str>>();
    crates.iter()
          .rev()
          .skip(1)
          .for_each(|&line| line.chars()
                                .skip(1)
                                .step_by(4)
                                .enumerate()
                                .filter(|&(_, c)| c != ' ')
                                .for_each(|(i, c)| stacks[i+1].push(c)));
    stacks
}


fn string_from_stacktops(crates: &str, instructions: &str, part: u8) -> String {
    let mut stacks = stacks_from_layout(crates);
    let lines = instructions.split("\n");
    let mut s = String::new();
    let mut stack_index;
    let mut v;

    for line in lines {
        if line.len() == 0 { break }

        if let &[amount, source, dest] =
            line.split(" ")
                .skip(1)
                .step_by(2)
                .map(|x| x.parse::<usize>().unwrap())
                .collect::<Vec<_>>()
                .as_slice()
        {
            if part == 2 {
                for _ in 0..amount {
                    v = stacks[source].pop().unwrap();
                    stacks[0].push(v);
                }
                stack_index = 0;
            }
            else {
                stack_index = source;
            }

            for _ in 0..amount {
                v = stacks[stack_index].pop().unwrap();
                stacks[dest].push(v);
            }
        }
    }


    for i in 1..10 {
        if let Some(&x) = &stacks[i].last(){
            s.push(x);
        }
    }
    s
}


fn main() {
    let text = std::fs::read_to_string("05.txt").expect("404");
    let (crates, instructions) = text.split_once("\n\n").unwrap();

    println!("{:?}", string_from_stacktops(crates, instructions, 1));
    println!("{:?}", string_from_stacktops(crates, instructions, 2));
}
