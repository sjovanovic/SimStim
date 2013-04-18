//
//  SimStimGL.m
//  Simstim
//
//  Created by Slobodan Jovanovic on 4/13/13.
//
//

#import "SimStimGL.h"
#import <Cordova/CDV.h>

@implementation SimStimGL

- (void)pluginInitialize
{
    [self initSimStim];
}

- (void)initSimStim
{
    if(glview == nil){
        // get screen size
        CGRect screenBounds = [[UIScreen mainScreen] bounds];
        // add OpenGL engine's view
        CGRect frame = CGRectMake(0, 0, screenBounds.size.width, (screenBounds.size.height));
        
        
        
        glview = [[SimStimGLView alloc] initWithFrame:frame];
        
        //UIViewController *rootViewController = [[[[UIApplication sharedApplication] delegate] window] rootViewController];
        //rootViewController.view.opaque = NO;
        //rootViewController.view.backgroundColor = [UIColor clearColor];
        
        
        // make the web view background transparent so that GLView can be seen trough
        
        
        self.viewController.parentViewController.parentViewController.view.opaque = NO;
        self.viewController.parentViewController.parentViewController.view.backgroundColor = [UIColor clearColor];
        self.viewController.parentViewController.view.opaque = NO;
        self.viewController.parentViewController.view.backgroundColor = [UIColor clearColor];
        
         
         
        self.viewController.view.opaque = NO;
        self.viewController.view.backgroundColor = [UIColor clearColor];
        self.webView.opaque = NO;
        self.webView.backgroundColor = [UIColor clearColor];
        
        
        [self.viewController.view insertSubview:glview atIndex:0];
        
       
        //[self.webView insertSubview:glview atIndex:0];
        
        
        //[glview addMesh:@"base-female-nude.obj"];
    }
}

- (void)addMesh:(CDVInvokedUrlCommand*)command
{
    //[self initSimStim];
    // Check command.arguments here.
    
    [self.commandDelegate runInBackground:^{
        NSString* payload = nil;
        // Some blocking logic...
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:payload];
        // The sendPluginResult method is thread-safe.
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        [glview addMesh:[command.arguments objectAtIndex:0]];
    }];
}


- (void)setCamCoords:(CDVInvokedUrlCommand*)command
{
    //[self initSimStim];
    // Check command.arguments here.
    
    [self.commandDelegate runInBackground:^{
        NSString* payload = nil;
        // Some blocking logic...
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:payload];
        // The sendPluginResult method is thread-safe.
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        [glview setCamCoords:[command.arguments objectAtIndex:0] withY:[command.arguments objectAtIndex:1] withZ:[command.arguments objectAtIndex:2]];
    }];
}

- (void)setCamRotation:(CDVInvokedUrlCommand*)command
{
    //[self initSimStim];
    // Check command.arguments here.
    
    [self.commandDelegate runInBackground:^{
        NSString* payload = nil;
        // Some blocking logic...
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:payload];
        // The sendPluginResult method is thread-safe.
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        [glview setCamRotation:[command.arguments objectAtIndex:0] withY:[command.arguments objectAtIndex:1] withZ:[command.arguments objectAtIndex:2]];
    }];
}

- (void)setMeshRotation:(CDVInvokedUrlCommand*)command
{
    [self.commandDelegate runInBackground:^{
        NSString* payload = nil;
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:payload];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        [glview setMeshRotation:[command.arguments objectAtIndex:0] withX:[command.arguments objectAtIndex:1] withY:[command.arguments objectAtIndex:2] withZ:[command.arguments objectAtIndex:3]];
    }];
}
- (void)setMeshCoords:(CDVInvokedUrlCommand*)command
{
    [self.commandDelegate runInBackground:^{
        NSString* payload = nil;
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:payload];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        [glview setMeshCoords:[command.arguments objectAtIndex:0] withX:[command.arguments objectAtIndex:1] withY:[command.arguments objectAtIndex:2] withZ:[command.arguments objectAtIndex:3]];
    }];
}
- (void)setMeshScale:(CDVInvokedUrlCommand*)command
{
    [self.commandDelegate runInBackground:^{
        NSString* payload = nil;
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:payload];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        [glview setMeshScale:[command.arguments objectAtIndex:0] withX:[command.arguments objectAtIndex:1] withY:[command.arguments objectAtIndex:2] withZ:[command.arguments objectAtIndex:3]];
    }];
}

/*
- (void)addMesh:(CDVInvokedUrlCommand*)command
{
    // Check command.arguments here.
    [self.commandDelegate runInBackground:^{
        NSString* payload = nil;
        // Some blocking logic...
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:payload];
        // The sendPluginResult method is thread-safe.
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        [glview addMesh:[command.arguments objectAtIndex:0]];
        
    }];
}

- (void)echo:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;
    NSString* echo = [command.arguments objectAtIndex:0];
    
    if (echo != nil && [echo length] > 0) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:echo];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }
    
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void)myPluginMethod:(CDVInvokedUrlCommand*)command
{
    // Check command.arguments here.
    [self.commandDelegate runInBackground:^{
        NSString* payload = nil;
        // Some blocking logic...
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:payload];
        // The sendPluginResult method is thread-safe.
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}

*/


@end
