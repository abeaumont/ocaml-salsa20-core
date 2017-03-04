#!/usr/bin/env ocaml
#directory "pkg"
#use "topfind"
#require "topkg"
open Topkg

let () =
  Pkg.describe "salsa20-core" @@ fun _c ->
  Ok [
    Pkg.mllib "salsa20-core.mllib";
    Pkg.test "salsa20_core_tests"
  ]
