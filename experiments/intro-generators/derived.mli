
type __ = Obj.t

type reflect =
| ReflectT
| ReflectF

val fst : ('a1 * 'a2) -> 'a1

val snd : ('a1 * 'a2) -> 'a2

val length : 'a1 list -> int

val app : 'a1 list -> 'a1 list -> 'a1 list

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

val one : int

val add : int -> int -> int

val sub : int -> int -> int

val tail_add : int -> int -> int

val tail_addmul : int -> int -> int -> int

val tail_mul : int -> int -> int

val of_uint_acc : uint -> int -> int

val of_uint : uint -> int

val of_hex_uint_acc : uint0 -> int -> int

val of_hex_uint : uint0 -> int

val of_num_uint : uint1 -> int

val map : ('a1 -> 'a2) -> 'a1 list -> 'a2 list

val rev : 'a1 list -> 'a1 list

val combine : 'a1 list -> 'a2 list -> ('a1 * 'a2) list

type 'm monad = { ret : (__ -> __ -> 'm);
                  bind : (__ -> __ -> 'm -> (__ -> 'm) -> 'm) }

val ret : 'a1 monad -> 'a2 -> 'a1

val bind : 'a1 monad -> 'a1 -> ('a2 -> 'a1) -> 'a1

val iffP : bool -> reflect -> reflect

val idP : bool -> reflect

type 't pred = 't -> bool

type 't rel = 't -> 't pred

type 't eq_axiom = 't -> 't -> reflect

module Coq_hasDecEq :
 sig
  type 't axioms_ = { eq_op : 't rel; eqP : 't eq_axiom }

  val eq_op : 'a1 axioms_ -> 'a1 rel
 end

module Equality :
 sig
  type 't axioms_ =
    't Coq_hasDecEq.axioms_
    (* singleton inductive, whose constructor was Class *)

  val eqtype_hasDecEq_mixin : 'a1 axioms_ -> 'a1 Coq_hasDecEq.axioms_

  type coq_type =
    __ axioms_
    (* singleton inductive, whose constructor was Pack *)

  type sort = __

  val coq_class : coq_type -> sort axioms_
 end

val eq_op0 : Equality.coq_type -> Equality.sort rel

val eqnP : int eq_axiom

val hB_unnamed_factory_1 : int Coq_hasDecEq.axioms_

val datatypes_nat__canonical__eqtype_Equality : Equality.coq_type

val addn : int -> int -> int

val subn : int -> int -> int

val leq : int -> int -> bool

val foldl : ('a2 -> 'a1 -> 'a2) -> 'a2 -> 'a1 list -> 'a2

type 'a lazyList =
| Lnil
| Lcons of 'a * (unit -> 'a lazyList)

val lazy_seq : ('a1 -> 'a1) -> 'a1 -> int -> 'a1 lazyList

type randomSeed = Random.State.t

val newRandomSeed : randomSeed

val randomSplit : randomSeed -> randomSeed * randomSeed

val randomRNat : (int * int) -> randomSeed -> int * randomSeed

type 'a choosableFromInterval = { randomR : (('a * 'a) -> randomSeed ->
                                            'a * randomSeed);
                                  enumR : (('a * 'a) -> 'a lazyList) }

val enumRNat : (int * int) -> int lazyList

val chooseNat : int choosableFromInterval

type 'g producer = { super : 'g monad; sample : (__ -> 'g -> __ list);
                     sized : (__ -> (int -> 'g) -> 'g);
                     resize : (__ -> int -> 'g -> 'g);
                     choose : (__ -> __ -> __ choosableFromInterval ->
                              (__ * __) -> 'g);
                     bindPf : (__ -> __ -> 'g -> (__ -> __ -> 'g) -> 'g) }

val choose : 'a1 producer -> 'a2 choosableFromInterval -> ('a2 * 'a2) -> 'a1

val bindOpt : 'a1 producer -> 'a1 -> ('a2 -> 'a1) -> 'a1

type 'a genType =
  int -> randomSeed -> 'a
  (* singleton inductive, whose constructor was MkGen *)

type 'a g = 'a genType

val run : 'a1 g -> int -> randomSeed -> 'a1

val returnGen : 'a1 -> 'a1 g

val bindGen : 'a1 g -> ('a1 -> 'a2 g) -> 'a2 g

val monadGen : __ g monad

val createRange : int -> int list -> int list

val rnds : randomSeed -> int -> randomSeed list

val sampleGen : 'a1 g -> 'a1 list

val sizedGen : (int -> 'a1 g) -> 'a1 g

val resizeGen : int -> 'a1 g -> 'a1 g

val chooseGen : 'a1 choosableFromInterval -> ('a1 * 'a1) -> 'a1 g

val producerGen : __ g producer

val thunkGen : (unit -> 'a1 g) -> 'a1 g

val pickDrop :
  (int * 'a1 option g) list -> int -> (int * 'a1 option g) * (int * 'a1
  option g) list

val sum_fst : (int * 'a1) list -> int

val backtrackFuel : int -> int -> (int * 'a1 option g) list -> 'a1 option g

val backtrack : (int * 'a1 option g) list -> 'a1 option g

type 'a genSizedSuchThat =
  int -> 'a option g
  (* singleton inductive, whose constructor was Build_GenSizedSuchThat *)

val checkable_size_limit : int

val mutual_fuel : int

val checker_backtrack : (unit -> bool option) list -> bool option

val andBind : bool option -> bool option -> bool option

val genSizedSuchThatOriginal : int genSizedSuchThat

val genSizedSuchThatReversed : int genSizedSuchThat

val genSizedSuchThatMerged : int genSizedSuchThat

val genSizedSuchThatAgentic : int genSizedSuchThat

val original : int -> int option g

val reversed : int -> int option g

val merged : int -> int option g

val agentic : int -> int option g

val sample_original : int -> randomSeed -> int option

val sample_reversed : int -> randomSeed -> int option

val sample_merged : int -> randomSeed -> int option

val sample_agentic : int -> randomSeed -> int option
