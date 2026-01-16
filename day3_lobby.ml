open Hardcaml
open Signal
open Always

module I = struct
  type 'a t =
    { clock : 'a
    ; reset : 'a
    ; start : 'a
    ; digit : 'a [@bits 4]
    }
  [@@deriving hardcaml]
end

module O = struct
  type 'a t =
    { done_ : 'a
    ; result : 'a [@bits 8]
    }
  [@@deriving hardcaml]
end

let create _scope (i : _ I.t) =
  let spec =
    Reg_spec.create ~clock:i.clock ~clear:i.reset ()
  in

  (* Registers *)
  let max_tens = Variable.reg spec ~width:4 in
  let max_ones = Variable.reg spec ~width:4 in
  let done_ = Variable.reg spec ~width:1 in

  let greater = i.digit >: max_tens.value in

  compile
    [ when_ greater
        [ max_tens <-- i.digit
        ; max_ones <-- max_tens.value
        ]
    ; when_ i.start
        [ done_ <-- vdd ]
    ];

  (* Compute tens * 10, then resize correctly *)
  let tens_mul =
    uresize
      (max_tens.value *: uresize (Signal.of_int ~width:4 10) 4)
      8
  in

  (* Add the ones and resize to 8 bits *)
  let result =
    tens_mul +: uresize max_ones.value 8
  in

  { O.done_ = done_.value
  ; result
  }
