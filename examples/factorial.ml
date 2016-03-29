(**
   FACTORIAL
   EXAMPLES FOR THE SILICON VALLEY OCaml MEETUP
   DATED: March 29, 2016
   AUTHOR: @wiredsister, @fxfactorial
*)

(**
  TAIL RECURSIVE SOLUTION
  -----------------------

  Gotchas: you'll notice that if you need to return a List.rev of your accum,
  or somehow cons the elements in reverse, to preserve order.

  Above factorial 30, you'll get negative numbers as you blow through the amount
  of positive nums your machine can hold. Try factorial 500 for a good time. It will
  hang, and eventually give you 0.
*)
let tr_factorial n =
  let rec aux i accum =
    if i > n then accum
    else aux (i + 1) (accum * i)
  in
  aux 1 1

(**
  NON-TAIL RECURSIVE SOLUTION
  ---------------------------

  Gotchas: because this requires dragging state between function frames (calls)
  this can blow the stack and will not be optimized by the compiler.
  Although, if it's a small known set, can be useful to preserve order.

   Example:
   utop # factorial 500000000 ;;
   Stack overflow during evaluation (looping recursion?).
*)
let rec ntr_factorial = function
  | 0 -> 1
  | 1 -> 1
  | n when n > 0 -> n * ntr_factorial (n - 1)
  | _ -> raise (Invalid_argument "Please provide positive numbers only.")

(**
  IMPERATIVE SOLUTION
  --------------------

  Since under the hood, the imperative solution is not much different
  from the tail-recursive solution (the compiler rewrites the TR solution
  to be iterative) you'll notice they have similar behaviors.
  Above 30 you'll see that it will give negative numbers, then eventually 0.
*)

let factorial n =
  let result = ref 1 in
  for i = 1 to n do
    result := i * !result
  done;
  !result
