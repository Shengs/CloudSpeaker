//
//  CSLoginViewController.m
//  Cloud Speaker
//
//  Created by chaos on 3/3/15.
//  Copyright (c) 2015 No Fun. All rights reserved.
//

#import "CSLoginViewController.h"

@interface CSLoginViewController ()


@end

@implementation CSLoginViewController

- (void)viewDidLoad {
    
    // Set this in every view controller so that the back button displays back instead of the root view controller name
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed: @"NavBarBG.png"] forBarMetrics: UIBarMetricsDefault];
    
    //Set navBar image programatically    (NavBar.png replace with the image)
    
    UIImage *image = [UIImage imageNamed: @"logo.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage: image];
    
    self.navigationItem.titleView = imageView;
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)login:(id)sender {
    NSString *username = _usernameTextField.text;
    NSString *password = _passwordTextField.text;
    
    NSString *anURL;
    
    anURL = @"http://shihengz.com/service.php";
    
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:anURL]];
    [request setHTTPMethod:@"POST"];
    
    NSString *post =[[NSString alloc] initWithFormat:@"username=%@&password=%@", username, password];
    [request setHTTPBody:[post dataUsingEncoding:NSASCIIStringEncoding]];
    
    NSURLResponse *response;
    NSError *err;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
    NSString *responseStr = [NSString stringWithUTF8String:[responseData bytes]];
    NSLog(@"%@", responseStr);}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
