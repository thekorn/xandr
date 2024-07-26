package de.thekorn.xandr

import android.app.Activity
import android.view.View
import de.thekorn.xandr.models.BannerViewOptions
import de.thekorn.xandr.models.FlutterState
import de.thekorn.xandr.models.ads.BannerAd
import android.util.Log
import io.flutter.plugin.platform.PlatformView
import kotlinx.coroutines.ExperimentalCoroutinesApi

class BannerViewContainer(
    activity: Activity,
    private var state: FlutterState,
    widgetId: Int,
    private val bannerViewOptions: BannerViewOptions?
) : PlatformView {
    private val banner: BannerAd

    init {
        Log.d(
            "Xandr.BannerView",
            "Initializing $activity id=$widgetId " +
                "xandr-initialized=${state.isInitialized} bannerViewOptions=$bannerViewOptions"
        )

        this.banner = BannerAd(activity, state, widgetId)

        if (bannerViewOptions != null) {
            this.banner.configure(bannerViewOptions)
        }
    }

    @OptIn(ExperimentalCoroutinesApi::class)
    override fun getView(): View {
        Log.d(
            "Xandr.BannerView",
            "Return view, xandr-initialized=${state.isInitialized.isCompleted}"
        )

        if (bannerViewOptions?.multiAdRequestId == null) {
            state.isInitialized.invokeOnCompletion {
                Log.d(
                    "Xandr.BannerView",
                    "load add, xandr-initialized=${state.isInitialized.getCompleted()}"
                )
                bannerViewOptions?.loadWhenCreated?.let { loadWhenCreated ->
                    if (loadWhenCreated) {
                        loadAd()
                    }
                }
            }
        } else {
            Log.d(
                "Xandr.BannerView",
                "banner is not loaded because its part of a multi ad request"
            )
        }
        return this.banner
    }

    fun loadAd() {
        this.banner.loadAd()
    }

    override fun dispose() {
        this.banner.destroy()
    }
}
