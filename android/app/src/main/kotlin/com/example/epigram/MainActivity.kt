package com.example.epigram

import android.os.Build
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.rsocket.Payload
import io.rsocket.RSocket
import io.rsocket.core.RSocketClient
import io.rsocket.core.RSocketConnector
import io.rsocket.metadata.WellKnownMimeType.*
import io.rsocket.transport.netty.client.WebsocketClientTransport
import io.rsocket.util.DefaultPayload
import reactor.core.publisher.Mono
import java.lang.ref.WeakReference
import io.netty.buffer.ByteBufAllocator
import io.rsocket.metadata.*


class MainActivity: FlutterActivity() {
    private var rsocketMessageEventSinkRef: WeakReference<EventChannel.EventSink?>? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        var metadata = ByteBufAllocator.DEFAULT.compositeBuffer()
        var routingMetadata = TaggingMetadataCodec.createRoutingMetadata(ByteBufAllocator.DEFAULT, listOf("/message-stream"))
        var authMetadata = AuthMetadataCodec.encodeSimpleMetadata(
            ByteBufAllocator.DEFAULT,
            "user".toCharArray(),
            "pass".toCharArray()
        )
        CompositeMetadataCodec.encodeAndAddMetadata(metadata,
            ByteBufAllocator.DEFAULT,
            MESSAGE_RSOCKET_ROUTING,
            routingMetadata.content
        )
        CompositeMetadataCodec.encodeAndAddMetadata(metadata,
            ByteBufAllocator.DEFAULT,
            MESSAGE_RSOCKET_AUTHENTICATION,
            authMetadata
        )
        var data = ByteBufAllocator.DEFAULT.buffer().writeBytes("{ \"userId\": \"123\", \"message\":\"Hello World\", \"index\":\"0\" }".toByteArray())
        data.alloc().directBuffer()

        val source = RSocketConnector
            .create()
            .dataMimeType(APPLICATION_JSON.string)
            .metadataMimeType(MESSAGE_RSOCKET_COMPOSITE_METADATA.string)
            .setupPayload(DefaultPayload.create(data, metadata))
            .connect(WebsocketClientTransport.create("192.168.56.8", 7000))

        metadata = ByteBufAllocator.DEFAULT.compositeBuffer()
        routingMetadata = TaggingMetadataCodec.createRoutingMetadata(ByteBufAllocator.DEFAULT, listOf("/message-stream"))
        authMetadata = AuthMetadataCodec.encodeSimpleMetadata(
            ByteBufAllocator.DEFAULT,
            "user".toCharArray(),
            "pass".toCharArray()
        )
        CompositeMetadataCodec.encodeAndAddMetadata(metadata,
            ByteBufAllocator.DEFAULT,
            MESSAGE_RSOCKET_ROUTING,
            routingMetadata.content
        )
        CompositeMetadataCodec.encodeAndAddMetadata(metadata,
            ByteBufAllocator.DEFAULT,
            MESSAGE_RSOCKET_AUTHENTICATION,
            authMetadata
        )
        data = ByteBufAllocator.DEFAULT.buffer().writeBytes("{ \"userId\": \"123\", \"message\":\"Hello World\", \"index\":\"0\" }".toByteArray())
        data.alloc().directBuffer()

        val client = RSocketClient.from(source)
        val sub = client.requestStream(Mono.just(DefaultPayload.create(data, metadata)))
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.N) {
            sub.doOnSubscribe {
                it.request(Long.MAX_VALUE); println("Subscribed to RSOCKET!")
            }
            sub.doOnError {
                println(it.message)
            }
            sub.doOnCancel {
                println("Canceled subscription")
            }
            sub.doOnNext {
                println(it.toString())
            }
            sub.subscribe {
                println(it.toString())
            }
        }
        EventChannel(flutterEngine.dartExecutor.binaryMessenger, EVENT_CHANNEL_RSOCKET_MESSAGE_STREAM).setStreamHandler(
            object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, eventSink: EventChannel.EventSink?) {
                    rsocketMessageEventSinkRef = WeakReference(eventSink)
                    println("FLUTTER IS LISTENING");
                    eventSink?.success(
                        "{ " +
                                "\"id\": \"foobar\"," +
                                "\"userId\": \"userId\"," +
                                "\"username\": \"BOB\"," +
                                "\"message\": \"message\"," +
                                "\"timestamp\": \"timestamp\"" +
                            "}"
                    );
                    eventSink?.success(
                        "{ " +
                                "\"id\": \"foobar\"," +
                                "\"userId\": \"userId\"," +
                                "\"username\": \"ALICE\"," +
                                "\"message\": \"message\"," +
                                "\"timestamp\": \"timestamp\"" +
                                "}"
                    );
                    eventSink?.success(
                        "{ " +
                                "\"id\": \"foobar\"," +
                                "\"userId\": \"userId\"," +
                                "\"username\": \"MAGENTA\"," +
                                "\"message\": \"message\"," +
                                "\"timestamp\": \"timestamp\"" +
                                "}"
                    );
                    eventSink?.success(
                        "{ " +
                                "\"id\": \"foobar\"," +
                                "\"userId\": \"userId\"," +
                                "\"username\": \"COBRA\"," +
                                "\"message\": \"message\"," +
                                "\"timestamp\": \"timestamp\"" +
                                "}"
                    );
                }

                override fun onCancel(arguments: Any?) {
                    rsocketMessageEventSinkRef?.clear()
                    println("FLUTTER HAS CANCELLED LISTENING");
                }
            }
        )
    }

    override fun onDestroy() {
        rsocketMessageEventSinkRef?.clear();
        super.onDestroy()
    }

    companion object {
        private const val EVENT_CHANNEL_RSOCKET_MESSAGE_STREAM = "tech.jgross.epigram/rsocket"
    }
}
