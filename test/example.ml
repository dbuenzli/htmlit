(* This code is in the public domain *)

open Htmlit

let abbrs =
  [ "KISS", "Keep it simple, stupid";
    "DRY", "Don't repeat yourself" ]

let abbrify ?(at = []) (a, exp) = El.abbr ~at:(At.title exp :: at) [El.txt a]

let page ?(footer = El.void) ~title contents =
  let body = El.body [El.h1 [El.txt title]; contents; footer] in
  El.page ~lang:"en" ~title body

let mypage () =
  let comma = El.txt ", " in
  let abbrs = El.splice ~sep:comma (List.map abbrify abbrs) in
  let content = El.p [El.txt "Keep in mind: "; abbrs; El.txt "."] in
  page ~title:"Hints" content

let main () = print_endline (El.to_string ~doctype:true (mypage ()))

let () = if !Sys.interactive then () else main ()
