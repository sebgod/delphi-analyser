%----------------------------------------------------------------------------%
% vim: ft=mercury ff=unix ts=4 sw=4 et
%----------------------------------------------------------------------------%
% File: parser.m
% Copyright © 2015 Sebastian Godelet
% Main author: Sebastian Godelet <sebastian.godelet@outlook.com>
% Created on: Sun Sep 13 16:03:33 CST 2015
% Stability: low
%----------------------------------------------------------------------------%
% Parses Delphi source files.
%----------------------------------------------------------------------------%

:- module parser.

:- interface.

:- import_module list.

:- import_module scanner.

%----------------------------------------------------------------------------%

:- type ast
    --->    program(string)
    ;       library(string)
    ;       unit(list(string))
    ;       package(string)
    .

:- inst program ---> program(ground).
:- inst library ---> library(ground).
:- inst unit    ---> unit(list(ground)).
:- inst package ---> package(ground).

:- type parse_pred == pred(tokens, tokens).

:- inst parse_pred == (pred(in, out) is semidet).

:- pred parse(ast::out) : parse_pred `with_inst` parse_pred.

%----------------------------------------------------------------------------%
%----------------------------------------------------------------------------%

:- implementation.

:- include_module parser.program.
:- include_module parser.library.
:- include_module parser.unit.
:- include_module parser.package.

:- import_module parser.program.
:- import_module parser.library.
:- import_module parser.unit.
:- import_module parser.package.

%----------------------------------------------------------------------------%

parse(Program) -->
    [program],
    parse_program(Program).

parse(Library) -->
    [library],
    parse_library(Library).

parse(Unit) -->
    [unit],
    parse_unit(Unit).

parse(Package) -->
    [package],
    parse_package(Package).

%----------------------------------------------------------------------------%
:- end_module parser.
%----------------------------------------------------------------------------%
