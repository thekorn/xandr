package de.thekorn.xandr.listeners

import com.appnexus.opensdk.InitListener
import com.appnexus.opensdk.SDKSettings
import de.thekorn.xandr.models.FlutterState
import io.flutter.Log

class AdInitListener(private val flutterState: FlutterState) : InitListener {
    override fun onInitFinished(success: Boolean) {
        Log.d(
            "Xandr",
            "finished initializing, success=$success, sdkVersion=${SDKSettings.getSDKVersion()}"
        )
        this.flutterState.isInitialized.complete(success)
    }
}
