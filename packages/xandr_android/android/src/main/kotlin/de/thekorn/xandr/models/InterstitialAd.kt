package de.thekorn.xandr.models

import android.content.Context
import com.appnexus.opensdk.InterstitialAdView
import kotlinx.coroutines.CompletableDeferred

class InterstitialAd(context: Context?) : InterstitialAdView(context) {
    val isLoaded: CompletableDeferred<Boolean> = CompletableDeferred()
    val isClosed: CompletableDeferred<Boolean> = CompletableDeferred()
}
