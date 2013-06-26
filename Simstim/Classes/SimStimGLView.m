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
        
        //self.contentScaleFactor = [[UIScreen mainScreen] scale];
        [camera autoAdjustAspectRatio:YES animated:YES];
        
        // fish eye
        //[camera lensPerspective:1.33333333 near:0.01 far:100.0 angle:100.0];
        
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


- (void)removeMesh:(NSString*)meshName
{
    NGLMesh * mesh = [self getMeshByName:meshName];
    if(mesh != nil){
        if([camera hasMesh:mesh]){
            [camera removeMesh:mesh];
        }
    }
}
/*
 Method adds custom mesh given it's name, string containing structures (position, normals and texcoord) and string containing indices
 
 
 // Mesh's structure. Each line represents one vertex with all its elements.
 float structures[] = {
 -0.3, -0.3, 0.0f, 1.0f, 1.0f, 1.0f, 1.0f, 0.0f, 0.0f, // position (4), normals (3), texcoord (2)
 0.3, -0.3, 0.0f, 1.0f, 1.0f, 1.0f, 1.0f, 1.0f, 0.0f,
 0.3, 0.3, 0.0f, 1.0f, 1.0f, 1.0f, 1.0f, 1.0f, 1.0f,
 -0.3, 0.3, 0.0f, 1.0f, 1.0f, 1.0f, 1.0f, 0.0f, 1.0f,
 };
 
 // Mesh's indices. Each line forms a triangle. Only triangles are accepted by OpenGL ES.
 unsigned int indices[] = {
 0, 1, 2,
 2, 3, 0,
 };
 */
- (void)createMesh:(NSString*)meshName withStructures:(NSString*)stru withIndices:(NSString*)indi withVertexShader:(NSString*)vsh withFragmentShader:(NSString*)fsh withTexture:(NSString*)texture
{
    int i;
    int count;
    // convert structures string to float array
    NSArray *arrStructures = [stru componentsSeparatedByString:@","];
    float *structures;
    structures = (float *)malloc([arrStructures count] * sizeof(float));
    for (i = 0, count = [arrStructures count]; i < count; i = i + 1)
    {
        structures[i] = [[arrStructures objectAtIndex:i] floatValue];
    }
    // convert indices string to unsigned integer array
    NSArray *arrIndices = [indi componentsSeparatedByString:@","];
    unsigned int indices[[arrIndices count]];
    for (i = 0, count = [arrIndices count]; i < count; i = i + 1)
    {
        indices[i] = [[arrIndices objectAtIndex:i] integerValue];
    }
    
    
    // Instruction about the elements presents in the structure.
    // The params in order are: Element's name, Starting Index, Length, (internal) always 0.
    NGLMeshElements *elements = [[NGLMeshElements alloc] init]; // Remember to release it later.
    [elements addElement:(NGLElement){NGLComponentVertex, 0, 4, 0}];
    [elements addElement:(NGLElement){NGLComponentNormal, 4, 3, 0}];
    [elements addElement:(NGLElement){NGLComponentTexcoord, 7, 2, 0}];
    
    
    // Defining the mesh's material.
    //NGLMaterial *material = [NGLMaterial material];
    //material.diffuseMap = [NGLTexture texture2DWithImage:[UIImage imageNamed:@"land.jpg"]];
    NGLMaterial *material = [NGLMaterial materialPewter];
    //material.diffuseMap = [NGLTexture texture2DWithImage:[UIImage imageNamed:@"leather_bump.jpg"]];
    
    
    // Setting the mesh's structure and informing about the counts of the arrays defined above.
    NGLMesh *mesh = [[NGLMesh alloc] init];
    [mesh setIndices:indices count:[arrIndices count]];
    [mesh setStructures:structures count:[arrStructures count] stride:9];
    [mesh.meshElements addFromElements:elements];
    if(![texture isEqualToString:@""]){
        material.diffuseMap = [NGLTexture texture2DWithImage:[UIImage imageNamed:texture]];
    }
    mesh.material = material;
    
    
    /*NSString *vShader = @"\
    varying lowp vec4 color;\
    void main()\
    {\
    gl_Position = u_nglMVPMatrix * a_nglPosition;\
    color = vec4((a_nglPosition.x+1.0)*0.5, (a_nglPosition.y+1.0)*0.5, (a_nglPosition.z+1.0)*0.5, 1.0);\
    }";
    NSString *pShader = @"\
    varying lowp vec4 color;\
    void main(void)\
    { \
    gl_FragColor = color;\
    }";
    mesh.shaders = [NGLShaders shadersWithSourcesVertex:vShader andFragment:pShader];
    */
    //mesh.shaders = [NGLShaders shadersWithFilesVertex:@"shader.vsh" andFragment:@"shader.fsh"];
    
    
    if(![vsh isEqual: @""] && ![fsh isEqual: @""]){
        mesh.shaders = [NGLShaders shadersWithSourcesVertex:vsh andFragment:fsh];
    }else if(![vsh isEqual: @""]){
        mesh.shaders = [NGLShaders shadersWithSourcesVertex:vsh andFragment:nil];
    }else if(![fsh isEqual: @""]){
        mesh.shaders = [NGLShaders shadersWithSourcesVertex:nil andFragment:fsh];
    }
    
    mesh.name = meshName;
    
    // Compiling the mesh.
    [mesh performSelector:@selector(updateCoreMesh)];
    
    [mesh setRotationSpace:NGLRotationSpaceLocal];
    
    [camera addMesh:mesh];
    //free(structures);
    //free(indices);
}

- (void)setMeshShaders:(NSString*)meshName withVertexShader:(NSString*)vsh withFragmentShader:(NSString*)fsh
{
    NGLMesh * mesh = [self getMeshByName:meshName];
    if(mesh != nil){
        mesh.shaders = [NGLShaders shadersWithSourcesVertex:vsh andFragment:fsh];
        [mesh compileCoreMesh];
    }
}
- (NSString *)getMeshCoords:(NSString*)meshName
{
    NGLMesh * mesh = [self getMeshByName:meshName];
    NSString * coor = @"";
    if(mesh != nil){
        NGLvec3 vec = *(mesh.position);
        coor = [coor stringByAppendingString:[NSString stringWithFormat:@"%f,", vec.x]];
        coor = [coor stringByAppendingString:[NSString stringWithFormat:@"%f,", vec.y]];
        coor = [coor stringByAppendingString:[NSString stringWithFormat:@"%f", vec.z]];
    }
    return coor;
}
- (NSString *)getCamCoords
{
    NSString * coor = @"";
    NGLvec3 vec = *(camera.position);
    coor = [coor stringByAppendingString:[NSString stringWithFormat:@"%f,", vec.x]];
    coor = [coor stringByAppendingString:[NSString stringWithFormat:@"%f,", vec.y]];
    coor = [coor stringByAppendingString:[NSString stringWithFormat:@"%f", vec.z]];
    return coor;
}
- (void)moveTo:(NSString*)meshName coordX:(NSString*)x coordY:(NSString*)y coordZ:(NSString*)z duration:(NSString*)d
{
    NGLMesh * mesh = [self getMeshByName:meshName];
    if(mesh != nil){
        NSDictionary *tween;
        tween = [NSDictionary dictionaryWithObjectsAndKeys:
                 //kNGLEaseSmoothInOut, kNGLTweenKeyEase,
                 //kNGLTweenRepeatMirrorEase, kNGLTweenKeyRepeat,
                 //@"2.0",kNGLTweenKeyRepeatDelay,
                 x, @"x",
                 y, @"y",
                 z, @"z",
                 nil];
        [NGLTween tweenTo:tween duration:[d floatValue] target:mesh];
    }
}
- (void)moveCamTo:(NSString*)x coordY:(NSString*)y coordZ:(NSString*)z duration:(NSString*)d
{
        NSDictionary *tween;
        tween = [NSDictionary dictionaryWithObjectsAndKeys:
                 //kNGLTweenRepeatMirrorEase, kNGLTweenKeyRepeat,
                 //@"2.0",kNGLTweenKeyRepeatDelay,
                 x, @"x",
                 y, @"y",
                 z, @"z",
                 nil];
        [NGLTween tweenTo:tween duration:[d floatValue] target:camera];
}


@end
