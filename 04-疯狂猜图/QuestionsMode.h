//
//  QuestionsMode.h
//  04-疯狂猜图
//
//  Created by zhanglu1988em on 16/1/3.
//  Copyright © 2016年 wbder. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestionsMode : NSObject

-(instancetype) initWithDict: (NSDictionary*) dict;
+(instancetype) QuestionWithDict:(NSDictionary*) dict;
+(NSArray*) Questions;


@end
