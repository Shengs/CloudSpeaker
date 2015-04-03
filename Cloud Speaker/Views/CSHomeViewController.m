//
//  CSHomeViewController.m
//  Cloud Speaker
//
//  Created by chaos on 3/3/15.
//  Copyright (c) 2015 No Fun. All rights reserved.
//

#import "CSHomeViewController.h"

@interface CSHomeViewController ()

@end

@implementation CSHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)oushH:(id)sender {
    
    [self performSegueWithIdentifier:@"pushHost" sender:self];
}
- (IBAction)oushL:(id)sender {
    [self performSegueWithIdentifier:@"pushListen" sender:self];
}


- (void)viewDidLoad
{
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


//- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
//{
////    UIImage *navBarImage = [UIImage imageNamed:@"NavBarBG.png"];
////    [[UINavigationBar appearance]setBackgroundImage:navBarImage forBarMetrics:UIBarMetricsDefault];
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
