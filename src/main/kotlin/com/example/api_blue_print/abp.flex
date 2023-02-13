package com.example.api_blue_print;

import com.intellij.lexer.FlexLexer;
import com.intellij.psi.tree.IElementType;
import com.example.api_blue_print.psi.ABPTypes;
import com.intellij.psi.TokenType;
%%

%class ABPLexer
%implements FlexLexer
%unicode
%function advance
%type IElementType
%eof{  return;
%eof}

CRLF=\R
WHITE_SPACE=[\ \n\t\f]
word = [^\ \n\t\f#\+\{]+
string = ({word}{WHITE_SPACE}*)+

level1T = #{WHITE_SPACE}*
level2T = #{2}{WHITE_SPACE}*
level3T = #{3}{WHITE_SPACE}*
level4T = #{4}{WHITE_SPACE}*
level5T = #{5}{WHITE_SPACE}*
list_begin = \+{WHITE_SPACE}*

%state WAITING_VALUE

%%

//<YYINITIAL> {KEY_CHARACTER}+                                { yybegin(YYINITIAL); return ABPTypes.KEY; }

//<YYINITIAL> {SEPARATOR}                                     { yybegin(WAITING_VALUE); return ABPTypes.SEPARATOR; }

<WAITING_VALUE> {CRLF}({CRLF}|{WHITE_SPACE})+               { yybegin(YYINITIAL); return TokenType.WHITE_SPACE; }

<WAITING_VALUE> {WHITE_SPACE}+                              { yybegin(WAITING_VALUE); return TokenType.WHITE_SPACE; }

//<WAITING_VALUE> {FIRST_VALUE_CHARACTER}{VALUE_CHARACTER}*   { yybegin(YYINITIAL); return ABPTypes.VALUE; }

({CRLF}|{WHITE_SPACE})+                                     { yybegin(YYINITIAL); return TokenType.WHITE_SPACE; }

{level5T}                                                   { yybegin(YYINITIAL); return ABPTypes.LEVEL_5_T; }

{level4T}                                                   { yybegin(YYINITIAL); return ABPTypes.LEVEL_4_T; }

{level3T}                                                   { yybegin(YYINITIAL); return ABPTypes.LEVEL_3_T; }

{level2T}                                                   { yybegin(YYINITIAL); return ABPTypes.LEVEL_2_T; }

{level1T}                                                   { yybegin(YYINITIAL); return ABPTypes.LEVEL_1_T; }

{list_begin}                                                { yybegin(YYINITIAL); return ABPTypes.LIST_BEGIN; }

{string}                                                    { yybegin(YYINITIAL); return ABPTypes.STRING; }

[^]                                                         { return TokenType.BAD_CHARACTER; }