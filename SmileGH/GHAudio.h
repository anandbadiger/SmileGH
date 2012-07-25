//
//  GHAudio.h
//  SmileGH
//
//  Created by PROVAB TECHNOSOFT PVT LTD PROVAB on 7/5/12.
//  Copyright (c) 2012 PROVABTECHNOSOFT PVT LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SHKActivityIndicator.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>


@interface GHAudio : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UISearchDisplayDelegate,AVAudioPlayerDelegate,UIPickerViewDelegate>
{
    SHKActivityIndicator        *indicator;

    UIImageView                 *tableimage,*audiobackroundimage;
    UIImageView                 *playbackimage,*streamingimage;
    UIScrollView                *scroll;
    UITableView                 *ghAudioTable;
    
    NSString                    *str;
    
    UIButton                    *custamplaybtn,*custampreviousbtn,*custamnextbtn;
    
    NSMutableArray              *Audioarray;
    NSMutableDictionary         *dictDetails;
    NSURLConnection             *connection;
    NSMutableData               *receivedData;

    UIBarButtonItem             *settingbtn;
    UISearchBar                 *sBar;

    UILabel                     *currentTimelbl,*durationlbl;
}

-(void)jsonloadaudiotable;
-(void)selectaudio:(id)sender;

@end
