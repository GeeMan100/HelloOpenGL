//
//  RWTModel.h
//  HelloOpenGL
//
//  Created by Main Account on 3/18/14.
//  Copyright (c) 2014 Razeware LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RWTVertex.h"

@class RWTBaseEffect;
@import GLKit;

@interface RWTModel : NSObject

@property (nonatomic, strong) RWTBaseEffect *shader;
@property (nonatomic, assign) GLKVector3 position;
@property (nonatomic) float rotationX;
@property (nonatomic) float rotationY;
@property (nonatomic) float rotationZ;
@property (nonatomic) float scale;
@property (nonatomic) GLuint texture;
@property (assign) GLKVector3 matAmbientColor;
@property (assign) GLKVector3 matDiffuseColor;
@property (assign) GLKVector3 matSpecularColor;
@property (assign) float shininess;

- (instancetype)initWithName:(char *)name shader:(RWTBaseEffect *)shader vertices:(RWTVertex *)vertices vertexCount:(unsigned int)vertexCount;
- (void)renderWithParentModelViewMatrix:(GLKMatrix4)parentModelViewMatrix;
- (void)updateWithDelta:(NSTimeInterval)dt;
- (void)loadTexture:(NSString *)filename;

@end
