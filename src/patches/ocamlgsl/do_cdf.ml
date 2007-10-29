(* Adjusted by Matteo Franchin to compile with gsl 1.8, Oct 2006 *)

let parse =
  let regexp_full = Str.regexp "double gsl_cdf_\\([^ ]+\\) (\\([^)]+\\));" in
  let regexp_arg  = Str.regexp
    "const \\(double\\|unsigned int\\) \\([a-zA-Z0-9_]+\\)[, \t\n\r]*" in
  fun s ->
    if Str.string_match regexp_full s 0
    then
      let fun_name = Str.matched_group 1 s in
      let args =
	begin
	  let acc = ref [] in
	  let i = ref (Str.group_beginning 2) in
	  begin try while true do
	    let _ = Str.search_forward regexp_arg s !i in
	    acc := (Str.matched_group 2 s) :: !acc ;
	    i := Str.match_end ()
	  done
	  with Not_found -> () end ;
	  List.rev !acc
	end in
      Some (fun_name, args)
    else
      None

let may f = function
  | None -> ()
  | Some v -> f v

let print_ml (fun_name, args) =
  Printf.printf "external %s : " fun_name ;
  List.iter (fun arg -> Printf.printf "%s:float -> " (String.lowercase arg)) args ;
  Printf.printf "float = \"ml_gsl_cdf_%s\" \"gsl_cdf_%s\" \"float\"\n" fun_name fun_name

let print_c (fun_name, args) =
  Printf.printf "ML%d(gsl_cdf_%s, " (List.length args) fun_name ;
  List.iter (fun arg -> print_string "Double_val, ") args ;
  print_string "copy_double)\n" ;
  print_newline ()

let c_output =
  Array.length Sys.argv > 1 && Sys.argv.(1) = "--c"

let _ =
  if c_output
  then Printf.printf "#include <caml/alloc.h>\n#include <gsl/gsl_cdf.h>\n#include \"wrappers.h\"\n\n"
  else Printf.printf "(** Cumulative distribution functions *)\n\n" ;

  try while true do
    may
      (if c_output then print_c else print_ml)
      (parse (read_line ()))
  done with End_of_file -> ()
