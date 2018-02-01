//
//  WeakScriptMessageHandler.m
//  TaxiShare
//
//  Created by macpro on 2018/1/31.
//  Copyright © 2018年 上海毕咨信息技术有限公司. All rights reserved.
//

#import "WeakScriptMessageHandler.h"

@implementation WeakScriptMessageHandler


-(instancetype)initWithDelegate:(id<WKScriptMessageHandler>)delagate{
    self = [super init];
    if(self){
        _delegate = delagate;
    }
    return self;
}

-(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    [self.delegate userContentController:userContentController didReceiveScriptMessage:message];
}

@end
