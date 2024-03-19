package de.thekorn.xandr.models

import com.appnexus.opensdk.ANMultiAdRequest
import com.appnexus.opensdk.Ad

val charPool: List<Char> = ('a'..'z') + ('A'..'Z') + ('0'..'9')

object MultiAdRequestRegistry {
    private val multiAdRequests = mutableMapOf<String, ANMultiAdRequest>()
    private fun generateRandomStringId() = List(16) { charPool.random() }.joinToString("")

    fun initNewRequest(mar: ANMultiAdRequest): String {
        val id = generateRandomStringId()
        multiAdRequests[id] = mar
        return id
    }

    fun removeRequestWithId(requestId: String): Boolean {
        val mar = multiAdRequests.remove(requestId)
        mar?.stop()
        return mar != null
    }

    fun load(requestId: String): Boolean {
        val mar = multiAdRequests[requestId] ?: return false
        return mar.load()
    }

    fun addAdUnit(requestId: String, ad: Ad): Boolean {
        val mar = multiAdRequests[requestId] ?: return false
        return mar.addAdUnit(ad)
    }
}
