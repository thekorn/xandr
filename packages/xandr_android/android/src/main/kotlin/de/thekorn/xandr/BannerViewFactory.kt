package de.thekorn.xandr

import android.app.Activity
import android.content.Context
import de.thekorn.xandr.models.FlutterState
import de.thekorn.xandr.models.toBannerAdViewOptions
import io.flutter.Log
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class BannerViewFactory(
    private val activity: Activity,
    private val state: FlutterState
) :
    PlatformViewFactory(StandardMessageCodec.INSTANCE) {

    override fun create(context: Context, id: Int, args: Any?): PlatformView {
        return state.getOrCreateBannerView(activity, id, args);
    }
}
