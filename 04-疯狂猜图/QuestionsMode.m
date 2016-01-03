//
//  QuestionsMode.m
//  04-疯狂猜图
//
//  Created by zhanglu1988em on 16/1/3.
//  Copyright © 2016年 wbder. All rights reserved.
//

#import "QuestionsMode.h"


@interface QuestionsMode()

@property (nonatomic,copy) NSString* answer;
@property (nonatomic,copy) NSString *icon;
@property (nonatomic,copy) NSString* title;
@property (nonatomic,strong) NSArray*  options;


@end


@implementation QuestionsMode


-(instancetype) initWithDict: (NSDictionary*) dict
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+(instancetype) QuestionWithDict:(NSDictionary*) dict
{
    return [[self alloc] initWithDict:dict];
}

+(NSArray*)Questions
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"questions" ofType:@"plist"];
    NSArray *arry = [[NSArray alloc] initWithContentsOfFile:path];
    NSMutableArray *arryM = [NSMutableArray array];
    for (NSDictionary *dict in arry) {
        [arryM addObject:[self QuestionWithDict:dict]];
    }
    return arryM;
}

@end
