package com.example.api_blue_print.psi

import com.intellij.psi.tree.TokenSet

interface ABPTokenSets {
    companion object {
        val level1T = TokenSet.create(ABPTypes.LEVEL_1_T)
        val level2T = TokenSet.create(ABPTypes.LEVEL_2_T)
        val level3T = TokenSet.create(ABPTypes.LEVEL_3_T)
        val level4T = TokenSet.create(ABPTypes.LEVEL_4_T)
        val level5T = TokenSet.create(ABPTypes.LEVEL_5_T)
        val listBegin = TokenSet.create(ABPTypes.LIST_BEGIN)
        val string = TokenSet.create(ABPTypes.STRING)
//        val COMMENTS = TokenSet.create(ABPTypes.COMMENT)
    }
}