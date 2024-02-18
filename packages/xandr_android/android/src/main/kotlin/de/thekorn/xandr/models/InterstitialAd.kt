package de.thekorn.xandr.models

import com.appnexus.opensdk.InterstitialAdView
import kotlinx.coroutines.CompletableDeferred

class InterstitialAd(
    var interstitial: InterstitialAdView
) {
    val isLoaded: CompletableDeferred<Boolean> = CompletableDeferred()
    val isClosed: CompletableDeferred<Boolean> = CompletableDeferred()
}
