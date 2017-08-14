#!/usr/bin/env ocaml
#directory "pkg"
#use "topfind"
#require "topkg"
#require "ocb-stubblr.topkg"
open Topkg
open Ocb_stubblr_topkg

let build = Pkg.build ~cmd ()

let () =
  Pkg.describe "salsa20-core" ~build @@ fun _c ->
  Ok [
    Pkg.clib "libsalsa-core.clib";
    Pkg.mllib ~api:["Salsa20_core"] "salsa20-core.mllib";
    Pkg.test "salsa20_core_tests";
    Pkg.test "utils_tests"
  ]
