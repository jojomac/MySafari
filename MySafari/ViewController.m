//
//  ViewController.m
//  MySafari
//
//  Created by Joanne McNamee on 5/14/14.
//  Copyright (c) 2014 JMWHS. All rights reserved.
//

#import "ViewController.h"


@interface ViewController () <UIWebViewDelegate, UITextFieldDelegate, UIAlertViewDelegate, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *forwardButton;
@property (weak, nonatomic) IBOutlet UIButton *backButton;

@property (weak, nonatomic) IBOutlet UITextField *myURLTextField;
@property (weak, nonatomic) IBOutlet UIWebView *myWebView;



@end

@implementation ViewController
- (IBAction)onForwardButtonPressed:(id)sender {
    [self.myWebView goForward];
    }



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.backButton setEnabled:NO];
    [self.forwardButton setEnabled:NO];
    self.myWebView.scrollView.delegate=self;
    
	}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{

    [self.backButton setEnabled:([webView canGoBack])];
    [self.forwardButton setEnabled:([webView canGoForward])];

}
- (IBAction)onBackButtonPressed:(id)sender
{


    [self.myWebView goBack];
}

- (IBAction)onStopLoadingButtonPressed:(id)sender
{
    [self.myWebView stopLoading];


}

- (IBAction)onReloadButtonPressed:(id)sender
{
    [self.myWebView reload];
}
- (IBAction)onTeaserButtonPressed:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] init];
    alert.title = @"Hello to Ryan";
    alert.message = @"Coming Soon!";
    [alert addButtonWithTitle:@"OK"];
    alert.delegate = self;
    [alert show];

}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
if (self.myWebView.scrollView.contentOffset.y==0)
{
    [self.myURLTextField setHidden:YES];
}
else{
    [self.myURLTextField setHidden:NO];
}

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSString *urlString = self.myURLTextField.text;
   if (![urlString hasPrefix:@"http://"])
   {
        urlString = [@"http://" stringByAppendingString:urlString];
   }

    NSURL *url =[NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.myWebView loadRequest:request];
    [textField resignFirstResponder];
    return YES;

}








@end
