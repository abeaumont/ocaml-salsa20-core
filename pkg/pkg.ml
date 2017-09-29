#!/usr/bin/env ocaml
#directory "pkg"
#use "topfind"
#require "topkg"
#require "ocb-stubblr.topkg"
open Topkg
open Ocb_stubblr_topkg

let xen  = Conf.(key "xen" bool ~absent:false
                   ~doc:"Build Mirage/Xen support.")
let fs   = Conf.(key "freestanding" bool ~absent:false
                   ~doc:"Build Mirage/Solo5 support.")

let build = Pkg.build ~cmd ()

let () =
  Pkg.describe "salsa20-core" ~build @@ fun c ->
  let xen  = Conf.value c xen
  and fs   = Conf.value c fs
  in
  Ok [
    Pkg.clib "libsalsa-core.clib";
    Pkg.mllib ~api:["Salsa20_core"] "salsa20-core.mllib";
    Pkg.test "salsa20_core_tests";
    Pkg.test "utils_tests";
    mirage ~xen ~fs "libsalsa-core.clib";
  ]
