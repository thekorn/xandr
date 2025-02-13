package de.thekorn.xandr.models

import com.appnexus.opensdk.AdSize
import io.flutter.Log

data class BannerViewOptions(
    val adSizes: ArrayList<AdSize>? = null,
    val customKeywords: HashMap<String, List<String>>? = null,
    val allowNativeDemand: Boolean? = null,
    val nativeAdRendererId: Int? = null,
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
    val resizeWhenLoaded: Boolean? = null,
    val enableLazyLoad: Boolean? = null,
    val multiAdRequestId: String? = null
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
        "Xandr.BannerViewOptions",
        "using '$adSizes' -> '$sizes'"
    )
    Log.d(
        "Xandr.BannerViewOptions",
        "using 'nativeAdRendererId' -> '${this["nativeAdRendererId"]}'"
    )

    val customKeywords = HashMap<String, List<String>>()
    val keywords = this["customKeywords"] as HashMap<*, *>?
    keywords?.forEach {
        customKeywords[it.key.toString()] = it.value as List<String>
    }

    return BannerViewOptions(
        adSizes = sizes,
        customKeywords = customKeywords,
        layoutHeight = this["layoutHeight"] as Int?,
        layoutWidth = this["layoutWidth"] as Int?,
        shouldServePSAs = this["shouldServePSAs"] as Boolean?,
        loadsInBackground = this["loadsInBackground"] as Boolean?,
        resizeAdToFitContainer = this["resizeAdToFitContainer"] as Boolean?,
        placementID = this["placementID"] as String?,
        memberId = this["memberId"] as String?,
        inventoryCode = this["inventoryCode"] as String?,
        clickThroughAction = this["clickThroughAction"] as String?,
        autoRefreshInterval = this["autoRefreshInterval"] as Int?,
        resizeWhenLoaded = this["resizeWhenLoaded"] as Boolean?,
        allowNativeDemand = this["allowNativeDemand"] as Boolean?,
        nativeAdRendererId = this["nativeAdRendererId"] as Int?,
        loadWhenCreated = this["loadWhenCreated"] as Boolean?,
        enableLazyLoad = this["enableLazyLoad"] as Boolean?,
        multiAdRequestId = this["multiAdRequestId"] as String?
    )
}
