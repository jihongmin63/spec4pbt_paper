let candidate_checks = ref 0
let candidate_true = ref 0
let candidate_false = ref 0
let candidate_unknown = ref 0
let checker_calls = ref 0
let failed_branches = ref 0
let observe_check x =
  incr candidate_checks;
  (match x with Some true -> incr candidate_true
              | Some false -> incr candidate_false
              | None -> incr candidate_unknown); x


type __ = Obj.t
let __ = let rec f _ = Obj.repr f in Obj.repr f

type reflect =
| ReflectT
| ReflectF

(** val fst : ('a1 * 'a2) -> 'a1 **)

let fst = function
| (x, _) -> x

(** val snd : ('a1 * 'a2) -> 'a2 **)

let snd = function
| (_, y) -> y

(** val length : 'a1 list -> int **)

let rec length = function
| [] -> 0
| _ :: l' -> Stdlib.Int.succ (length l')

(** val app : 'a1 list -> 'a1 list -> 'a1 list **)

let rec app l m =
  match l with
  | [] -> m
  | a :: l1 -> a :: (app l1 m)

type uint =
| Nil
| D0 of uint
| D1 of uint
| D2 of uint
| D3 of uint
| D4 of uint
| D5 of uint
| D6 of uint
| D7 of uint
| D8 of uint
| D9 of uint

type uint0 =
| Nil0
| D10 of uint0
| D11 of uint0
| D12 of uint0
| D13 of uint0
| D14 of uint0
| D15 of uint0
| D16 of uint0
| D17 of uint0
| D18 of uint0
| D19 of uint0
| Da of uint0
| Db of uint0
| Dc of uint0
| Dd of uint0
| De of uint0
| Df of uint0

type uint1 =
| UIntDecimal of uint
| UIntHexadecimal of uint0

(** val one : int **)

let one =
  Stdlib.Int.succ 0

(** val add : int -> int -> int **)

let rec add = (+)

(** val sub : int -> int -> int **)

let rec sub = fun n m -> Stdlib.max 0 (n-m)

(** val tail_add : int -> int -> int **)

let rec tail_add n m =
  (fun fO fS n -> if n=0 then fO () else fS (n-1))
    (fun _ -> m)
    (fun n0 -> tail_add n0 (Stdlib.Int.succ m))
    n

(** val tail_addmul : int -> int -> int -> int **)

let rec tail_addmul r n m =
  (fun fO fS n -> if n=0 then fO () else fS (n-1))
    (fun _ -> r)
    (fun n0 -> tail_addmul (tail_add m r) n0 m)
    n

(** val tail_mul : int -> int -> int **)

let tail_mul n m =
  tail_addmul 0 n m

(** val of_uint_acc : uint -> int -> int **)

let rec of_uint_acc d acc =
  match d with
  | Nil -> acc
  | D0 d0 ->
    of_uint_acc d0
      (tail_mul (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ 0)))))))))) acc)
  | D1 d0 ->
    of_uint_acc d0 (Stdlib.Int.succ
      (tail_mul (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ 0)))))))))) acc))
  | D2 d0 ->
    of_uint_acc d0 (Stdlib.Int.succ (Stdlib.Int.succ
      (tail_mul (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ 0)))))))))) acc)))
  | D3 d0 ->
    of_uint_acc d0 (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
      (tail_mul (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ 0)))))))))) acc))))
  | D4 d0 ->
    of_uint_acc d0 (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
      (Stdlib.Int.succ
      (tail_mul (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ 0)))))))))) acc)))))
  | D5 d0 ->
    of_uint_acc d0 (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
      (Stdlib.Int.succ (Stdlib.Int.succ
      (tail_mul (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ 0)))))))))) acc))))))
  | D6 d0 ->
    of_uint_acc d0 (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
      (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
      (tail_mul (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ 0)))))))))) acc)))))))
  | D7 d0 ->
    of_uint_acc d0 (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
      (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
      (tail_mul (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ 0)))))))))) acc))))))))
  | D8 d0 ->
    of_uint_acc d0 (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
      (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
      (Stdlib.Int.succ
      (tail_mul (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ 0)))))))))) acc)))))))))
  | D9 d0 ->
    of_uint_acc d0 (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
      (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
      (Stdlib.Int.succ (Stdlib.Int.succ
      (tail_mul (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ 0)))))))))) acc))))))))))

(** val of_uint : uint -> int **)

let of_uint d =
  of_uint_acc d 0

(** val of_hex_uint_acc : uint0 -> int -> int **)

let rec of_hex_uint_acc d acc =
  match d with
  | Nil0 -> acc
  | D10 d0 ->
    of_hex_uint_acc d0
      (tail_mul (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ 0)))))))))))))))) acc)
  | D11 d0 ->
    of_hex_uint_acc d0 (Stdlib.Int.succ
      (tail_mul (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ 0)))))))))))))))) acc))
  | D12 d0 ->
    of_hex_uint_acc d0 (Stdlib.Int.succ (Stdlib.Int.succ
      (tail_mul (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ 0)))))))))))))))) acc)))
  | D13 d0 ->
    of_hex_uint_acc d0 (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
      (tail_mul (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ 0)))))))))))))))) acc))))
  | D14 d0 ->
    of_hex_uint_acc d0 (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
      (Stdlib.Int.succ
      (tail_mul (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ 0)))))))))))))))) acc)))))
  | D15 d0 ->
    of_hex_uint_acc d0 (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
      (Stdlib.Int.succ (Stdlib.Int.succ
      (tail_mul (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ 0)))))))))))))))) acc))))))
  | D16 d0 ->
    of_hex_uint_acc d0 (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
      (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
      (tail_mul (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ 0)))))))))))))))) acc)))))))
  | D17 d0 ->
    of_hex_uint_acc d0 (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
      (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
      (tail_mul (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ 0)))))))))))))))) acc))))))))
  | D18 d0 ->
    of_hex_uint_acc d0 (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
      (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
      (Stdlib.Int.succ
      (tail_mul (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ 0)))))))))))))))) acc)))))))))
  | D19 d0 ->
    of_hex_uint_acc d0 (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
      (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
      (Stdlib.Int.succ (Stdlib.Int.succ
      (tail_mul (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ 0)))))))))))))))) acc))))))))))
  | Da d0 ->
    of_hex_uint_acc d0 (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
      (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
      (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
      (tail_mul (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ 0)))))))))))))))) acc)))))))))))
  | Db d0 ->
    of_hex_uint_acc d0 (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
      (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
      (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
      (tail_mul (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ 0)))))))))))))))) acc))))))))))))
  | Dc d0 ->
    of_hex_uint_acc d0 (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
      (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
      (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
      (Stdlib.Int.succ
      (tail_mul (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ 0)))))))))))))))) acc)))))))))))))
  | Dd d0 ->
    of_hex_uint_acc d0 (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
      (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
      (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
      (Stdlib.Int.succ (Stdlib.Int.succ
      (tail_mul (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ 0)))))))))))))))) acc))))))))))))))
  | De d0 ->
    of_hex_uint_acc d0 (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
      (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
      (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
      (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
      (tail_mul (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ 0)))))))))))))))) acc)))))))))))))))
  | Df d0 ->
    of_hex_uint_acc d0 (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
      (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
      (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
      (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
      (tail_mul (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ 0)))))))))))))))) acc))))))))))))))))

(** val of_hex_uint : uint0 -> int **)

let of_hex_uint d =
  of_hex_uint_acc d 0

(** val of_num_uint : uint1 -> int **)

let of_num_uint = function
| UIntDecimal d0 -> of_uint d0
| UIntHexadecimal d0 -> of_hex_uint d0

(** val map : ('a1 -> 'a2) -> 'a1 list -> 'a2 list **)

let rec map f = function
| [] -> []
| a :: l0 -> (f a) :: (map f l0)

(** val rev : 'a1 list -> 'a1 list **)

let rec rev = function
| [] -> []
| x :: l' -> app (rev l') (x :: [])

(** val combine : 'a1 list -> 'a2 list -> ('a1 * 'a2) list **)

let rec combine l l' =
  match l with
  | [] -> []
  | x :: tl ->
    (match l' with
     | [] -> []
     | y :: tl' -> (x, y) :: (combine tl tl'))

type 'm monad = { ret : (__ -> __ -> 'm);
                  bind : (__ -> __ -> 'm -> (__ -> 'm) -> 'm) }

(** val ret : 'a1 monad -> 'a2 -> 'a1 **)

let ret monad0 x =
  Obj.magic monad0.ret __ x

(** val bind : 'a1 monad -> 'a1 -> ('a2 -> 'a1) -> 'a1 **)

let bind monad0 x x0 =
  Obj.magic monad0.bind __ __ x x0

(** val iffP : bool -> reflect -> reflect **)

let iffP _ pb =
  let _evar_0_ = fun _ _ _ -> ReflectT in
  let _evar_0_0 = fun _ _ _ -> ReflectF in
  (match pb with
   | ReflectT -> _evar_0_ __ __ __
   | ReflectF -> _evar_0_0 __ __ __)

(** val idP : bool -> reflect **)

let idP = function
| true -> ReflectT
| false -> ReflectF

type 't pred = 't -> bool

type 't rel = 't -> 't pred

type 't eq_axiom = 't -> 't -> reflect

module Coq_hasDecEq =
 struct
  type 't axioms_ = { eq_op : 't rel; eqP : 't eq_axiom }

  (** val eq_op : 'a1 axioms_ -> 'a1 rel **)

  let eq_op record =
    record.eq_op
 end

module Equality =
 struct
  type 't axioms_ =
    't Coq_hasDecEq.axioms_
    (* singleton inductive, whose constructor was Class *)

  (** val eqtype_hasDecEq_mixin : 'a1 axioms_ -> 'a1 Coq_hasDecEq.axioms_ **)

  let eqtype_hasDecEq_mixin record =
    record

  type coq_type =
    __ axioms_
    (* singleton inductive, whose constructor was Pack *)

  type sort = __

  (** val coq_class : coq_type -> sort axioms_ **)

  let coq_class record =
    record
 end

(** val eq_op0 : Equality.coq_type -> Equality.sort rel **)

let eq_op0 s =
  s.Coq_hasDecEq.eq_op

(** val eqnP : int eq_axiom **)

let eqnP n m =
  iffP ((=) n m) (idP ((=) n m))

(** val hB_unnamed_factory_1 : int Coq_hasDecEq.axioms_ **)

let hB_unnamed_factory_1 =
  { Coq_hasDecEq.eq_op = (=); Coq_hasDecEq.eqP = eqnP }

(** val datatypes_nat__canonical__eqtype_Equality : Equality.coq_type **)

let datatypes_nat__canonical__eqtype_Equality =
  Obj.magic hB_unnamed_factory_1

(** val addn : int -> int -> int **)

let addn =
  add

(** val subn : int -> int -> int **)

let subn =
  sub

(** val leq : int -> int -> bool **)

let leq m n =
  eq_op0 datatypes_nat__canonical__eqtype_Equality (Obj.magic subn m n)
    (Obj.magic 0)

(** val foldl : ('a2 -> 'a1 -> 'a2) -> 'a2 -> 'a1 list -> 'a2 **)

let rec foldl f z = function
| [] -> z
| x :: s' -> foldl f (f z x) s'

type 'a lazyList =
| Lnil
| Lcons of 'a * (unit -> 'a lazyList)

(** val lazy_seq : ('a1 -> 'a1) -> 'a1 -> int -> 'a1 lazyList **)

let rec lazy_seq s lo len =
  (fun fO fS n -> if n=0 then fO () else fS (n-1))
    (fun _ -> Lnil)
    (fun len' -> Lcons (lo, (fun _ -> lazy_seq s (s lo) len')))
    len

type randomSeed = Random.State.t

(** val newRandomSeed : randomSeed **)

let newRandomSeed = if Array.length Sys.argv <= 2 then Random.State.make_self_init () else Random.State.make (Array.init 10 (fun _ -> int_of_string (Sys.argv.(2))))

(** val randomSplit : randomSeed -> randomSeed * randomSeed **)

let randomSplit = (fun x -> (x,x))

(** val randomRNat : (int * int) -> randomSeed -> int * randomSeed **)

let randomRNat = (fun (x,y) r -> if y < x then failwith "choose called with unordered arguments" else  (x + (Random.State.full_int r (y - x + 1)), r))

type 'a choosableFromInterval = { randomR : (('a * 'a) -> randomSeed ->
                                            'a * randomSeed);
                                  enumR : (('a * 'a) -> 'a lazyList) }

(** val enumRNat : (int * int) -> int lazyList **)

let enumRNat p =
  lazy_seq (fun x -> Stdlib.Int.succ x) (fst p) (Stdlib.Int.succ
    (sub (snd p) (fst p)))

(** val chooseNat : int choosableFromInterval **)

let chooseNat =
  { randomR = randomRNat; enumR = enumRNat }

type 'g producer = { super : 'g monad; sample : (__ -> 'g -> __ list);
                     sized : (__ -> (int -> 'g) -> 'g);
                     resize : (__ -> int -> 'g -> 'g);
                     choose : (__ -> __ -> __ choosableFromInterval ->
                              (__ * __) -> 'g);
                     bindPf : (__ -> __ -> 'g -> (__ -> __ -> 'g) -> 'g) }

(** val choose :
    'a1 producer -> 'a2 choosableFromInterval -> ('a2 * 'a2) -> 'a1 **)

let choose producer0 h x =
  Obj.magic producer0.choose __ __ h x

(** val bindOpt : 'a1 producer -> 'a1 -> ('a2 -> 'a1) -> 'a1 **)

let bindOpt pG g0 f =
  bind pG.super g0 (fun ma ->
    match ma with
    | Some a -> f a
    | None -> ret pG.super None)

type 'a genType =
  int -> randomSeed -> 'a
  (* singleton inductive, whose constructor was MkGen *)

type 'a g = 'a genType

(** val run : 'a1 g -> int -> randomSeed -> 'a1 **)

let run g0 =
  g0

(** val returnGen : 'a1 -> 'a1 g **)

let returnGen x _ _ =
  x

(** val bindGen : 'a1 g -> ('a1 -> 'a2 g) -> 'a2 g **)

let bindGen g0 k n r =
  let (r1, r2) = randomSplit r in run (k (run g0 n r1)) n r2

(** val monadGen : __ g monad **)

let monadGen =
  { ret = (fun _ -> returnGen); bind = (fun _ _ -> bindGen) }

(** val createRange : int -> int list -> int list **)

let rec createRange n acc =
  (fun fO fS n -> if n=0 then fO () else fS (n-1))
    (fun _ -> rev (0 :: acc))
    (fun n' -> createRange n' (n :: acc))
    n

(** val rnds : randomSeed -> int -> randomSeed list **)

let rec rnds s n' =
  (fun fO fS n -> if n=0 then fO () else fS (n-1))
    (fun _ -> [])
    (fun n'' -> let (s1, s2) = randomSplit s in s1 :: (rnds s2 n''))
    n'

(** val sampleGen : 'a1 g -> 'a1 list **)

let sampleGen g0 =
  let l =
    combine
      (rnds newRandomSeed (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ 0)))))))))))))))))))))
      (createRange (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
        (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ 0)))))))))) [])
  in
  map (fun p -> let (r, n) = p in g0 n r) l

(** val sizedGen : (int -> 'a1 g) -> 'a1 g **)

let sizedGen f n r =
  run (f n) n r

(** val resizeGen : int -> 'a1 g -> 'a1 g **)

let resizeGen n g0 _ =
  g0 n

(** val chooseGen : 'a1 choosableFromInterval -> ('a1 * 'a1) -> 'a1 g **)

let chooseGen h range _ r =
  fst (h.randomR range r)

(** val producerGen : __ g producer **)

let producerGen =
  { super = monadGen; sample = (fun _ -> sampleGen); sized = (fun _ ->
    sizedGen); resize = (fun _ -> resizeGen); choose = (fun _ _ ->
    chooseGen); bindPf = (fun _ _ g0 k n r ->
    let (r1, r2) = randomSplit r in run (k (run g0 n r1) __) n r2) }

(** val thunkGen : (unit -> 'a1 g) -> 'a1 g **)

let thunkGen f n r =
  run (f ()) n r

(** val pickDrop :
    (int * 'a1 option g) list -> int -> (int * 'a1 option g) * (int * 'a1
    option g) list **)

let rec pickDrop xs n =
  match xs with
  | [] -> ((0, (ret (Obj.magic monadGen) None)), [])
  | p :: xs0 ->
    let (k, x) = p in
    if leq (Stdlib.Int.succ n) k
    then ((k, x), xs0)
    else let (p0, xs') = pickDrop xs0 (subn n k) in (p0, ((k, x) :: xs'))

(** val sum_fst : (int * 'a1) list -> int **)

let sum_fst gs =
  foldl (fun t p -> addn t (fst p)) 0 gs

(** val backtrackFuel :
    int -> int -> (int * 'a1 option g) list -> 'a1 option g **)

let rec backtrackFuel fuel tot gs =
  (fun fO fS n -> if n=0 then fO () else fS (n-1))
    (fun _ -> ret (Obj.magic monadGen) None)
    (fun fuel' ->
    bindGen
      (choose (Obj.magic producerGen) chooseNat (0,
        (subn tot (Stdlib.Int.succ 0))))
      (fun n ->
      let (p, gs') = pickDrop gs n in
      let (k, g0) = p in
      bindGen g0 (fun ma ->
        match ma with
        | Some a -> ret (Obj.magic monadGen) (Some a)
        | None -> incr failed_branches; backtrackFuel fuel' (subn tot k) gs')))
    fuel

(** val backtrack : (int * 'a1 option g) list -> 'a1 option g **)

let backtrack gs =
  backtrackFuel (length gs) (sum_fst gs) gs

type 'a genSizedSuchThat =
  int -> 'a option g
  (* singleton inductive, whose constructor was Build_GenSizedSuchThat *)

(** val checkable_size_limit : int **)

let checkable_size_limit = 10000

(** val mutual_fuel : int **)

let mutual_fuel =
  of_num_uint (UIntDecimal (D1 (D0 (D0 (D0 (D0 Nil))))))

(** val checker_backtrack : (unit -> bool option) list -> bool option **)

let checker_backtrack l =
  incr checker_calls;
  let rec aux l0 b =
    match l0 with
    | [] -> if b then None else Some false
    | t :: ts ->
      (match t () with
       | Some y -> if y then Some true else aux ts b
       | None -> aux ts true)
  in aux l false

(** val andBind : bool option -> bool option -> bool option **)

let andBind a b =
  match a with
  | Some b0 -> if b0 then b else a
  | None -> a

(** val genSizedSuchThatOriginal : int genSizedSuchThat **)

let genSizedSuchThatOriginal qc_size38_ =
  backtrack ((one,
    (thunkGen (fun _ ->
      bindOpt (Obj.magic producerGen)
        (let rec rec0 fuel init_size size =
           (fun fO fS n -> if n=0 then fO () else fS (n-1))
             (fun _ ->
             backtrack ((one, (thunkGen (fun _ -> returnGen (Some 0)))) :: []))
             (fun fuel' ->
             backtrack ((one,
               (thunkGen (fun _ -> returnGen (Some 0)))) :: ((size,
               (thunkGen (fun _ ->
                 bindOpt (Obj.magic producerGen)
                   (rec0 fuel' init_size (sub size (Stdlib.Int.succ 0)))
                   (fun x ->
                   returnGen (Some (Stdlib.Int.succ (Stdlib.Int.succ x))))))) :: [])))
             fuel
         in rec0 mutual_fuel qc_size38_ qc_size38_)
        (fun x ->
        match observe_check (let rec rec0 fuel init_size size v22_ =
                (fun fO fS n -> if n=0 then fO () else fS (n-1))
                  (fun _ ->
                  checker_backtrack ((fun _ ->
                    (fun fO fS n -> if n=0 then fO () else fS (n-1))
                      (fun _ -> Some true)
                      (fun _ -> Some false)
                      v22_) :: ((fun _ ->
                    None) :: [])))
                  (fun fuel' ->
                  checker_backtrack ((fun _ ->
                    (fun fO fS n -> if n=0 then fO () else fS (n-1))
                      (fun _ -> Some true)
                      (fun _ -> Some false)
                      v22_) :: ((fun _ ->
                    (fun fO fS n -> if n=0 then fO () else fS (n-1))
                      (fun _ -> Some false)
                      (fun n ->
                      (fun fO fS n -> if n=0 then fO () else fS (n-1))
                        (fun _ -> Some false)
                        (fun n0 ->
                        (fun fO fS n -> if n=0 then fO () else fS (n-1))
                          (fun _ -> Some false)
                          (fun x0 ->
                          andBind
                            (rec0 fuel' init_size
                              (sub size (Stdlib.Int.succ 0)) x0)
                            (Some true))
                          n0)
                        n)
                      v22_) :: [])))
                  fuel
              in rec0 mutual_fuel checkable_size_limit checkable_size_limit x) with
        | Some b -> if b then returnGen (Some x) else returnGen None
        | None -> returnGen None)))) :: [])

(** val genSizedSuchThatReversed : int genSizedSuchThat **)

let genSizedSuchThatReversed qc_size71_ =
  backtrack ((one,
    (thunkGen (fun _ ->
      bindOpt (Obj.magic producerGen)
        (let rec rec0 fuel init_size size =
           (fun fO fS n -> if n=0 then fO () else fS (n-1))
             (fun _ ->
             backtrack ((one, (thunkGen (fun _ -> returnGen (Some 0)))) :: []))
             (fun fuel' ->
             backtrack ((one,
               (thunkGen (fun _ -> returnGen (Some 0)))) :: ((size,
               (thunkGen (fun _ ->
                 bindOpt (Obj.magic producerGen)
                   (rec0 fuel' init_size (sub size (Stdlib.Int.succ 0)))
                   (fun x ->
                   returnGen (Some (Stdlib.Int.succ (Stdlib.Int.succ
                     (Stdlib.Int.succ x)))))))) :: [])))
             fuel
         in rec0 mutual_fuel qc_size71_ qc_size71_)
        (fun x ->
        match observe_check (let rec rec0 fuel init_size size v55_ =
                (fun fO fS n -> if n=0 then fO () else fS (n-1))
                  (fun _ ->
                  checker_backtrack ((fun _ ->
                    (fun fO fS n -> if n=0 then fO () else fS (n-1))
                      (fun _ -> Some true)
                      (fun _ -> Some false)
                      v55_) :: ((fun _ ->
                    None) :: [])))
                  (fun fuel' ->
                  checker_backtrack ((fun _ ->
                    (fun fO fS n -> if n=0 then fO () else fS (n-1))
                      (fun _ -> Some true)
                      (fun _ -> Some false)
                      v55_) :: ((fun _ ->
                    (fun fO fS n -> if n=0 then fO () else fS (n-1))
                      (fun _ -> Some false)
                      (fun n ->
                      (fun fO fS n -> if n=0 then fO () else fS (n-1))
                        (fun _ -> Some false)
                        (fun x0 ->
                        andBind
                          (rec0 fuel' init_size
                            (sub size (Stdlib.Int.succ 0)) x0)
                          (Some true))
                        n)
                      v55_) :: [])))
                  fuel
              in rec0 mutual_fuel checkable_size_limit checkable_size_limit x) with
        | Some b -> if b then returnGen (Some x) else returnGen None
        | None -> returnGen None)))) :: [])

(** val genSizedSuchThatMerged : int genSizedSuchThat **)

let genSizedSuchThatMerged qc_size105_ =
  backtrack ((one,
    (thunkGen (fun _ ->
      bindOpt (Obj.magic producerGen)
        (let rec rec0 fuel init_size size =
           (fun fO fS n -> if n=0 then fO () else fS (n-1))
             (fun _ ->
             backtrack ((one, (thunkGen (fun _ -> returnGen (Some 0)))) :: []))
             (fun fuel' ->
             backtrack ((one,
               (thunkGen (fun _ -> returnGen (Some 0)))) :: ((size,
               (thunkGen (fun _ ->
                 bindOpt (Obj.magic producerGen)
                   (rec0 fuel' init_size (sub size (Stdlib.Int.succ 0)))
                   (fun x ->
                   returnGen (Some (Stdlib.Int.succ (Stdlib.Int.succ
                     (Stdlib.Int.succ x)))))))) :: [])))
             fuel
         in rec0 mutual_fuel qc_size105_ qc_size105_)
        (fun x' ->
        match observe_check (let v88_ = Stdlib.Int.succ x' in
              let rec rec0 fuel init_size size v88_0 =
                (fun fO fS n -> if n=0 then fO () else fS (n-1))
                  (fun _ ->
                  checker_backtrack ((fun _ ->
                    (fun fO fS n -> if n=0 then fO () else fS (n-1))
                      (fun _ -> Some true)
                      (fun _ -> Some false)
                      v88_0) :: ((fun _ ->
                    None) :: [])))
                  (fun fuel' ->
                  checker_backtrack ((fun _ ->
                    (fun fO fS n -> if n=0 then fO () else fS (n-1))
                      (fun _ -> Some true)
                      (fun _ -> Some false)
                      v88_0) :: ((fun _ ->
                    (fun fO fS n -> if n=0 then fO () else fS (n-1))
                      (fun _ -> Some false)
                      (fun n ->
                      (fun fO fS n -> if n=0 then fO () else fS (n-1))
                        (fun _ -> Some false)
                        (fun x ->
                        andBind
                          (rec0 fuel' init_size
                            (sub size (Stdlib.Int.succ 0)) x)
                          (Some true))
                        n)
                      v88_0) :: [])))
                  fuel
              in rec0 mutual_fuel checkable_size_limit checkable_size_limit
                   v88_) with
        | Some b ->
          if b
          then returnGen (Some (Stdlib.Int.succ (Stdlib.Int.succ
                 (Stdlib.Int.succ x'))))
          else returnGen None
        | None -> returnGen None)))) :: ((one,
    (thunkGen (fun _ -> returnGen (Some 0)))) :: []))

(** val genSizedSuchThatAgentic : int genSizedSuchThat **)

let genSizedSuchThatAgentic qc_size115_ =
  let rec rec0 fuel init_size size =
    (fun fO fS n -> if n=0 then fO () else fS (n-1))
      (fun _ ->
      backtrack ((one, (thunkGen (fun _ -> returnGen (Some 0)))) :: []))
      (fun fuel' ->
      backtrack ((one, (thunkGen (fun _ -> returnGen (Some 0)))) :: ((size,
        (thunkGen (fun _ ->
          bindOpt (Obj.magic producerGen)
            (rec0 fuel' init_size (sub size (Stdlib.Int.succ 0))) (fun x ->
            returnGen (Some (Stdlib.Int.succ (Stdlib.Int.succ
              (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
              (Stdlib.Int.succ x))))))))))) :: [])))
      fuel
  in rec0 mutual_fuel qc_size115_ qc_size115_

(** val original : int -> int option g **)

let original =
  genSizedSuchThatOriginal

(** val reversed : int -> int option g **)

let reversed =
  genSizedSuchThatReversed

(** val merged : int -> int option g **)

let merged =
  genSizedSuchThatMerged

(** val agentic : int -> int option g **)

let agentic =
  genSizedSuchThatAgentic

(** val sample_original : int -> randomSeed -> int option **)

let sample_original size =
  run (original size) size

(** val sample_reversed : int -> randomSeed -> int option **)

let sample_reversed size =
  run (reversed size) size

(** val sample_merged : int -> randomSeed -> int option **)

let sample_merged size =
  run (merged size) size

(** val sample_agentic : int -> randomSeed -> int option **)

let sample_agentic size =
  run (agentic size) size
