package de.thekorn.xandr.listeners

import XandrFlutterApi
import com.appnexus.opensdk.AdListener
import com.appnexus.opensdk.AdView
import com.appnexus.opensdk.NativeAdResponse
import com.appnexus.opensdk.ResultCode
import com.appnexus.opensdk.utils.JsonUtil
import de.thekorn.xandr.models.ads.BannerAd
import de.thekorn.xandr.models.ads.InterstitialAd
import io.flutter.Log
import org.json.JSONObject

// / FIXME: create explicit XandrBannerAdListener
// /  means: XandrAdListener as base plus an interstitial and banner implementation

open class XandrAdListener(private var widgetId: Int, private var flutterApi: XandrFlutterApi) :
    AdListener {
    override fun onAdLoaded(view: AdView?) {
        Log.d(
            "Xandr.BannerView",
            ">>> Ad Loaded, id=${view?.id} widgetId=$widgetId, w=${view?.creativeWidth}," +
                " h=${view?.creativeHeight}"
        )

        // FIXME: implement resizeWhenLoaded

        if (view != null) {
            val adResponse = view.adResponseInfo
            flutterApi.onAdLoaded(
                widgetId.toLong(),
                view.creativeWidth.toLong(), view.creativeHeight.toLong(),
                adResponse.creativeId, adResponse.adType.toString(), adResponse.tagId,
                adResponse.auctionId, adResponse.cpm, adResponse.buyMemberId.toLong()
            ) { }
        } else {
            flutterApi.onAdLoadedError(
                widgetId.toLong(),
                "Unknown error while loading banner ad"
            ) { }
        }
    }

    override fun onAdLoaded(adResponse: NativeAdResponse?) {
        Log.d(
            "Xandr.BannerView",
            ">>> Ad Loaded, NativeAdResponse=$adResponse, title=${adResponse?.title} " +
                "for $widgetId"
        )
        var clickUrl: String? = null
        var customElements: String = ""
        if ((adResponse?.networkIdentifier == NativeAdResponse.Network.APPNEXUS) &&
            (adResponse?.nativeElements?.get(NativeAdResponse.NATIVE_ELEMENT_OBJECT)) is JSONObject
        ) {
            val nativeResponseJSON = (
                adResponse.nativeElements
                [NativeAdResponse.NATIVE_ELEMENT_OBJECT]
                )
                as JSONObject
            clickUrl = JsonUtil.getJSONObject(nativeResponseJSON, "link").getString("url")
            if (clickUrl.isEmpty()) {
                clickUrl =
                    JsonUtil.getJSONObject(nativeResponseJSON, "link").getString("fallback_url")
            }
            customElements = nativeResponseJSON.toString()
            Log.d(
                "Xandr.BannerView",
                ">>> Ad Loaded, NativeAdResponse customElements=$customElements"
            )

        }

        if (adResponse != null && clickUrl != null) {
            flutterApi.onNativeAdLoaded(
                widgetId.toLong(),
                adResponse.title,
                adResponse.description,
                adResponse.imageUrl,
                clickUrl,
                customElements
            ) { }
        } else {
            flutterApi.onNativeAdLoadedError(
                widgetId.toLong(),
                "Unknown error while loading native banner ad"
            ) { }
        }
    }

    override fun onAdRequestFailed(p0: AdView?, p1: ResultCode?) {
        Log.d(
            "Xandr.BannerView",
            ">>> Ad Request failed, AdView:p0=$p0 ResultCode:p1=$p1"
        )

        flutterApi.onAdLoadedError(
            widgetId.toLong(),
            "Error while loading banner ad: ${p1?.message}"
        ) { }
    }

    override fun onAdExpanded(p0: AdView?) {
        Log.d(
            "Xandr.BannerView",
            ">>> Ad expanded, AdView:p0=$p0"
        )
    }

    override fun onAdCollapsed(p0: AdView?) {
        Log.d(
            "Xandr.BannerView",
            ">>> Ad collapsed, AdView:p0=$p0"
        )
    }

    override fun onAdClicked(p0: AdView?) {
        Log.d(
            "Xandr.BannerView",
            ">>> Ad clicked, AdView:p0=$p0"
        )
    }

    override fun onAdClicked(p0: AdView?, p1: String?) {
        Log.d(
            "Xandr.BannerView",
            ">>> Ad clicked, AdView:p0=$p0 String:p1=$p1"
        )
        p1?.let {
            flutterApi.onAdClicked(
                widgetId.toLong(),
                it
            ) { }
        }
    }

    override fun onLazyAdLoaded(adView: AdView?) {
        Log.d(
            "Xandr.BannerView",
            ">>> Ad lazy loaded, AdView:p0=$adView"
        )
    }

    override fun onAdImpression(p0: AdView?) {
        Log.d(
            "Xandr.BannerView",
            ">>> Ad impressions, AdView:p0=$p0"
        )
    }
}

class XandrInterstitialAdListener(
    widgetId: Long,
    flutterApi: XandrFlutterApi,
    private var interstitialAd: InterstitialAd
) : XandrAdListener(widgetId.toInt(), flutterApi) {
    override fun onAdLoaded(view: AdView?) {
        super.onAdLoaded(view)
        interstitialAd.isLoaded.complete(true)
        Log.d("Xandr.InterstitialView", "onAdLoaded")
    }

    override fun onAdCollapsed(p0: AdView?) {
        super.onAdCollapsed(p0)
        interstitialAd.isClosed.complete(true)
        Log.d("Xandr.InterstitialView", "onAdCollapsed")
    }
}

class XandrBannerAdListener(
    widgetId: Long,
    flutterApi: XandrFlutterApi,
    private var banner: BannerAd
) : XandrAdListener(widgetId.toInt(), flutterApi) {

    override fun onLazyAdLoaded(adView: AdView?) {
        Log.d(
            "Xandr.BannerView",
            ">>> Ad lazy loaded, AdView:p0=$adView"
        )
        this.banner.loadLazyAd()
        return super.onLazyAdLoaded(adView)
    }
}
