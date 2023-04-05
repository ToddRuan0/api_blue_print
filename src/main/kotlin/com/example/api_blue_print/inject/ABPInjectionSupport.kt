package com.example.api_blue_print.inject

import org.intellij.plugins.intelliLang.inject.AbstractLanguageInjectionSupport
import com.intellij.json.psi.JsonObject


class ABPInjectionSupport : AbstractLanguageInjectionSupport() {
    override fun getId(): String {
        return "api_blue_print";
    }

    override fun getPatternClasses(): Array<Class<*>> {
       return arrayOf(JsonObject::class.java)
    }
}