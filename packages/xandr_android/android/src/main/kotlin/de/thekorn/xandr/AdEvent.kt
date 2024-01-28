package de.thekorn.xandr

open class AdEvent (
    open val type: String
){}

data class BannerAdErrorEvent(
    val msg: String
): AdEvent("Error")

data class BannerAdEvent(
    val width: Int,
    val height: Int,

    val creativeId: String,
    val adType: String,
    val tagId: String,
    val auctionId: String,
    val cpm: Double,
    val memberId: Int

): AdEvent("BannerAd")

data class NativeBannerAdEvent(
    val title: String,
    val description: String,
    val imageUrl: String
): AdEvent("NativeBannerAd")