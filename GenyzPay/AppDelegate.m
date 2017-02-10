//
//  AppDelegate.m
//  GenyzPay
//
//  Created by admin on 04.05.16.
//  Copyright © 2016 n. All rights reserved.
//

#import "AppDelegate.h"

#import "UINavigationBar+GenyzNavigationCustomization.h"
#import "GPDonor+Runtime.h"
#import "GPLocationSingleton.h"

#import "SWRevealViewController.h"
#import "ViewController.h"
#import "MenuViewController.h"
#import "RecipientsListViewController.h"
#import "LoginViewController.h"

@interface AppDelegate () <SWRevealViewControllerDelegate>

@end

@implementation AppDelegate

-(BOOL)instantiateLoginViewController
{

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Login" bundle:nil];
    LoginViewController *avc = [storyboard instantiateViewControllerWithIdentifier:@"loginController"];
    self.window.rootViewController = avc;
    [self.window makeKeyAndVisible];
    return YES;

}
-(void)detectDevice
{
     UIScreen *mainScreen = [UIScreen mainScreen];
    if (IS_IPHONE_5)
    {
        
        NSLog(@"Screen bounds: %@, Screen resolution: %@, scale: %f, nativeScale: %f",NSStringFromCGRect(mainScreen.bounds), mainScreen.coordinateSpace, mainScreen.scale, mainScreen.nativeScale);
        
    }
    if (IS_IPHONE_6) {
         NSLog(@"Screen bounds: %@, Screen resolution: %@, scale: %f, nativeScale: %f",NSStringFromCGRect(mainScreen.bounds), mainScreen.coordinateSpace, mainScreen.scale, mainScreen.nativeScale);
        
    }
    if (IS_IPHONE_6_PLUS) {
        NSLog(@"Screen bounds: %@, Screen resolution: %@, scale: %f, nativeScale: %f",NSStringFromCGRect(mainScreen.bounds), mainScreen.coordinateSpace, mainScreen.scale, mainScreen.nativeScale);
    }
    else
    {
         NSLog(@"Screen bounds: %@, Screen resolution: %@, scale: %f, nativeScale: %f",NSStringFromCGRect(mainScreen.bounds), mainScreen.coordinateSpace, mainScreen.scale, mainScreen.nativeScale);
    }


}
-(BOOL)initRootController
{
    UIStoryboard *storyboardMain   = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    SWRevealViewController *revealController = [storyboardMain instantiateViewControllerWithIdentifier:@"mainController"];
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    revealController.rearViewRevealWidth = screenBounds.size.width - 55;
    revealController.delegate = self;
    
    self.window.rootViewController = revealController;

    return YES;
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  
    [self detectDevice];
    [[GPLocationSingleton sharedManager] initLocationManager];
    [[GPDonor currentDonor] populateObjectsFromMemory];
    [UINavigationBar customizeGenyzNavigationBar];
    
    
    if([[GPDonor currentDonor].token length]==0){
    
    //    return [self instantiateLoginViewController];
    
    }
    
    
    
    return [self initRootController];
   
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
