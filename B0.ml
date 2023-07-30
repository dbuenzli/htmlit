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
    let open B0_meta in
    empty
    |> add authors ["The htmlit programmers"]
    |> add maintainers ["Daniel Bünzli <daniel.buenzl i@erratique.ch>"]
    |> add homepage "https://erratique.ch/software/htmlit"
    |> add online_doc "https://erratique.ch/software/htmlit/doc"
    |> add licenses ["ISC"]
    |> add repo "git+https://erratique.ch/repos/htmlit.git"
    |> add issues "https://github.com/dbuenzli/htmlit/issues"
    |> add description_tags ["codec"; "qoi"; "image"; "org:erratique"; ]
    |> add B0_opam.Meta.build
      {|[["ocaml" "pkg/pkg.ml" "build" "--dev-pkg" "%{dev}%"]]|}
    |> tag B0_opam.tag
    |> add B0_opam.Meta.depends
      [ "ocaml", {|>= "4.14.0"|};
        "ocamlfind", {|build|};
        "ocamlbuild", {|build|};
        "topkg", {|build & >= "1.0.3"|}; ]
  in
  B0_pack.v "default" ~doc:"htmlit package" ~meta ~locked:true @@
  B0_unit.list ()
