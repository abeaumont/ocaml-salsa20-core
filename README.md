[![docs](https://img.shields.io/badge/doc-online-blue.svg)](https://abeaumont.github.io/ocaml-salsa20-core)
[![Build Status](https://travis-ci.org/abeaumont/ocaml-salsa20-core.svg?branch=master)](https://travis-ci.org/abeaumont/ocaml-salsa20-core)

# The Salsa20 core functions, in OCaml

An OCaml implementation of [Salsa20 Core](http://cr.yp.to/salsa20.html) functions, both Salsa20/20 Core and the reduced Salsa20/8 Core and Salsa20/12 Core functions.
The hot loop is implemented in C for efficiency reasons.

Salsa 20 Core are functions from 64-byte strings to 64-byte strings.

## Installation

```
opam install salsa20-core
```

## Usage

```ocaml
utop[0]> #require "salsa20-core";;
utop[1]> 0
|> Char.chr
|> String.make 64
|> Cstruct.of_string
|> Salsa20_core.salsa20_20_core (* or salsa20_12_core / salsa20_8_core *)
|> Cstruct.to_string;;
- : string =
"\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000"
```
