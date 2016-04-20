(**
   SUMMING ODDS IN A LIST
   EXAMPLES FOR THE SILICON VALLEY OCaml MEETUP
   DATED: March 29, 2016
   AUTHOR: @wiredsister, @fxfactorial
*)

(**
  TAIL RECURSIVE SOLUTION
  -----------------------
  equivalent to:
  List.fold_left (fun a n -> if n mod 2 = 0 then a else (a + n)) 0 [1; 2; 3; 4; 5; 6]

  Gotchas: you'll notice that if you need to return a List.rev of your accum,
  or somehow cons the elements in reverse, to preserve order.
*)

class foo = object(self)
  method speak = print_endline "!23"
end

let tr_sum_odd_elements elements =
  let rec aux nums accum =
    match nums with
    | num::rest ->
      if num mod 2 = 0
      then aux rest accum
      (* notice the last call here is the recursive function *)
      else aux rest (num + accum)
    | [] -> accum
  in
  aux elements 0

(**
  NON-TAIL RECURSIVE SOLUTION
  ---------------------------
  equivalent to:
  List.fold_right (fun a n -> if n mod 2 = 0 then a else (a + n)) 0 [1; 2; 3; 4; 5; 6]

  Gotchas: because this requires dragging state between function frames (calls)
  this can blow the stack and will not be optimized by the compiler.
  Although, if it's a small known set, can be useful to preserve order.
*)

let ntr_sum_odd_elements elements =
  let rec aux = function
    | num::rest ->
      if num mod 2 = 0
      then aux rest
      else num + (aux rest) (* notice the last call here is the `+` operation *)
    | [] -> 0
  in
  aux elements

(**
  IMPERATIVE SOLUTION
  --------------------
*)
(*
  type sig for ref:
  'a -> 'a ref
  type def for ref:
  'a ref = { mutable contents : 'a }
  So, all it's doing here is making a new type that
  has a property called contents which uses the "mutable" keyword.
  "Mutable" is the only way to have a mutable prop in OCaml.
*)

let imp_sum_odd_elements elements =
  let counter = ref 0 in
  let arr = Array.of_list elements in
  for i = 0 to (Array.length arr - 1) do
  (*      type signature of ( := ) *)
  (*      'a ref -> 'a -> unit *)
    if not (arr.(i) mod 2 = 0) then counter := !counter + arr.(i)
  done;
  (* Essentially, derefrencing counter *)
  !counter

