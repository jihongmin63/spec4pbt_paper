(* Check identical output sequences, rather than merely equal aggregate counts. *)
let () =
  List.iter (fun (name, plain, counted) ->
    List.iter (fun size -> List.iter (fun seed ->
      let a = Random.State.make [|seed|] and b = Random.State.make [|seed|] in
      let p = plain size and c = counted size in
      for _i = 1 to 10000 do
        let x = p a and y = c b in
        if x <> y then failwith ("instrumentation changes output: " ^ name);
        match x with Some n when n mod 6 <> 0 -> failwith "unsound output" | _ -> ()
      done) [42; 1729; 2718; 31415; 2026]) [0; 10; 30; 100])
    ["original", Derived.sample_original, Derived_counted.sample_original;
     "reversed", Derived.sample_reversed, Derived_counted.sample_reversed;
     "merged", Derived.sample_merged, Derived_counted.sample_merged;
     "agentic", Derived.sample_agentic, Derived_counted.sample_agentic];
  print_endline "800000 plain/counted output pairs agree; all outputs divisible by 6."
