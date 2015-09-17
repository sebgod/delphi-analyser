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

:- import_module char.
:- import_module list.

%----------------------------------------------------------------------------%

:- type chars == list(char).

:- type ast
    --->    program
    ;       library
    ;       unit
    ;       package.

:- inst program ---> program.

:- pred parse(ast::out, chars::in, chars::out) is semidet.

%----------------------------------------------------------------------------%
%----------------------------------------------------------------------------%

:- implementation.

:- include_module parser.program.
:- import_module parser.program.
%:- include_module parser.library.
%:- include_module parser.unit.
%:- include_module parser.package.

%----------------------------------------------------------------------------%

parse(Program) -->
    [p, r, o, g, r, a, m],
    parse_program(Program).

parse(library) -->
    [l, i, b, r, a, r, y].

parse(unit) -->
    [u, n, i, t].

parse(package) -->
    [p, a, c, k, a, g, e].

%----------------------------------------------------------------------------%
:- end_module parser.
%----------------------------------------------------------------------------%
