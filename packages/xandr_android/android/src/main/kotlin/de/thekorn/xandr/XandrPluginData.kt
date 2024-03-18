package de.thekorn.xandr

import HostAPIUserId
import HostAPIUserIdSource
import com.appnexus.opensdk.ANUserId

fun HostAPIUserIdSource.toANUserIdSource() = when (this) {
    HostAPIUserIdSource.CRITEO -> ANUserId.Source.CRITEO
    HostAPIUserIdSource.THE_TRADE_DESK -> ANUserId.Source.THE_TRADE_DESK
    HostAPIUserIdSource.NET_ID -> ANUserId.Source.NETID
    HostAPIUserIdSource.LIVERAMP -> ANUserId.Source.LIVERAMP
    HostAPIUserIdSource.UID2 -> ANUserId.Source.UID2
}

fun toHostAPIUserIdSource(source: String): HostAPIUserIdSource {
    return when (source) {
        ANUserId.EXTENDEDID_SOURCE_CRITEO -> HostAPIUserIdSource.CRITEO
        ANUserId.EXTENDEDID_SOURCE_THETRADEDESK -> HostAPIUserIdSource.THE_TRADE_DESK
        ANUserId.EXTENDEDID_SOURCE_NETID -> HostAPIUserIdSource.NET_ID
        ANUserId.EXTENDEDID_SOURCE_LIVERAMP -> HostAPIUserIdSource.LIVERAMP
        ANUserId.EXTENDEDID_SOURCE_UID2 -> HostAPIUserIdSource.UID2
        else -> throw UnsupportedOperationException()
    }
}

fun ANUserId.toHostUserId() = HostAPIUserId(source = toHostAPIUserIdSource(source), userId = userId)
