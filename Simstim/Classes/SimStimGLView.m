//
//  SimStimGLView.m
//  Simstim
//
//  Created by Slobodan Jovanovic on 4/13/13.
//
//

#import "SimStimGLView.h"

@implementation SimStimGLView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        meshes = [NSMutableDictionary dictionary];
        settings = [NSDictionary dictionaryWithObjectsAndKeys:
                    kNGLMeshOriginalYes, kNGLMeshKeyOriginal,
                    kNGLMeshCentralizeYes, kNGLMeshKeyCentralize,
                    @"1.0", kNGLMeshKeyNormalize,
                    nil];
        camera = [[NGLCamera alloc] init];
        
        /*NGLMesh * mesh = [[NGLMesh alloc] initWithFile:@"base-female-nude.obj" settings:settings delegate:nil];
        [mesh compileCoreMesh];
        camera = [[NGLCamera alloc] initWithMeshes:mesh, nil];
         */
        
        [camera autoAdjustAspectRatio:YES animated:YES];
        
    }
    return self;
}

- (void) drawView
{
    [camera drawCamera];
}

- (void)addMesh:(NSString*)filename
{
    NSDictionary * stt = [NSDictionary dictionaryWithObjectsAndKeys:
                          //kNGLMeshOriginalYes, kNGLMeshKeyOriginal,
                          kNGLMeshCentralizeYes, kNGLMeshKeyCentralize,
                          @"1.0", kNGLMeshKeyNormalize,
                          nil];
    NGLMesh * mesh = [[NGLMesh alloc] initWithFile:filename settings:stt delegate:nil];
    
    /*if([meshes objectForKey:filename]){
        [meshes setObject:mesh forKey:filename];
    }*/
    NSLog(@"File: %@", filename);
    if(![camera hasMesh:mesh]){
        
        // TODO: cleanup
        NGLMaterial *material = [NGLMaterial materialBronze];
        [mesh setMaterial:material];
        [mesh compileCoreMesh];
        
        //[mesh setRotateY:10];
        mesh.name = filename;
        [mesh setRotationSpace:NGLRotationSpaceLocal];
        
        
        [camera addMesh:mesh];
    }
}

- (void)setCamCoords:(NSString*)x withY:(NSString*)y withZ:(NSString*)z
{
    [camera setX:[x floatValue]];
    [camera setY:[y floatValue]];
    [camera setZ:[z floatValue]];
}

- (void)setCamRotation:(NSString*)x withY:(NSString*)y withZ:(NSString*)z
{
    [camera setRotateX:[x floatValue]];
    [camera setRotateY:[y floatValue]];
    [camera setRotateZ:[z floatValue]];
}

- (void)setMeshRotation:(NSString*)meshName withX:(NSString*)x withY:(NSString*)y withZ:(NSString*)z
{
    NGLMesh * mesh = [self getMeshByName:meshName];
    if(mesh != nil){
        [mesh rotateToX:[x floatValue] toY:[y floatValue] toZ:[z floatValue]];
    }
}

- (void)setMeshCoords:(NSString*)meshName withX:(NSString*)x withY:(NSString*)y withZ:(NSString*)z
{
    NGLMesh * mesh = [self getMeshByName:meshName];
    if(mesh != nil){
        [mesh translateToX:[x floatValue] toY:[y floatValue] toZ:[z floatValue]];
    }
}

- (void)setMeshScale:(NSString*)meshName withX:(NSString*)x withY:(NSString*)y withZ:(NSString*)z
{
    NGLMesh * mesh = [self getMeshByName:meshName];
    if(mesh != nil){
        [mesh setScaleX:[x floatValue]];
        [mesh setScaleY:[y floatValue]];
        [mesh setScaleZ:[z floatValue]];
    }
}

- (NGLMesh *)getMeshByName:(NSString*)name
{    
    for (NGLMesh * mesh in camera.allMeshes) {
        if([[mesh name] isEqualToString:name]){
            return mesh;
        }
    }
    return nil;
}


- (void)removeMesh:(NSString*)filename
{
    if([camera hasMesh:[meshes objectForKey:filename]]){
        [camera removeMesh:[meshes objectForKey:filename]];
    }
}

@end
