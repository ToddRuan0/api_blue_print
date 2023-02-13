package com.example.api_blue_print

import com.intellij.openapi.fileTypes.LanguageFileType;
import javax.swing.Icon

class ABPFileType private constructor() : LanguageFileType(ABPLanguage.INSTANCE) {
    override fun getName(): String {
        return "API Blue Print"
    }

    override fun getDescription(): String {
        return "ABP language file"
    }

    override fun getDefaultExtension(): String {
        return "apib"
    }

    override fun getIcon(): Icon {
        return ABPIcons.FILE
    }

    companion object {
        val INSTANCE = ABPFileType()
    }
}