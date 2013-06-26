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
        // initialize the OpenGL view
        glview = [[SimStimGLView alloc] initWithFrame:frame];
        
        
        // If a trasparent background of the NGLView is needed
        //glview.backgroundColor = [UIColor clearColor];
        //nglGlobalColorFormat(NGLColorFormatRGBA);
        //nglGlobalFlush();
        
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
    }
}

- (void)addMesh:(CDVInvokedUrlCommand*)command
{
    [self.commandDelegate runInBackground:^{
        NSString* payload = nil;
        [glview addMesh:[command.arguments objectAtIndex:0]];
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:payload];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}


- (void)setCamCoords:(CDVInvokedUrlCommand*)command
{
    [self.commandDelegate runInBackground:^{
        NSString* payload = nil;
        [glview setCamCoords:[command.arguments objectAtIndex:0] withY:[command.arguments objectAtIndex:1] withZ:[command.arguments objectAtIndex:2]];
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:payload];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}

- (void)setCamRotation:(CDVInvokedUrlCommand*)command
{
    [self.commandDelegate runInBackground:^{
        NSString* payload = nil;
        [glview setCamRotation:[command.arguments objectAtIndex:0] withY:[command.arguments objectAtIndex:1] withZ:[command.arguments objectAtIndex:2]];
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:payload];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}

- (void)setMeshRotation:(CDVInvokedUrlCommand*)command
{
    [self.commandDelegate runInBackground:^{
        NSString* payload = nil;
        [glview setMeshRotation:[command.arguments objectAtIndex:0] withX:[command.arguments objectAtIndex:1] withY:[command.arguments objectAtIndex:2] withZ:[command.arguments objectAtIndex:3]];
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:payload];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}
- (void)setMeshCoords:(CDVInvokedUrlCommand*)command
{
    [self.commandDelegate runInBackground:^{
        NSString* payload = nil;
        [glview setMeshCoords:[command.arguments objectAtIndex:0] withX:[command.arguments objectAtIndex:1] withY:[command.arguments objectAtIndex:2] withZ:[command.arguments objectAtIndex:3]];
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:payload];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}
- (void)setMeshScale:(CDVInvokedUrlCommand*)command
{
    [self.commandDelegate runInBackground:^{
        NSString* payload = nil;
        [glview setMeshScale:[command.arguments objectAtIndex:0] withX:[command.arguments objectAtIndex:1] withY:[command.arguments objectAtIndex:2] withZ:[command.arguments objectAtIndex:3]];
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:payload];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}

- (void)createMesh:(CDVInvokedUrlCommand*)command
{
    [self.commandDelegate runInBackground:^{
        NSString* payload = nil;
        [glview createMesh:[command.arguments objectAtIndex:0] withStructures:[command.arguments objectAtIndex:1] withIndices:[command.arguments objectAtIndex:2] withVertexShader:[command.arguments objectAtIndex:3] withFragmentShader:[command.arguments objectAtIndex:4] withTexture:[command.arguments objectAtIndex:5]];
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:payload];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}

- (void)setMeshShaders:(CDVInvokedUrlCommand*)command
{
    [self.commandDelegate runInBackground:^{
        NSString* payload = nil;
        [glview setMeshShaders:[command.arguments objectAtIndex:0] withVertexShader:[command.arguments objectAtIndex:1] withFragmentShader:[command.arguments objectAtIndex:2]];
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:payload];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}


- (void)getMeshCoords:(CDVInvokedUrlCommand*)command
{
    [self.commandDelegate runInBackground:^{
        NSString* payload = [glview getMeshCoords:[command.arguments objectAtIndex:0]];
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:payload];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}
- (void)getCamCoords:(CDVInvokedUrlCommand*)command
{
    [self.commandDelegate runInBackground:^{
        NSString* payload = [glview getCamCoords];
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:payload];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}
- (void)moveTo:(CDVInvokedUrlCommand*)command
{
    [self.commandDelegate runInBackground:^{
        NSString* payload = nil;
        [glview moveTo:[command.arguments objectAtIndex:0] coordX:[command.arguments objectAtIndex:1] coordY:[command.arguments objectAtIndex:2] coordZ:[command.arguments objectAtIndex:3] duration:[command.arguments objectAtIndex:4]];
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:payload];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}
- (void)moveCamTo:(CDVInvokedUrlCommand*)command
{
    [self.commandDelegate runInBackground:^{
        NSString* payload = nil;
        [glview setMeshShaders:[command.arguments objectAtIndex:0] withVertexShader:[command.arguments objectAtIndex:1] withFragmentShader:[command.arguments objectAtIndex:2]];
        [glview moveCamTo:[command.arguments objectAtIndex:0] coordY:[command.arguments objectAtIndex:1] coordZ:[command.arguments objectAtIndex:1] duration:[command.arguments objectAtIndex:3]];
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:payload];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }];
}

/*
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
