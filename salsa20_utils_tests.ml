open Salsa20_core.Utils

let test_of_hex input output =
  let o = input |> of_hex |> Cstruct.to_string in
  (fun () -> Alcotest.check Alcotest.string "of_hex test" output o)

let of_hex_test1 =
  let input = "202122232425262728292a2b2c2d2e2f" ^
              "303132333435363738393a3b3c3d3e3f" ^
              "404142434445464748494a4b4c4d4e4f" ^
              "505152535455565758595a5b5c5d5e5f" ^
              "606162636465666768696a6b6c6d6e6f" ^
              "707172737475767778797a7b7c7d7e"
  and output = " !\"#$%&'()*+,-./0123456789:;<=>?@" ^
               "ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_`" ^
               "abcdefghijklmnopqrstuvwxyz{|}~" in
  test_of_hex input output

let of_hex_test2 =
  test_of_hex "" ""

let test_of_hex_invalid_arg input msg =
  (fun () ->
     Alcotest.check_raises
       msg
       (Invalid_argument msg)
       (fun () -> ignore (of_hex input)))

let of_hex_test3 =
  test_of_hex_invalid_arg "abc" "Odd-length string"

let of_hex_test4 = 
  test_of_hex_invalid_arg "a bx" "Non-hexadecimal digit"

let of_hex_tests = [
  "Test Case 1", `Quick, of_hex_test1;
  "Test Case 2", `Quick, of_hex_test2;
  "Test Case 3", `Quick, of_hex_test3;
  "Test Case 4", `Quick, of_hex_test4;
]

let () =
  Alcotest.run "Utils Tests" [
    "of_hex tests", of_hex_tests;
  ]
