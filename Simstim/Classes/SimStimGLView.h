//
//  SimStimGLView.h
//  Simstim
//
//  Created by Slobodan Jovanovic on 4/13/13.
//
//

#import <NinevehGL/NinevehGL.h>

@interface SimStimGLView : NGLView <NGLViewDelegate>
{
    @private
    NGLCamera *camera; // for now only one camera
    NSMutableDictionary *meshes;
    NSDictionary *settings;
    
    float camX;
    float camY;
    float camZ;
    
}
- (void)addMesh:(NSString*)filename;
- (void)setCamCoords:(NSString*)x withY:(NSString*)y withZ:(NSString*)z;
- (void)setCamRotation:(NSString*)x withY:(NSString*)y withZ:(NSString*)z;
- (NGLMesh *)getMeshByName:(NSString*)name;
- (void)setMeshRotation:(NSString*)meshName withX:(NSString*)x withY:(NSString*)y withZ:(NSString*)z;
- (void)setMeshCoords:(NSString*)meshName withX:(NSString*)x withY:(NSString*)y withZ:(NSString*)z;
- (void)setMeshScale:(NSString*)meshName withX:(NSString*)x withY:(NSString*)y withZ:(NSString*)z;
- (void)createMesh:(NSString*)meshName withStructures:(NSString*)stru withIndices:(NSString*)indi withVertexShader:(NSString*)vsh withFragmentShader:(NSString*)fsh withTexture:(NSString*)texture;
- (void)setMeshShaders:(NSString*)meshName withVertexShader:(NSString*)vsh withFragmentShader:(NSString*)fsh;
- (NSString *)getMeshCoords:(NSString*)meshName;
- (NSString *)getCamCoords;
- (void)moveTo:(NSString*)meshName coordX:(NSString*)x coordY:(NSString*)y coordZ:(NSString*)z duration:(NSString*)d;
- (void)moveCamTo:(NSString*)x coordY:(NSString*)y coordZ:(NSString*)z duration:(NSString*)d;
@end
