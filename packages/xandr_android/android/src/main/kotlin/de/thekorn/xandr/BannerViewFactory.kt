package de.thekorn.xandr

import android.app.Activity
import android.content.Context
import io.flutter.plugin.common.BinaryMessenger
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class BannerViewFactory(
    private val activity: Activity,
    private val messenger: BinaryMessenger,
    private val state: FlutterState
) :
    PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    override fun create(
        context: Context,
        id: Int,
        args: Any?
    ): PlatformView {
        return BannerViewContainer(
            activity,
            messenger,
            this.state,
            id,
            args
        )
    }
}