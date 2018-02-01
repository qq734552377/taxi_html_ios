//
//  WeakScriptMessageHandler.h
//  TaxiShare
//
//  Created by macpro on 2018/1/31.
//  Copyright © 2018年 上海毕咨信息技术有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
@import WebKit;

@interface WeakScriptMessageHandler : NSObject<WKScriptMessageHandler>
@property (nonatomic,weak) id<WKScriptMessageHandler> delegate;
-(instancetype)initWithDelegate:(id<WKScriptMessageHandler>) delagate;

@end
