package de.thekorn.xandr.models

import XandrFlutterApi
import XandrHostApi
import android.content.Context
import de.thekorn.xandr.XandrPlugin
import io.flutter.plugin.common.BinaryMessenger
import kotlin.properties.Delegates
import kotlinx.coroutines.CompletableDeferred

class FlutterState(
    var applicationContext: Context,
    private var binaryMessenger: BinaryMessenger
) {
    val isInitialized: CompletableDeferred<Boolean> = CompletableDeferred()

    var memberId by Delegates.notNull<Int>()
    lateinit var flutterApi: XandrFlutterApi

    fun startListening(methodCallHandler: XandrPlugin) {
        XandrHostApi.setUp(this.binaryMessenger, methodCallHandler)
        this.flutterApi = XandrFlutterApi(this.binaryMessenger)
    }

    fun stopListening() {
        XandrHostApi.setUp(this.binaryMessenger, null)
    }
}
