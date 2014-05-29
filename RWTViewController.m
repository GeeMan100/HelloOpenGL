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
#import "Board.h"

@import CoreMotion;
@interface RWTViewController (){
    int secondsPassed;
    int thirdCylinder;
    int fourthCylinder;
    int fifthCylinder;
}

@end

@implementation RWTViewController {
  RWTBaseEffect *_shader;
  RWTTree *_tree;
  RWTSword *_sword;
  Sphere *_sphere;
    cylinder *_cylinder;
    cylinder *_hitCyliner;
    CMMotionManager *_motionManager;
    cylinder *_secCylinder;
    NSTimeInterval _lastUpdateTime;
    NSTimeInterval _deltaTime;
    cylinder *_thirdCylinder;
    cylinder *_fourthCylinder;
    cylinder *_fifthCylinder;
    Board *_board;
}

- (void)setupScene {
  _shader = [[RWTBaseEffect alloc] initWithVertexShader:@"RWTSimpleVertex.glsl" fragmentShader:@"RWTSimpleFragment.glsl"];
  _tree = [[RWTTree alloc] initWithShader:_shader];
  _sword = [[RWTSword alloc] initWithShader:_shader];
    _sphere = [[Sphere alloc]initWithShader:_shader];
    _sphere.position = GLKVector3Make(1,-1,1);
    _cylinder = [[cylinder alloc] initWithShader:_shader];
    _secCylinder = [[cylinder alloc] initWithShader:_shader];
    _thirdCylinder = [[cylinder alloc]initWithShader:_shader];
    _fourthCylinder = [[cylinder alloc]initWithShader:_shader];
    _fifthCylinder = [[cylinder alloc] initWithShader:_shader];
    _board = [[Board alloc] initWithShader:_shader];
    //_cylinder.position = GLKVector3Make(0, 3.5, 2);
  _sword.position = GLKVector3Make(0, 2, 0);
    //
    float aspect = fabsf(self.view.bounds.size.width / self.view.bounds.size.height);
    //
    _shader.projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(65.0f), aspect, 0.1f, 100.0f);
    _motionManager = [[CMMotionManager alloc]init];
    [_motionManager startAccelerometerUpdates];
    [_cylinder loadTexture:@"cylinderblue.png"];
    [_secCylinder loadTexture:@"barrelsecond.png"];
    [_thirdCylinder loadTexture:@"whitebarrel.png"];
    [_fourthCylinder loadTexture:@"whitebarrel.png"];
    [_fifthCylinder loadTexture:@"barrelsecond.png"];
    [_board loadTexture:@"boardred.png"];
    
}
-(void)processUserMotionForUpdate:(NSTimeInterval)currentTime{
    CMAccelerometerData *data = _motionManager.accelerometerData;
    if ((data.acceleration.x)>0.2) {
        _sphere.position = GLKVector3Make(_sphere.position.x + 0.1, -1, 1);
    }
    if ((data.acceleration.x)<-0.2) {
        _sphere.position = GLKVector3Make(_sphere.position.x - 0.1, -1, 1);
    }
    if (_sphere.position.x <= -1.5) {
        _sphere.position = GLKVector3Make(-1.5, -1, 1);
    }
    if (_sphere.position.x >= 1.5) {
        _sphere.position = GLKVector3Make(1.5, -1, 1);
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
  GLKMatrix4 viewMatrix = GLKMatrix4MakeTranslation(0, 0, -5);
  //viewMatrix = GLKMatrix4Rotate(viewMatrix, GLKMathDegreesToRadians(20), 1, 0, 0);
  
  [_tree renderWithParentModelViewMatrix:viewMatrix];
  [_sword renderWithParentModelViewMatrix:viewMatrix];
    [_sphere renderWithParentModelViewMatrix:viewMatrix];
    [_cylinder renderWithParentModelViewMatrix:viewMatrix];
    [_secCylinder renderWithParentModelViewMatrix:viewMatrix];
    [_thirdCylinder renderWithParentModelViewMatrix:viewMatrix];
    [_fourthCylinder renderWithParentModelViewMatrix:viewMatrix];
    [_fifthCylinder renderWithParentModelViewMatrix:viewMatrix];
    [_board renderWithParentModelViewMatrix:viewMatrix];
}
-(void)checkCollisions:(cylinder*)aCylinder{
    if (((aCylinder.position.x) <= (_sphere.position.x + 0.2) && (aCylinder.position.x) >= (_sphere.position.x - 0.2) &&(aCylinder.position.y) <= (_sphere.position.y + 0.12) && (aCylinder.position.y) >= (_sphere.position.y - 0.12))) {
        
       // NSLog(@"aCylinder.posX = %f,aCylinder.posY = %f,_sphere.posX = %f,           _sphere.posY = %f"
      //        ,aCylinder.position.x, aCylinder.position.y,_sphere.position.x, _sphere.position.y);
        
    
    }
    
    
}
- (void)hitTest {
    [self checkCollisions:_cylinder];
    [self checkCollisions:_secCylinder];
    [self checkCollisions:_thirdCylinder];
    [self checkCollisions:_fourthCylinder];
    [self checkCollisions:_fifthCylinder];
}
-(void)checkBoardOneCollisions{
    if ((_board.position.x-1.3) <= _sphere.position.x  && (_board.position.y-0.01) <= (_sphere.position.y) && (_board.position.y + 0.01) >= (_sphere.position.y)) {
        NSLog(@"_board.position.x = %f,_board.position.y = %f, _sphere.position.x = %f, _sphere.position.y = %f", _board.position.x, _board.position.y, _sphere.position.x, _sphere.position.y);
    }
}
- (void)update {
    if (_lastUpdateTime) {
        _deltaTime = self.timeSinceLastUpdate - _lastUpdateTime;
    }else{
        _deltaTime = 0;
    
    }
    secondsPassed++;
    thirdCylinder++;
    fourthCylinder++;
    fifthCylinder++;
    _lastUpdateTime = self.timeSinceLastUpdate;
  [_tree updateWithDelta:self.timeSinceLastUpdate];
  [_sword updateWithDelta:self.timeSinceLastUpdate];
   
    [_sphere updateWithDelta:self.timeSinceLastUpdate];
     [self hitTest];
    [_cylinder updateWithDelta:self.timeSinceLastUpdate];
     [self processUserMotionForUpdate:self.timeSinceLastUpdate];
    
    if (secondsPassed > 30) {
        [_secCylinder updateWithDelta:self.timeSinceLastUpdate];
        if (_secCylinder.position.y <= -3) {
            secondsPassed = 0;
        }
    }
    if (thirdCylinder > 45) {
        [_thirdCylinder updateWithDelta:self.timeSinceLastUpdate];
        if (_thirdCylinder.position.y <= -3) {
            thirdCylinder = 0;
        }
    }
    if (fourthCylinder > 65) {
        [_fourthCylinder updateWithDelta:self.timeSinceLastUpdate];
        if (_fourthCylinder.position.y <= -3) {
            fourthCylinder = 0;
        }
    }
    if (fifthCylinder > 100) {
        [_fifthCylinder updateWithDelta:self.timeSinceLastUpdate];
        if (_fifthCylinder.position.y <= -3) {
            fifthCylinder = 0;
        }
    }
    [_board updateWithDelta:self.timeSinceLastUpdate];
    
    [self hitTest];
    [self checkBoardOneCollisions];
    
}

@end
