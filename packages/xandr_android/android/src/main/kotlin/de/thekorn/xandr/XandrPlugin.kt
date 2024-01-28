package de.thekorn.xandr

import XandrHostApi
import android.content.Context
import com.appnexus.opensdk.InitListener
import com.appnexus.opensdk.SDKSettings
import com.appnexus.opensdk.XandrAd

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.BinaryMessenger
import kotlinx.coroutines.CompletableDeferred
import kotlin.properties.Delegates
import io.flutter.Log
import kotlinx.coroutines.ExperimentalCoroutinesApi

class FlutterState(
    var applicationContext: Context,
    private var binaryMessenger: BinaryMessenger,
) {
    val isInitialized: CompletableDeferred<Boolean> = CompletableDeferred()

    var memberId by Delegates.notNull<Int>()

    fun startListening(methodCallHandler: XandrPlugin) {
        XandrHostApi.setUp(this.binaryMessenger, methodCallHandler)
    }

    fun stopListening() {
        XandrHostApi.setUp(this.binaryMessenger, null)
    }
}

class XandrPlugin : FlutterPlugin, ActivityAware, XandrHostApi {
    private lateinit var flutterPluginBinding: FlutterPlugin.FlutterPluginBinding

    private lateinit var flutterState: FlutterState

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        this.flutterState = FlutterState(binding.applicationContext, binding.binaryMessenger)
        this.flutterState.startListening(this)
        this.flutterPluginBinding = binding
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        this.flutterState.stopListening()
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        TODO("Not yet implemented")
        //this.flutterPluginBinding.platformViewRegistry.registerViewFactory(
        //    "platform-xandr/banner",
        //    BannerViewFactory(
        //        binding.activity,
        //        flutterPluginBinding.binaryMessenger,
        //        this.flutterState
        //    )
        //)
    }

    override fun onDetachedFromActivityForConfigChanges() {
        Log.d(
            "Xandr",
            "--> onDetachedFromActivityForConfigChanges"
        )
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        Log.d(
            "Xandr",
            "--> onReattachedToActivityForConfigChanges"
        )
        onDetachedFromActivity()
    }

    override fun onDetachedFromActivity() {
        Log.d(
            "Xandr",
            "--> onDetachedFromActivity"
        )
        onDetachedFromActivity()
    }

    @OptIn(ExperimentalCoroutinesApi::class)
    override fun init(memberId: Long, callback: (kotlin.Result<Boolean>) -> Unit) {
        this.flutterState.memberId = memberId.toInt()
        XandrAd.init(
            memberId.toInt(),
            this.flutterState.applicationContext,
            true,
            true,
            AdInitListener(this.flutterState)
        )
        this.flutterState.isInitialized.invokeOnCompletion {
            callback(Result.success(this.flutterState.isInitialized.getCompleted()))
        }
    }
}

class AdInitListener(private val flutterState: FlutterState) : InitListener {
    override fun onInitFinished(success: Boolean) {
        Log.d(
            "Xandr",
            "finished initializing, success=$success, sdkVersion=${SDKSettings.getSDKVersion()}"
        )
        this.flutterState.isInitialized.complete(success)
    }

}