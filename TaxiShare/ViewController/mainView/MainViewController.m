//
//  MainViewController.m
//  TaxiShare
//
//  Created by macpro on 2018/1/30.
//  Copyright © 2018年 上海毕咨信息技术有限公司. All rights reserved.
//

#import "MainViewController.h"

@implementation MainViewController
NSString *host = @"http://www.ucastcomputer.com:8800/taxisharing";
//NSString *host = @"http://192.168.0.132/taxi";
NSString *msgFun = @"getUserMsg";
NSString *lastUrl = @"url";
NSString *token = @"Token";
NSString *usrname = @"UserName";
-(void)viewDidLoad{
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
    
    CGFloat webView_width = self.view.frame.size.width;
    CGFloat webView_height = self.view.frame.size.height - 20 ;
    WKWebView *webView_tem = [[WKWebView alloc] initWithFrame:CGRectMake(0, 20, webView_width, webView_height)];
    
    
    [webView_tem.configuration.userContentController addScriptMessageHandler:[[WeakScriptMessageHandler alloc] initWithDelegate:self]  name:msgFun];
    [self.view addSubview:webView_tem];
    webView_tem.UIDelegate = self;
    webView_tem.navigationDelegate = self;
    self.webView = webView_tem;
    
    
    
    NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
    NSString *url = [userDefault objectForKey:lastUrl];
    if (url) {
        [self loadString:url];
        return;
    }
    [self loadString:host];
}

#pragma mark - WKNavigationDelegate
//页面开始加载时调用
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    
}

//页面加载完成时调用
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
}
//确认是否请求url
-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    NSString *url = navigationAction.request.URL.absoluteString;
    if([url containsString:host]){
        NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
        [userDefault setObject:url forKey:lastUrl];
        [userDefault synchronize];
    }
    if ([url containsString:@"tel"]) {
//        UIWebView *callWv = [[UIWebView alloc] init];
//        [callWv loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
//        [self.view addSubview:callWv];
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url] options:@{@"":@""} completionHandler:nil];
        decisionHandler(WKNavigationActionPolicyCancel);
    }else if([url containsString:@"mail"]){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url] options:@{@"":@""} completionHandler:nil];
        decisionHandler(WKNavigationActionPolicyCancel);
    }
    
    decisionHandler(WKNavigationActionPolicyAllow);
}

//确认是否响应URL
-(void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    decisionHandler(WKNavigationResponsePolicyAllow);
}
#pragma mark - UIWebviewDelegate
-(void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    completionHandler();
}

#pragma mark - WKScriptMessageHandler
//js调用oc的回调
-(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    
    NSDictionary *res = [NSDictionary dictionaryWithDictionary:message.body];
    if ([res objectForKey:token]) {
        NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
        [userDefault setObject:[res objectForKey:token] forKey:token];
        [userDefault synchronize];
    }else if([res objectForKey:usrname]){
        NSUserDefaults *userDefault=[NSUserDefaults standardUserDefaults];
        [userDefault setObject:[res objectForKey:usrname] forKey:usrname];
        [userDefault synchronize];
        AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [((LeftSortsViewController *)tempAppDelegate.LeftSlideVC.leftVC).nameLable setText:[res objectForKey:usrname]];
    }
    
   
}


-(void)dealloc{
    [self.webView.configuration.userContentController removeScriptMessageHandlerForName:msgFun];
//    NSLog(@"释放了");
}





// 让浏览器加载指定的字符串
- (void)loadString:(NSString *)str  {
    NSString *urlStr = str;
//    if (![str hasPrefix:@"http://"]) {
//        urlStr = [NSString stringWithFormat:@"http://m.baidu.com/s?word=%@", str];
//    }
    NSURL *url = [NSURL URLWithString:urlStr];
    // 2. 把URL告诉给服务器,请求,从m.baidu.com请求数据
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    // 3. 发送请求给服务器
    [self.webView loadRequest:request];
}

@end


