
# network_monitor


A Flutter plugin that allows you to check the network connectivity and listen for changes. This plugin works for Android.
 

#### check internet connectivity

```javascript
import 'package:network_monitor/network_monitor.dart';

//create a instance of networkmonitor
final _networkMonitorPlugin = NetworkMonitor();
//it return bool
_networkMonitorPlugin.isOnline()
```
#### listen for changes

```javascript
import 'package:network_monitor/network_monitor.dart';

//create a instance of networkmonitor
final _networkMonitorPlugin = NetworkMonitor();
///it return [Stream<NetworkStatus>?]
var result=_networkMonitorPlugin.onChange();
result.listen((event){
    //network changes
})
```


## Screenshots

<p>
    <img src="https://github.com/mohammed-jasir-7/images/blob/main/networkMonitor.png?raw=true"/>
    
</p>

# Hi, I'm Jasir! 👋
https://github.com/mohammed-jasir-7


## 🔗 Links
[![github](https://cdn.iconscout.com/icon/free/png-512/free-github-169-1174970.png?f=webp&w=80)](https://github.com/mohammed-jasir-7)



[![linkedin](https://img.shields.io/badge/linkedin-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/jasir-bin-shihabudeen-61b99722b/)



## Support

For support, email jasirm203@gmail.com 
