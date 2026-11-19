(* Timing uses Derived; observational measurements use Derived_counted. *)
let () =
  let mode = Sys.argv.(1) and name = Sys.argv.(3) in
  let size = int_of_string Sys.argv.(4) and seed = int_of_string Sys.argv.(2)
  and attempts = int_of_string Sys.argv.(5) in
  let generators = if mode = "timing" then
    ["original", Derived.sample_original; "reversed", Derived.sample_reversed;
     "merged", Derived.sample_merged; "agentic", Derived.sample_agentic]
    else
    ["original", Derived_counted.sample_original; "reversed", Derived_counted.sample_reversed;
     "merged", Derived_counted.sample_merged; "agentic", Derived_counted.sample_agentic] in
  let generate = (List.assoc name generators) size in
  let random = Random.State.make [|seed|] in
  let accepted = ref 0 and sum = ref 0 and zero = ref 0 and maximum = ref 0 in
  let hist = Hashtbl.create 200 in
  let before_wall = Unix.gettimeofday () and before_cpu = Sys.time () in
  for _i = 1 to attempts do
    match generate random with
    | None -> ()
    | Some x ->
      incr accepted; sum := !sum + x;
      if mode <> "timing" then (
        if x = 0 then incr zero;
        maximum := max !maximum x;
        Hashtbl.replace hist x (1 + (try Hashtbl.find hist x with Not_found -> 0)))
  done;
  let cpu = Sys.time () -. before_cpu and wall = Unix.gettimeofday () -. before_wall in
  if mode = "timing" then
    Printf.printf "timing,%s,%d,%d,%d,%d,%d,%.9f,%.9f,%.3f,%d\n"
      name size seed attempts !accepted (attempts - !accepted) cpu wall
      (1e9 *. cpu /. float !accepted) !sum
  else (
    let open Derived_counted in
    Printf.printf "counters,%s,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%.9f,%.9f,%d,%d\n"
      name size seed attempts !accepted (attempts - !accepted)
      !candidate_checks !candidate_true !candidate_false !candidate_unknown
      !failed_branches !checker_calls !zero
      (float !zero /. float !accepted) (float !sum /. float !accepted)
      !maximum (Hashtbl.length hist);
    let out = open_out Sys.argv.(6) in
    output_string out "value,count\n";
    List.iter (fun (x,n) -> Printf.fprintf out "%d,%d\n" x n)
      (List.sort compare (Hashtbl.fold (fun x n a -> (x,n)::a) hist []));
    close_out out)
