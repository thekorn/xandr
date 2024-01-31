package de.thekorn.xandr

import XandrFlutterApi
import android.app.Activity
import android.view.View
import com.appnexus.opensdk.AdListener
import com.appnexus.opensdk.AdSize
import com.appnexus.opensdk.AdView
import com.appnexus.opensdk.BannerAdView
import com.appnexus.opensdk.NativeAdResponse
import com.appnexus.opensdk.ResultCode
import io.flutter.Log
import io.flutter.plugin.platform.PlatformView
import kotlinx.coroutines.ExperimentalCoroutinesApi

class BannerViewContainer(
    activity: Activity,
    private var state: FlutterState,
    private var widgetId: Int,
    args: Any?
) :
    PlatformView {
    private val banner: BannerAdView

    init {
        Log.d(
            "Xandr.BannerView",
            "Initializing $activity id=$widgetId " +
                "xandr-initialized=${state.isInitialized} args=$args"
        )

        val params = args as HashMap<*, *>
        val placementID = params["placementID"] as String?
        val inventoryCode = params["inventoryCode"] as String?
        val autoRefreshInterval = params["autoRefreshInterval"] as Int
        val adSizes = params["adSizes"] as ArrayList<HashMap<String, Int>>
        val customKeywords = params["customKeywords"] as HashMap<String, String>
        val allowNativeDemand = params["allowNativeDemand"] as Boolean

        Log.d(
            "Xandr.BannerView",
            "using placementID='$placementID', inventoryCode='$inventoryCode', " +
                "adSizes='$adSizes', allowNativeDemand=$allowNativeDemand"
        )

        this.banner = BannerAdView(activity)

        val sizes = ArrayList<AdSize>()
        adSizes.forEach {
            val w = it["width"] as Int
            val h = it["height"] as Int
            sizes.add(AdSize(w, h))
        }
        Log.d(
            "Xandr.BannerView",
            "using '$adSizes' -> '$sizes'"
        )

        this.banner.adSizes = sizes
        this.banner.autoRefreshInterval = autoRefreshInterval

        customKeywords.forEach {
            this.banner.addCustomKeywords(it.key, it.value)
        }

        this.banner.allowNativeDemand = allowNativeDemand

        state.isInitialized.invokeOnCompletion {
            // / need to make sure the sdk is initialized to access the memberId
            // / docs: Note that if both inventory code and placement ID are passed in, the
            //        inventory code will be passed to the server instead of the placement ID.
            if (inventoryCode != null) {
                this.banner.setInventoryCodeAndMemberID(state.memberId, inventoryCode)
            } else {
                this.banner.placementID = placementID
            }
            Log.d("Xandr.BannerView", "Initializing DONE")
        }
    }

    @OptIn(ExperimentalCoroutinesApi::class)
    override fun getView(): View {
        Log.d(
            "Xandr.BannerView",
            "Return view, xandr-initialized=${state.isInitialized.isCompleted}"
        )

        this.banner.adListener = XandrAdListener(widgetId, this.state.flutterApi)

        state.isInitialized.invokeOnCompletion {
            Log.d(
                "Xandr.BannerView",
                "load add, xandr-initialized=${state.isInitialized.getCompleted()}"
            )
            this.banner.loadAd()
        }
        return this.banner
    }

    override fun dispose() {
        this.banner.destroy()
    }
}

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

        if (view != null) {
            val adResponse = view.adResponseInfo
            flutterApi.onAdLoaded(
                widgetId.toLong(),
                view.creativeWidth.toLong(), view.creativeHeight.toLong(), adResponse.creativeId,
                adResponse.adType.toString(), adResponse.tagId, adResponse.auctionId,
                adResponse.cpm, adResponse.buyMemberId.toLong()
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
}
