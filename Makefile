exec := example
src := main.ml
pkgs := yojson,lwt.unix,stringext,cohttp,cohttp.lwt

target: $(src)
	ocamlfind ocamlopt -linkpkg -package $(pkgs) $< -o $(exec) 
