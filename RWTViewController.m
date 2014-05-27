//
//  RWTViewController.m
//  HelloOpenGL
//
//  Created by Main Account on 3/18/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

#import "RWTViewController.h"
#import "RWTVertex.h"
#import "RWTBaseEffect.h"
#import "RWTTree.h"
#import "RWTSword.h"
#import "Sphere.h"
#import "cylinder.h"
@import CoreMotion;
@interface RWTViewController ()

@end

@implementation RWTViewController {
  RWTBaseEffect *_shader;
  RWTTree *_tree;
  RWTSword *_sword;
  Sphere *_sphere;
    cylinder *_cylinder;
    CMMotionManager *_motionManager;
    float posX_float;
}

- (void)setupScene {
  _shader = [[RWTBaseEffect alloc] initWithVertexShader:@"RWTSimpleVertex.glsl" fragmentShader:@"RWTSimpleFragment.glsl"];
  _tree = [[RWTTree alloc] initWithShader:_shader];
  _sword = [[RWTSword alloc] initWithShader:_shader];
    _sphere = [[Sphere alloc]initWithShader:_shader];
    _sphere.position = GLKVector3Make(-1,-3,1);
    _cylinder = [[cylinder alloc] initWithShader:_shader];
    //_cylinder.position = GLKVector3Make(0, 3.5, 2);
  _sword.position = GLKVector3Make(0, 2, 0);
  _shader.projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(85.0), self.view.bounds.size.width / self.view.bounds.size.height, 1, 150);
    _motionManager = [[CMMotionManager alloc]init];
    [_motionManager startAccelerometerUpdates];
    int posX = arc4random() % 35;
    int minusOrPlus = (arc4random() %2)+1;
    posX_float = (float)posX / 24;
    if (minusOrPlus >1) {
        posX_float = -posX_float;
    }
 
}
-(void)processUserMotionForUpdate:(NSTimeInterval)currentTime{
    CMAccelerometerData *data = _motionManager.accelerometerData;
    if ((data.acceleration.x)>0.2) {
        _sphere.position = GLKVector3Make(_sphere.position.x + 0.1, -3, 1);
    }
    if ((data.acceleration.x)<-0.2) {
        _sphere.position = GLKVector3Make(_sphere.position.x - 0.1, -3, 1);
    }
    if (_sphere.position.x <= -2.4) {
        _sphere.position = GLKVector3Make(-2.4, -3, 1);
    }
    if (_sphere.position.x >= 2.4) {
        _sphere.position = GLKVector3Make(2.4, -3, 1);
    }
    
    
}
- (void)viewDidLoad
{
  [super viewDidLoad];
	GLKView *view = (GLKView *)self.view;
  view.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
  view.drawableDepthFormat = GLKViewDrawableDepthFormat16;
  
  [EAGLContext setCurrentContext:view.context];
  
  [self setupScene];
  
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
  glClearColor(200.0/255.0, 104.0/255.0, 55.0/255.0, 1.0);
  glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
  glEnable(GL_DEPTH_TEST);
  glEnable(GL_CULL_FACE);
  glEnable(GL_BLEND);
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
  //FIXME:change the 1 to -1
  GLKMatrix4 viewMatrix = GLKMatrix4MakeTranslation(0, -1, -5);
  viewMatrix = GLKMatrix4Rotate(viewMatrix, GLKMathDegreesToRadians(20), 1, 0, 0);
  
  [_tree renderWithParentModelViewMatrix:viewMatrix];
  [_sword renderWithParentModelViewMatrix:viewMatrix];
    [_sphere renderWithParentModelViewMatrix:viewMatrix];
    [_cylinder renderWithParentModelViewMatrix:viewMatrix];
}

- (void)update {
  [_tree updateWithDelta:self.timeSinceLastUpdate];
  [_sword updateWithDelta:self.timeSinceLastUpdate];
    [_sphere updateWithDelta:self.timeSinceLastUpdate];
    [_cylinder updateWithDelta:self.timeSinceLastUpdate];
     [self processUserMotionForUpdate:self.timeSinceLastUpdate];
    _cylinder.position = GLKVector3Make(posX_float, (_cylinder.position.y-0.041), 2.0);
    
    if (_cylinder.position.y <= -3.0) {
        int posX = arc4random() % 35;
        int minusOrPlus = (arc4random() %2)+1;
        posX_float = (float)posX / 24;
        if (minusOrPlus >1) {
            posX_float = -posX_float;
        }
        NSLog(@"posX_float = %f",posX_float);
        _cylinder.position = GLKVector3Make(posX_float, 3.5, 2.0);
    }
}

@end
