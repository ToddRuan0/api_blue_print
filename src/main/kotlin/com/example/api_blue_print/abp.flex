package com.example.api_blue_print;

import com.intellij.lexer.FlexLexer;
import com.intellij.psi.tree.IElementType;
import com.example.api_blue_print.psi.ABPTypes;
import com.intellij.psi.TokenType;
import java.util.Stack;
%%

%class ABPLexer
%implements FlexLexer
%unicode
%function advance
%type IElementType
%{
    int lastIndentDepth;
    Stack<Integer> stack;
    Boolean isInline = false;
%}

CRLF=\R
WHITE_SPACE=[\ \n\t\f]
INDENT = {CRLF}{SPACE}*
SPACE=[\ \t\f]
word = [^\ \n\t\f#\+\{\}]+
line = ({SPACE}*{word}{SPACE}*)+

level1T = #{SPACE}{line}
level2T = #{2}{SPACE}{line}
level3T = #{3}{SPACE}{line}
level4T = #{4}{SPACE}{line}
level5T = #{5}{SPACE}{line}
list_begin = \+
left_brace = \{
right_brace = \}

%state WAITING_VALUE
%state LIST

%%

<WAITING_VALUE> {CRLF}({CRLF}|{WHITE_SPACE})+               { yybegin(YYINITIAL); return TokenType.WHITE_SPACE; }

<WAITING_VALUE> {WHITE_SPACE}+                              { yybegin(WAITING_VALUE); return TokenType.WHITE_SPACE; }

<LIST> {
    {INDENT}{2} {
          yypushback(yylength() - 1);
          return TokenType.WHITE_SPACE;
    }

    {INDENT} {
          isInline = false;
          int indentDepth = yylength() / 4;
          if (indentDepth > lastIndentDepth) {
              lastIndentDepth = indentDepth;
              return TokenType.WHITE_SPACE;
          } else if (indentDepth < lastIndentDepth) {
              stack.pop();
              lastIndentDepth = stack.peek();
              yypushback(yylength());
              return ABPTypes.LIST_END;
          } else {
              stack.pop();
              return ABPTypes.LIST_END;
          }
    }

    {list_begin} {
         if (isInline) {
             lastIndentDepth++;
         }
         
         isInline = true;
         stack.push(lastIndentDepth);
         return ABPTypes.LIST_BEGIN;
    }

    {left_brace} {
          yybegin(YYINITIAL);
          return ABPTypes.LEFT_BRACE;
      }


    [#] {
          stack.pop();
          if (stack.empty()) {
              yybegin(YYINITIAL);
          }

          yypushback(yylength());
          return ABPTypes.LIST_END;
      }
}

<YYINITIAL> {
    {level5T}         { yybegin(YYINITIAL); return ABPTypes.LEVEL_5_T; }

    {level4T}         { yybegin(YYINITIAL); return ABPTypes.LEVEL_4_T; }

    {level3T}         { yybegin(YYINITIAL); return ABPTypes.LEVEL_3_T; }

    {level2T}         { yybegin(YYINITIAL); return ABPTypes.LEVEL_2_T; }

    {level1T}         { yybegin(YYINITIAL); return ABPTypes.LEVEL_1_T; }

    {list_begin}      {
          yybegin(LIST);
          lastIndentDepth = 0;
          stack = new Stack<Integer>();
          stack.push(0);
          return ABPTypes.LIST_BEGIN;
    }
}

({CRLF}|{WHITE_SPACE})+                                     { return TokenType.WHITE_SPACE; }

{right_brace} {yybegin(LIST); return ABPTypes.RIGHT_BRACE; }

{line}                                                    { return ABPTypes.LINE; }

[^]                                                         { return TokenType.BAD_CHARACTER; }