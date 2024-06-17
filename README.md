# TCFlutterGoRouter 


https://github.com/ysimonx/TCFlutterGoRouter/assets/1449867/ff6ce389-844c-4aa8-99b6-a0bed35b872f



<img width="1401" alt="Capture d’écran 2024-06-17 à 09 35 45" src="https://github.com/ysimonx/TCFlutterGoRouter/assets/1449867/56e4fc71-d07f-4197-aa81-a9f939fdcdee">


# Install

1 - add lib to pubspec.yaml

code:

    tc_serverside_plugin:
    
          git:
    
                  url: https://github.com/CommandersAct/tcserverside-flutter-plugin.git
      
                  ref: 1.1.0-idfa
      
   

2 - import tc.dart

3 - init tc variable with site_id

tc = TC(
      siteId: xxxx,
      privacyId: x,
      sourceKey: "xxxxxx-xxxx-xxxx-xxxxxxx");


4 - add tc.getObserver() to GoRouter

