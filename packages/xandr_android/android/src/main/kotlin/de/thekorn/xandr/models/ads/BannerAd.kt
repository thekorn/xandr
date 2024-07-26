package de.thekorn.xandr.models.ads

import android.annotation.SuppressLint
import android.app.Activity
import androidx.core.content.ContextCompat
import com.appnexus.opensdk.ANClickThroughAction
import com.appnexus.opensdk.BannerAdView
import de.thekorn.xandr.listeners.XandrBannerAdListener
import de.thekorn.xandr.models.BannerViewOptions
import de.thekorn.xandr.models.FlutterState
import de.thekorn.xandr.models.MultiAdRequestRegistry
import io.flutter.Log

@SuppressLint("ViewConstructor")
class BannerAd(
    private var activity: Activity,
    private var state: FlutterState,
    private var widgetId: Int
) : BannerAdView(activity) {

    fun configure(bannerViewOptions: BannerViewOptions) {
        bannerViewOptions.let {
            it.adSizes?.let { adSizes ->
                this.adSizes = adSizes
            }

            it.autoRefreshInterval?.let { autoRefreshInterval ->
                this.autoRefreshInterval = autoRefreshInterval
            }

            it.customKeywords?.forEach { kw ->
                kw.value.forEach { value ->
                    this.addCustomKeywords(kw.key, value)
                }
            }

            it.allowNativeDemand?.let { allowNativeDemand ->
                this.allowNativeDemand = allowNativeDemand
            }

            it.shouldServePSAs?.let { shouldServePSAs ->
                this.shouldServePSAs = shouldServePSAs
            }

            it.clickThroughAction?.let { clickThroughAction ->
                when (clickThroughAction) {
                    "open_device_browser" -> {
                        this.clickThroughAction = ANClickThroughAction.OPEN_DEVICE_BROWSER
                    }
                    "open_sdk_browser" -> {
                        this.clickThroughAction = ANClickThroughAction.OPEN_SDK_BROWSER
                    }
                    "return_url" -> {
                        this.clickThroughAction = ANClickThroughAction.RETURN_URL
                    }
                }
            }
            it.loadsInBackground?.let { loadsInBackground ->
                this.loadsInBackground = loadsInBackground
            }
            it.resizeAdToFitContainer?.let { resizeAdToFitContainer ->
                this.resizeAdToFitContainer = resizeAdToFitContainer
            }
            it.enableLazyLoad?.let { enableLazyLoad ->
                if (enableLazyLoad) {
                    this.enableLazyLoad()
                }
            }
            it.multiAdRequestId?.let { multiAdRequestId ->
                MultiAdRequestRegistry.addAdUnit(multiAdRequestId, this)
            }
        }

        if (state.publisherId != null) {
            this.publisherId = state.publisherId!!
        }

        state.isInitialized.invokeOnCompletion {
            // / need to make sure the sdk is initialized to access the memberId
            // / docs: Note that if both inventory code and placement ID are passed in, the
            //        inventory code will be passed to the server instead of the placement ID.
            bannerViewOptions.let {
                if (it.inventoryCode != null) {
                    this.setInventoryCodeAndMemberID(state.memberId, it.inventoryCode)
                } else {
                    this.placementID = it.placementID
                }
                Log.d("Xandr.BannerView", "Initializing DONE")
            }
        }
    }

    override fun loadAd(): Boolean {
        if (adListener != null) {
            Log.d("Xandr.BannerView", "loadAd; id=$widgetId / stopped because ad already loaded")
            return false
        } else {
            Log.d("Xandr.BannerView", "loadAd; id=$widgetId")
            this.adListener = null

            this.adListener = XandrBannerAdListener(
                widgetId.toLong(),
                state.flutterApi,
                this
            )
            this.setBackgroundColor(
                ContextCompat.getColor(activity, android.R.color.transparent)
            )
            return super.loadAd()
        }
        
    }
}
