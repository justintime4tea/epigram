package com.example.epigram

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import java.lang.ref.WeakReference

class MainActivity: FlutterActivity() {
    private var rsocketMessageEventSinkRef: WeakReference<EventChannel.EventSink?>? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
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
