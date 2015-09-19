%----------------------------------------------------------------------------%
% vim: ft=mercury ff=unix ts=4 sw=4 et
%----------------------------------------------------------------------------%
% File: scanner.m
% Copyright © 2015 Sebastian Godelet
% Main author: Sebastian Godelet <sebastian.godelet@outlook.com>
% Created on: Sat Sep 19 11:57:42 CST 2015
% Stability: low
%----------------------------------------------------------------------------%
% Scans Delphi source files into tokens.
%----------------------------------------------------------------------------%

:- module scanner.

:- interface.

:- import_module char.
:- import_module list.

%----------------------------------------------------------------------------%

:- type chars == list(char).

:- type tokens == list(token).

:- type token
    --->    program
    ;       library
    ;       unit
    ;       package
    ;       (type)
    ;       (interface)
    ;       (implementation)
    ;       uses
    ;       name(string)
    ;       string(string)
    ;       dotted_name(list(string))
    ;       int(int)
    ;       char(char)
    ;       (:)
    ;       (',')
    ;       ('.')
    .

:- type scan_pred == pred(chars, chars).

:- inst scan_pred == (pred(in, out) is semidet).

:- pred scan(tokens::out) : scan_pred `with_inst` scan_pred.

%----------------------------------------------------------------------------%
%----------------------------------------------------------------------------%

:- implementation.

%----------------------------------------------------------------------------%

scan([]) -->
    [].

%----------------------------------------------------------------------------%
:- end_module scanner.
%----------------------------------------------------------------------------%
