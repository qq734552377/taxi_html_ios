//
//  MainViewController.h
//  TaxiShare
//
//  Created by macpro on 2018/1/30.
//  Copyright © 2018年 上海毕咨信息技术有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@import WebKit;
#import "WeakScriptMessageHandler.h"
#import "AppDelegate.h"
#import "LeftSortsViewController.h"

@interface MainViewController : UIViewController<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>


@property (nonatomic,strong) WKWebView *webView;
@end
