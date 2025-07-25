open B0_kit.V000

(* OCaml library names *)

let htmlit = B0_ocaml.libname "htmlit"

(* Libraries *)

let htmlit_lib =
  let srcs = Fpath.[ `Dir (v "src") ] in
  let requires = [] in
  B0_ocaml.lib htmlit ~doc:"Htmlit library" ~srcs ~requires

(* Tests *)

let example =
  let srcs = [`File (Fpath.v "test/example.ml")] in
  let requires = [ htmlit ] in
  let meta = B0_meta.empty |> B0_meta.tag B0_meta.test in
  let doc = "Sample code" in
  B0_ocaml.exe "example" ~doc ~meta ~srcs ~requires

(* Packs *)

let default =
  let meta =
    B0_meta.empty
    |> B0_meta.(add authors) ["The htmlit programmers"]
    |> B0_meta.(add maintainers)
       ["Daniel Bünzli <daniel.buenzl i@erratique.ch>"]
    |> B0_meta.(add homepage) "https://erratique.ch/software/htmlit"
    |> B0_meta.(add online_doc) "https://erratique.ch/software/htmlit/doc"
    |> B0_meta.(add licenses) ["ISC"]
    |> B0_meta.(add repo) "git+https://erratique.ch/repos/htmlit.git"
    |> B0_meta.(add issues) "https://github.com/dbuenzli/htmlit/issues"
    |> B0_meta.(add description_tags) ["web"; "html"; "org:erratique"; ]
    |> B0_meta.tag B0_opam.tag
    |> B0_meta.add B0_opam.build
      {|[["ocaml" "pkg/pkg.ml" "build" "--dev-pkg" "%{dev}%"]]|}
    |> B0_meta.add B0_opam.depends
      [ "ocaml", {|>= "4.14.0"|};
        "ocamlfind", {|build|};
        "ocamlbuild", {|build|};
        "topkg", {|build & >= "1.1.0"|}; ]
  in
  B0_pack.make "default" ~doc:"htmlit package" ~meta ~locked:true @@
  B0_unit.list ()
