package de.thekorn.xandr

import XandrHostApi
import android.content.Context
import io.flutter.plugin.common.BinaryMessenger
import kotlinx.coroutines.CompletableDeferred
import kotlin.properties.Delegates

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