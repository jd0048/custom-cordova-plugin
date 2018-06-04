/********* MyCustomCordovaPlugin.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>

@interface MyCustomCordovaPlugin : CDVPlugin {
  // Member variables go here.
}

- (void)coolMethod:(CDVInvokedUrlCommand*)command;
@end

@implementation MyCustomCordovaPlugin

- (void)coolMethod:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSString* echo = [command.arguments objectAtIndex:0];
    if (echo != nil && [echo length] > 0) {
          UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:@"Welcome"
                                 message:echo
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"Thank you!!"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                }];
    [alert addAction:yesButton];
        [self presentAlertcontroller:alert];
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:echo];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}
-(UIViewController *)getTopPresentedViewController {
    UIViewController *presentingViewController = self.viewController;
    if (presentingViewController.view.window != [UIApplication sharedApplication].keyWindow){
        presentingViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    }
    
    while (presentingViewController.presentedViewController != nil && ![presentingViewController.presentedViewController isBeingDismissed]){
        presentingViewController = presentingViewController.presentedViewController;
    }
    return presentingViewController;
}

-(void)presentAlertcontroller:(UIAlertController *)alert {
    
    [self.getTopPresentedViewController presentViewController:alert animated:YES completion:^{
    }];
    
}

@end
