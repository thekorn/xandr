package de.thekorn.xandr.models

import com.appnexus.opensdk.AdSize
import io.flutter.Log

data class BannerViewOptions(
    val adSizes: ArrayList<AdSize>? = null,
    val customKeywords: HashMap<String, String>? = null,
    val allowNativeDemand: Boolean? = null,
    val layoutWidth: Int? = null,
    val layoutHeight: Int? = null,
    val shouldServePSAs: Boolean? = null,
    val loadsInBackground: Boolean? = null,
    val resizeAdToFitContainer: Boolean? = null,
    val loadWhenCreated: Boolean? = null,
    val placementID: String? = null,
    val memberId: String? = null,
    val inventoryCode: String? = null,
    val clickThroughAction: String? = null,
    val autoRefreshInterval: Int? = null,
    val resizeWhenLoaded: Boolean? = null
)

fun Map<*, *>.toBannerAdViewOptions(): BannerViewOptions {
    val adSizes = this["adSizes"] as ArrayList<*>?
    val sizes = ArrayList<AdSize>()
    adSizes?.forEach {
        val s = it as HashMap<*, *>?
        if (s?.containsKey("width") == true && s.containsKey("height")) {
            val w = it["width"] as Int?
            val h = it["height"] as Int?
            if (w != null && h != null) sizes.add(AdSize(w, h))
        }
    }
    Log.d(
        "Xandr.BannerView",
        "using '$adSizes' -> '$sizes'"
    )

    val customKeywords = HashMap<String, String>()
    val keywords = this["customKeywords"] as HashMap<*, *>?
    keywords?.forEach {
        customKeywords[it.key.toString()] = it.value.toString()
    }

    return BannerViewOptions(
        adSizes = sizes,
        customKeywords = customKeywords,
        // TODO: implement
        layoutHeight = this["layoutHeight"] as Int?,
        // TODO: implement
        layoutWidth = this["layoutWidth"] as Int?,
        // TODO: implement
        shouldServePSAs = this["shouldServePSAs"] as Boolean?,
        // TODO: implement
        loadsInBackground = this["loadsInBackground"] as Boolean?,
        // TODO: implement
        resizeAdToFitContainer = this["resizeAdToFitContainer"] as Boolean?,
        // TODO: implement
        loadWhenCreated = this["loadWhenCreated"] as Boolean?,
        placementID = this["placementID"] as String?,
        memberId = this["memberId"] as String?,
        inventoryCode = this["inventoryCode"] as String?,
        // TODO: implement
        clickThroughAction = this["clickThroughAction"] as String?,
        autoRefreshInterval = this["autoRefreshInterval"] as Int?,
        // TODO: implement
        resizeWhenLoaded = this["resizeWhenLoaded"] as Boolean?,
        allowNativeDemand = this["allowNativeDemand"] as Boolean?
    )
}
