package de.thekorn.xandr.listeners

import XandrFlutterApi
import com.appnexus.opensdk.AdListener
import com.appnexus.opensdk.AdView
import com.appnexus.opensdk.NativeAdResponse
import com.appnexus.opensdk.ResultCode
import de.thekorn.xandr.models.ads.BannerAd
import de.thekorn.xandr.models.ads.InterstitialAd
import io.flutter.Log

// / FIXME: create explicit XandrBannerAdListener
// /  means: XandrAdListener as base plus an interstitial and banner implementation

open class XandrAdListener(
    private var widgetId: Int,
    private var flutterApi: XandrFlutterApi
) : AdListener {
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

    override fun onAdLoaded(adResonse: NativeAdResponse?) {
        Log.d(
            "Xandr.BannerView",
            ">>> Ad Loaded, NativeAdResponse=$adResonse, title=${adResonse?.title} " +
                "for $widgetId"
        )
        if (adResonse != null) {
            flutterApi.onNativeAdLoaded(
                widgetId.toLong(),
                adResonse.title,
                adResonse.description,
                adResonse.imageUrl
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
