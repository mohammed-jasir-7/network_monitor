package com.jasir.dev.network_monitor;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.net.ConnectivityManager;
import android.net.Network;
import android.net.NetworkCapabilities;
import android.net.NetworkInfo;
import android.net.NetworkRequest;
import android.os.Build;
import android.os.Handler;
import android.os.Looper;
import android.provider.Settings;

import androidx.annotation.NonNull;

import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

import io.flutter.plugin.common.EventChannel;

public class NetworkMonitor extends  BroadcastReceiver  implements EventChannel.StreamHandler{
final ConnectivityManager connectivityManager;
private EventChannel.EventSink eventSink;
private NetworkRequest networkRequest;
    private Handler uiThreadHandler = new Handler(Looper.getMainLooper());
private Context context;
public NetworkMonitor(Context context ){this.connectivityManager= (ConnectivityManager) context.getSystemService(context.CONNECTIVITY_SERVICE);
this.context=context;}
public   boolean  isOnline(){

     if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
         Network nw = connectivityManager.getActiveNetwork();
         if (nw == null) return false;
         NetworkCapabilities actNw = connectivityManager.getNetworkCapabilities(nw);
         return actNw != null && (actNw.hasTransport(NetworkCapabilities.TRANSPORT_WIFI) || actNw.hasTransport(NetworkCapabilities.TRANSPORT_CELLULAR) || actNw.hasTransport(NetworkCapabilities.TRANSPORT_ETHERNET) || actNw.hasTransport(NetworkCapabilities.TRANSPORT_BLUETOOTH));
     } else {
         NetworkInfo nwInfo = connectivityManager.getActiveNetworkInfo();
         return nwInfo != null && nwInfo.isAvailable();
     }
 }
 public void turnOnMobileDataAlert(){
     NetworkInfo ni = connectivityManager.getNetworkInfo(ConnectivityManager.TYPE_MOBILE);
     boolean mobileDataEnabled = ni.isConnectedOrConnecting();
     // If mobile data is not enabled, show a dialog to the user



 }
 public void init(){
     if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.LOLLIPOP) {
         networkRequest = new NetworkRequest.Builder()
                 .addCapability(NetworkCapabilities.NET_CAPABILITY_INTERNET)
                 .addTransportType(NetworkCapabilities.TRANSPORT_WIFI)
                 .addTransportType(NetworkCapabilities.TRANSPORT_CELLULAR)
                 .build();
     }

     if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.LOLLIPOP) {
         ConnectivityManager.NetworkCallback networkCallback = new ConnectivityManager.NetworkCallback() {

             @Override
             public void onAvailable(@NonNull Network network) {
                 super.onAvailable(network);
                 String type="";
                 NetworkInfo activeNetwork = connectivityManager.getActiveNetworkInfo();
                 if(eventSink!=null){
                     if (activeNetwork != null) {
                         if (activeNetwork.getType() == ConnectivityManager.TYPE_WIFI) {
                             type = "Wifi";

                         } else if (activeNetwork.getType() == ConnectivityManager.TYPE_MOBILE ) {
                             type = "mobile";

                         }
                     }
                     Map<String, String> data = new HashMap<>();
                     data.put("status", "available");
                     data.put("type", type);
                     uiThreadHandler.post(() ->eventSink.success( data) );

                 }
             }

             @Override
             public void onLost(@NonNull Network network) {
                 super.onLost(network);
                 if(eventSink!=null){
                     Map<String,String> data= Collections.singletonMap("status", "lost");
                     uiThreadHandler.post(() ->eventSink.success(data) );

                 }
             }

             @Override
             public void onLosing(@NonNull Network network, int maxMsToLive) {
                 super.onLosing(network, maxMsToLive);
                 if(eventSink!=null){
                     Map<String,String> data= Collections.singletonMap("status", "losing");
                     uiThreadHandler.post(() ->eventSink.success(data) );

                 }
             }

             @Override
             public void onUnavailable() {
                 super.onUnavailable();
                 if(eventSink!=null){
                     Map<String,String> data= Collections.singletonMap("status", "unavailable");
                     uiThreadHandler.post(() ->eventSink.success(data) );
                 }
             }





         };
         connectivityManager.requestNetwork(networkRequest, networkCallback);
     }
 }
    @Override
    public void onListen(Object arguments, EventChannel.EventSink events) {
        eventSink=events;

    }

    @Override
    public void onCancel(Object arguments) {
eventSink=null;
    }

    @Override
    public void onReceive(Context context, Intent intent) {

    }
}
