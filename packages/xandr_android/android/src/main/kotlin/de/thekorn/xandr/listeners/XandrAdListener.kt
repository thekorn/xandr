package de.thekorn.xandr.listeners

import XandrFlutterApi
import android.view.View
import android.view.ViewGroup
import android.webkit.WebView
import android.widget.FrameLayout
import com.appnexus.opensdk.ANAdResponseInfo
import com.appnexus.opensdk.AdListener
import com.appnexus.opensdk.AdView
import com.appnexus.opensdk.NativeAdResponse
import com.appnexus.opensdk.ResultCode
import de.thekorn.xandr.models.BannerViewOptions
import de.thekorn.xandr.models.InterstitialAd
import io.flutter.Log

// / FIXME: create explicit XandrBannerAdListener
// /  means: XandrAdListener as base plus an interstitial and banner implementation

open class XandrAdListener(
    private var widgetId: Int,
    private var flutterApi: XandrFlutterApi,
    private val bannerViewOptions: BannerViewOptions?
) : AdListener {
    override fun onAdLoaded(view: AdView?) {
        Log.d(
            "Xandr.BannerView",
            ">>> Ad Loaded, id=${view?.id} widgetId=$widgetId, w=${view?.creativeWidth}," +
                " h=${view?.creativeHeight}"
        )

        if (bannerViewOptions?.resizeWhenLoaded != null && bannerViewOptions.resizeWhenLoaded) {
            if (view != null) {
                view.resize(view.adResponseInfo)
            } else {
                flutterApi.onAdLoadedError(
                    widgetId.toLong(),
                    "Unknown error while loading and resizing banner ad"
                ) { }
            }
        } else {
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

    override fun onLazyAdLoaded(p0: AdView?) {
        Log.d(
            "Xandr.BannerView",
            ">>> Ad lazy loaded, AdView:p0=$p0"
        )
    }

    override fun onAdImpression(p0: AdView?) {
        Log.d(
            "Xandr.BannerView",
            ">>> Ad impressions, AdView:p0=$p0"
        )
    }

    private fun AdView.resize(adResponse: ANAdResponseInfo) {
        this.addOnLayoutChangeListener(object : View.OnLayoutChangeListener {
            override fun onLayoutChange(
                view: View?,
                left: Int,
                top: Int,
                right: Int,
                bottom: Int,
                oldLeft: Int,
                oldTop: Int,
                oldRight: Int,
                oldBottom: Int
            ) {
                (this@resize as ViewGroup).getChildAt(0)?.let { adWebView ->
                    val h = (bannerViewOptions?.layoutHeight ?: 0)
                    val screenHeight = (h * resources.displayMetrics.density).toInt()
                    if (screenHeight != 0 && screenHeight != adWebView.height && oldBottom != 0) {
                        // post avoid "requestLayout() improperly called by com.appnexus.opensdk.AdWebView"
                        adWebView.post {
                            adWebView.layoutParams = FrameLayout.LayoutParams(
                                FrameLayout.LayoutParams.MATCH_PARENT,
                                screenHeight
                            )
                            (adWebView as WebView).settings.useWideViewPort = true
                            adWebView.invalidate()
                            flutterApi.onAdLoaded(
                                widgetId.toLong(),
                                adWebView.width.toLong(), adWebView.height.toLong(),
                                adResponse.creativeId, adResponse.adType.toString(),
                                adResponse.tagId, adResponse.auctionId,
                                adResponse.cpm, adResponse.buyMemberId.toLong()
                            ) { }
                        }
                        removeOnLayoutChangeListener(this)
                    }
                }
            }
        })
    }
}

class XandrInterstitialAdListener(
    widgetId: Long,
    flutterApi: XandrFlutterApi,
    private var interstitialAd: InterstitialAd
) : XandrAdListener(widgetId.toInt(), flutterApi, null) {
    override fun onAdLoaded(view: AdView?) {
        super.onAdLoaded(view)
        interstitialAd.isLoaded.complete(true)
        Log.d("Xandr.Interstitial", "onAdLoaded")
    }

    override fun onAdCollapsed(p0: AdView?) {
        super.onAdCollapsed(p0)
        interstitialAd.isClosed.complete(true)
        Log.d("Xandr.Interstitial", "onAdCollapsed")
    }
}
