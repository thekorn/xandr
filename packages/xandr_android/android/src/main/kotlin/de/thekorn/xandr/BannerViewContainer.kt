package de.thekorn.xandr

import android.app.Activity
import android.view.View
import com.appnexus.opensdk.ANClickThroughAction
import com.appnexus.opensdk.BannerAdView
import de.thekorn.xandr.listeners.XandrAdListener
import de.thekorn.xandr.models.BannerViewOptions
import de.thekorn.xandr.models.FlutterState
import io.flutter.Log
import io.flutter.plugin.platform.PlatformView
import kotlinx.coroutines.ExperimentalCoroutinesApi

class BannerViewContainer(
    activity: Activity,
    private var state: FlutterState,
    private var widgetId: Int,
    private val bannerViewOptions: BannerViewOptions?
) :
    PlatformView {
    private val banner: BannerAdView

    init {
        Log.d(
            "Xandr.BannerView",
            "Initializing $activity id=$widgetId " +
                "xandr-initialized=${state.isInitialized} bannerViewOptions=$bannerViewOptions"
        )

        this.banner = BannerAdView(activity)

        bannerViewOptions?.let {
            if (it.adSizes != null) {
                this.banner.adSizes = it.adSizes
            }

            if (it.autoRefreshInterval != null) {
                this.banner.autoRefreshInterval = it.autoRefreshInterval
            }

            it.customKeywords?.forEach {
                this.banner.addCustomKeywords(it.key, it.value)
            }

            if (it.allowNativeDemand != null) {
                this.banner.allowNativeDemand = it.allowNativeDemand
            }

            it.shouldServePSAs?.let { shouldServePSAs ->
                this.banner.shouldServePSAs = shouldServePSAs
            }

            it.clickThroughAction?.let { clickThroughAction ->
                when (clickThroughAction) {
                    "open_device_browser" -> {
                        this.banner.clickThroughAction = ANClickThroughAction.OPEN_DEVICE_BROWSER
                    }
                    "open_sdk_browser" -> {
                        this.banner.clickThroughAction = ANClickThroughAction.OPEN_SDK_BROWSER
                    }
                    "return_url" -> {
                        this.banner.clickThroughAction = ANClickThroughAction.RETURN_URL
                    }
                }
            }
            it.loadsInBackground?.let { loadsInBackground ->
                this.banner.loadsInBackground = loadsInBackground
            }
            it.resizeAdToFitContainer?.let { resizeAdToFitContainer ->
                this.banner.resizeAdToFitContainer = resizeAdToFitContainer
            }
        }

        state.isInitialized.invokeOnCompletion {
            // / need to make sure the sdk is initialized to access the memberId
            // / docs: Note that if both inventory code and placement ID are passed in, the
            //        inventory code will be passed to the server instead of the placement ID.
            bannerViewOptions?.let {
                if (it.inventoryCode != null) {
                    this.banner.setInventoryCodeAndMemberID(state.memberId, it.inventoryCode)
                } else {
                    this.banner.placementID = it.placementID
                }
                Log.d("Xandr.BannerView", "Initializing DONE")
            }
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
