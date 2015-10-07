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
:- import_module io.
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
    ;       int(int)
    ;       char(char)
    ;       begin
    ;       end
    ;       (if)
    ;       (and)
    ;       (or)
    ;       (:)
    ;       (',')
    ;       ('.')
    ;       error(io.error)
    ;       eof
    .

:- pred scan_until_eof(tokens::out, io::di, io::uo) is det.

:- pred scan_next(token::out, io::di, io::uo) is det.

%----------------------------------------------------------------------------%
%----------------------------------------------------------------------------%

:- implementation.

:- import_module string.

%----------------------------------------------------------------------------%

scan_until_eof([Token | Tokens], !IO) :-
    scan_next(Token, !IO),
    ( if Token \= eof then
        scan_until_eof(Tokens, !IO)
    else
        Tokens = []
    ).

scan_next(Token, !IO) :-
    read_word(Result, !IO),
    ( Result = ok(Word),
        Token =
            ( if parse_token(PossibleToken, Word, []) then
                PossibleToken
            else
                make_error_token("unrecognised token: %s",
                                 [chars_to_poly_type(Word)])
            )
    ; Result = error(Error),
        Token = error(Error)
    ; Result = eof,
        Token = eof
    ).

parse_token(program) --> [p, r, o, g, r, a, m].
parse_token(library) --> [l, i, b, r, a, r, y].
parse_token(unit) --> [u, n, i, t].
parse_token(package) --> [p, a, c, k, a, g, e].
parse_token((type)) --> [t, y, p, e].
parse_token((interface)) --> [i, n, t, e, r, f, a, c, e].
parse_token((implementation)) --> [i, m, p, l, e, m, e, n, t, a, t, i, o, n].
parse_token(uses) --> [u, s, e, s].
parse_token(name("Not implemented")) --> [].
parse_token(string("Not implemented")) --> ['\''].
parse_token(int(0)) --> [].
% parse_token(char('')) --> [].
parse_token(begin) --> [].
parse_token(end) --> [].
parse_token((if)) --> [].
parse_token((and)) --> [].
parse_token((or)) --> [].
parse_token((:)) --> [].
parse_token((',')) --> [].
parse_token(('.')) --> ['.'].

%----------------------------------------------------------------------------%
% Utility functions
%

:- func make_error_token(string, list(io.poly_type)) = token.

make_error_token(Format, Params) =
    error(make_io_error(format(Format, Params))).

:- func chars_to_poly_type(chars) = io.poly_type.

chars_to_poly_type(Token) = s(from_char_list(Token)).

%----------------------------------------------------------------------------%
:- end_module scanner.
%----------------------------------------------------------------------------%
