package com.example.api_blue_print.psi

import com.intellij.psi.tree.IElementType
import com.example.api_blue_print.ABPLanguage
import org.jetbrains.annotations.NonNls


class ABPElementType(@NonNls debugName: String) :
    IElementType(debugName, ABPLanguage.INSTANCE)