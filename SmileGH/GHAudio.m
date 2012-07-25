//
//  GHAudio.m
//  SmileGH
//
//  Created by PROVAB TECHNOSOFT PVT LTD PROVAB on 7/5/12.
//  Copyright (c) 2012 PROVABTECHNOSOFT PVT LTD. All rights reserved.
//

#import "GHAudio.h"
#import "JSON.h"

@implementation GHAudio

void RouteChangeListener(void *   inClientData,
                         AudioSessionPropertyID	inID,
                         UInt32                  inDataSize,
                         const void *            inData);


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
        
        self.title = @"GH MUSIC";
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main_bg.png"]];
               
       
        sBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0,392,320,40)];
        self->sBar.backgroundColor = [UIColor blackColor];
        sBar.tintColor = UIColorFromRGB(0x333333);
        [sBar sizeToFit];
        sBar.delegate = self;
        
        [self.view addSubview:sBar];
        
        ghAudioTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 108, 320, 284) style:UITableViewStylePlain];
        ghAudioTable.delegate = self;
        ghAudioTable .dataSource= self;
        [ghAudioTable setBackgroundColor:[UIColor whiteColor]];
        ghAudioTable.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"main_bg.png"]];
        [self.view addSubview:ghAudioTable];
       
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"setting-icon.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(setting)];

               
            }
    return self;
}

-(void)dealloc {
    
    [super dealloc];

    [ghAudioTable release];
    [settingbtn release];
    
    [streamingimage release];
    [playbackimage release];
   
    [custamplaybtn release];
    [custampreviousbtn release];
    [audiobackroundimage release];
    [custamnextbtn release];

}

-(void)loadView {
    
    [super loadView];
    
    indicator= [[SHKActivityIndicator alloc]init];
    Audioarray = [[NSMutableArray alloc] init];
    [self jsonloadaudiotable];

       }

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    scroll=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    [scroll setContentSize:CGSizeMake(320, 690)];
    [self.view addSubview:scroll];
    [scroll setShowsVerticalScrollIndicator:NO];
    
//    streamingimage=[[UIImageView alloc] initWithFrame:CGRectMake(0,5,320, 50)];
//    [streamingimage setImage:[UIImage imageNamed:@"gh_videobg2.png"]];
//    [scroll addSubview:streamingimage];
//    
//    playbackimage=[[UIImageView alloc] initWithFrame:CGRectMake(0,56,320, 70)];
//    [playbackimage setImage:[UIImage imageNamed:@"gh_videobg1.png"]];
//    [scroll addSubview:playbackimage];
//    
//    custamplaybtn=[UIButton buttonWithType:UIButtonTypeCustom];
//    [custamplaybtn setImage:[UIImage imageNamed:@"pause.png"] forState:UIControlStateNormal];
//    [custamplaybtn addTarget:self action:@selector(playaudio:) forControlEvents:UIControlEventTouchUpInside];
//    [custamplaybtn setFrame:CGRectMake(130, 70, 65, 65)];
//    [scroll addSubview:custamplaybtn];
//    
//    custamplaybtn.layer.shadowColor = UIColorFromRGB(0x000000).CGColor;
//    custamplaybtn.layer.shadowOffset = CGSizeMake(1, 1);
//    custamplaybtn.layer.shadowOpacity = 1;
//    [scroll addSubview:custamplaybtn];
//    
//    custampreviousbtn=[UIButton buttonWithType:UIButtonTypeCustom];
//    [custampreviousbtn setImage:[UIImage imageNamed:@"gh_musicbb.png"] forState:UIControlStateNormal];
//    [custampreviousbtn addTarget:self action:@selector(previousaudio:) forControlEvents:UIControlEventTouchUpInside];
//    [custampreviousbtn setFrame:CGRectMake(30, 70, 65, 65)];
//    [scroll addSubview:custampreviousbtn];
//    
//    custampreviousbtn.layer.shadowColor = UIColorFromRGB(0x000000).CGColor;
//    custampreviousbtn.layer.shadowOffset = CGSizeMake(1, 1);
//    custampreviousbtn.layer.shadowOpacity = 1;
//    [scroll addSubview:custampreviousbtn];
//    
//    
//    custamnextbtn=[UIButton buttonWithType:UIButtonTypeCustom];
//    [custamnextbtn setImage:[UIImage imageNamed:@"gh_musicff.png"] forState:UIControlStateNormal];
//    [custampreviousbtn addTarget:self action:@selector(nextaudio:) forControlEvents:UIControlEventTouchUpInside];
//    [custamnextbtn setFrame:CGRectMake(230, 70, 65, 65)];
//    [scroll addSubview:custamnextbtn];
//    
//    custamnextbtn.layer.shadowColor = UIColorFromRGB(0x000000).CGColor;
//    custamnextbtn.layer.shadowOffset = CGSizeMake(1, 1);
//    custamnextbtn.layer.shadowOpacity = 1;
//    [scroll addSubview:custamnextbtn];
//    
//    

}

#pragma json Data From Server

-(void)jsonloadaudiotable {
    
    
    SBJSON *jsonWriter = [SBJSON new];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:@"http://provabtest.com/Offshore/smilegh/webservices/audio_list.php"]];
    
    NSString *requestString = nil;
    
    NSMutableData *requestData = [NSMutableData dataWithBytes: [requestString UTF8String] length:[requestString length]];
    
    [request setHTTPMethod:@"POST"];
    
    [request setHTTPBody: requestData];
    connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    [jsonWriter release];
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    
    receivedData = [[NSMutableData alloc]init ];
    Audioarray = [[NSMutableArray alloc]init ];
    
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)aData {
    
    [receivedData appendData:aData];
    
    
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    
    NSString *jsonString = [[[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding] autorelease];
    Audioarray = [[(NSMutableDictionary*)[jsonString JSONValue] valueForKey:@"detail"]retain];
    [ghAudioTable reloadData];
    [indicator stopActivity];
    
    NSLog(@"audio array : %@",jsonString);
    
}

#pragma Table Displaying


-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath: (NSIndexPath *)indexPath {
    
    return 77;
}


- (NSInteger)tableView:(UITableView *)tableView  numberOfRowsInSection:(NSInteger)section {
    
    
    return [Audioarray count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath; {
    
    
    static NSString *CellIdentifier = @"Cell";
    NSMutableDictionary *dict = [Audioarray objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    if (cell == nil) 
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle 
        
                                       reuseIdentifier:CellIdentifier] autorelease];  
       
    
        

        UIImage *image;
        
        
        UIButton *playbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        image = [UIImage imageNamed:@"gh_plybtn.png"];
        [playbutton setBackgroundImage:image forState:UIControlStateNormal];
        playbutton.frame = CGRectMake(245, 25, 50, 24);
        
        [playbutton addTarget:self action:@selector(selectaudio:) forControlEvents:UIControlEventTouchUpInside];
        [playbutton setTag:indexPath.row];
        playbutton.tag = indexPath.row;
        [cell.contentView addSubview:playbutton];
        
        
       
    }
    
    [cell.contentView.subviews objectAtIndex:0];    

    cell.imageView.image = [UIImage imageNamed:@"gh_songimg.png"];
    cell.textLabel.text = [dict valueForKey:@"name"];
    cell.textLabel.textColor = [UIColor whiteColor];
    [cell.textLabel setFont:[UIFont fontWithName:@"Andale Mono" size:14]];
    cell.detailTextLabel.text = [dict valueForKey:@"type"];
    
    cell.detailTextLabel.text = [dict valueForKey:@"type"];
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    
    cell.textLabel.backgroundColor = [UIColor clearColor];  
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    [cell setAccessoryType:UITableViewCellAccessoryNone];
    tableView.allowsSelection = YES;

	
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    bool isSelected;
    
    if (indexPath.row == isSelected) {
        
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,320, 77)];
        imageV.image = [UIImage imageNamed:@"gh_videobg3.png"];
        [cell setBackgroundView:imageV];

    }
    else {
        
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,320, 77)];
        imageV.image = [UIImage imageNamed:@"gh_videobg4.png"];
        [cell setBackgroundView:imageV];

        
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
    


}

#pragma Audio play button Action 
    

-(void)selectaudio:(id)sender {
    

    NSDictionary *audiodata = [Audioarray objectAtIndex:[sender tag]];
  NSString *audiostring = [audiodata objectForKey:@"url"];
    
//    AVPlayer *audioPlayer = [[AVPlayer playerWithURL:[NSURL URLWithString:audiostring]]retain];
//    AVPlayerLayer* playerLayer = [AVPlayerLayer playerLayerWithPlayer:audioPlayer];
//    playerLayer.frame = CGRectMake(0, 0, 320, 70);
//    playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
//    playerLayer.needsDisplayOnBoundsChange = YES;
//
//
//    
//       UIAlertView *alret = [[UIAlertView alloc]initWithTitle:@"Smile GH" message:@"Audio Selected" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//
//        [alret show];
//    
//    [audioPlayer play];
//

    NSError *activationError = nil;

    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:audiostring] error:&activationError];
    [player play];
   
    [[AVAudioSession sharedInstance] setDelegate: self];
    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryAmbient error: nil];
   
    
    
       if (activationError) 
    {
        NSLog(@"Error: %@",[activationError description]);
    }
    else 
    {
        player.delegate = self;
        [player play];
        NSLog(@"audio array : %@",audiostring);

    }
    

}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    
     

    
}


-(void)playaudio:(id)sender {
    
    
}

-(void)previousaudio:(id)sender {
    
    
}

-(void)nextaudio:(id)sender {
    
    
}



- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}



#pragma mark - View lifecycle



- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
    sBar.showsCancelButton = YES;
    sBar.autocorrectionType = UITextAutocorrectionTypeNo;
    [Audioarray removeAllObjects];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    
    sBar.showsCancelButton = NO;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    [Audioarray removeAllObjects];
    
    if([searchText isEqualToString:@""]||searchText==nil){
        
        [ghAudioTable reloadData];
        
        return;
        
    }
    
  }

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    

    [sBar resignFirstResponder];
    
    sBar.text = @"";
    
}

- (void)viewDidUnload {
    
    [super viewDidUnload];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
     
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
