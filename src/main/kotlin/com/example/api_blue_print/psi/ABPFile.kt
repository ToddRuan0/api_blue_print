package com.example.api_blue_print.psi

import com.intellij.extapi.psi.PsiFileBase
import com.intellij.openapi.fileTypes.FileType
import com.intellij.psi.FileViewProvider
import com.example.api_blue_print.ABPFileType
import com.example.api_blue_print.ABPLanguage


class ABPFile(viewProvider: FileViewProvider) :
    PsiFileBase(viewProvider, ABPLanguage.INSTANCE) {
    override fun getFileType(): FileType {
        return ABPFileType.INSTANCE
    }

    override fun toString(): String {
        return "ABP File"
    }
}