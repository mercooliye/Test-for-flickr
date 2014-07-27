//
//  mercoolViewController.m
//  flipertest
//
//  Created by CooLX on 16/07/14.
//  Copyright (c) 2014 CooLX. All rights reserved.
//

#import "mercoolViewController.h"
#import "CellFliper.h"
#import "MySingleton.h"

@interface mercoolViewController ()


@end

@implementation mercoolViewController
NSURLConnection *conn;
NSMutableData *data_table;

@synthesize ids;
@synthesize photo;
@synthesize imgcash;
@synthesize curpage;
@synthesize maxpage;
@synthesize progresspage;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title=@"Новые";
    [progresspage startAnimating];
    photo=[[NSArray alloc]init];
    ids=[[NSArray alloc]init];

    NSString *url =[NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.getRecent&api_key=a991528def8e687bbcf2c5a5325edb02&format=json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]
                                             cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15.0];
    conn = [NSURLConnection connectionWithRequest:request delegate:self];
    data_table =[NSMutableData data];
    
    UIRefreshControl *refresh=[[UIRefreshControl alloc] init];
    [self.table addSubview:refresh];
    self.refresh = refresh;
    [self.refresh addTarget:self action:@selector(updateTable) forControlEvents:UIControlEventValueChanged];
    
    
    
    
    [self.refresh setTintColor:   [[UIColor alloc] initWithRed:0.204 green:0.667 blue:0.804 alpha:1.0]];
    NSAttributedString *attrst=[[NSAttributedString alloc] initWithString:@"Опустите чтобы обновить"];
    [self.refresh setAttributedTitle:attrst];


    
}
- (void)updateTable
{
    NSAttributedString *attrst=[[NSAttributedString alloc] initWithString:@"Обновляем"];
    [self.refresh setAttributedTitle:attrst];
    
    [self updateData];
}
-(void)updateData
{
    NSString *url =[NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.getRecent&api_key=a991528def8e687bbcf2c5a5325edb02&format=json"];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]
                                             cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15.0];
    conn = [NSURLConnection connectionWithRequest:request delegate:self];
    data_table =[NSMutableData data];

}
-(void)addPage
{
    int target=[curpage intValue];
    target++;
    NSString *url =[NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.getRecent&api_key=a991528def8e687bbcf2c5a5325edb02&format=json&page=%d", target];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]
                                             cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15.0];
    conn = [NSURLConnection connectionWithRequest:request delegate:self];
    data_table =[NSMutableData data];
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (connection==conn)
    {
        [data_table appendData:data];
    }

}
- (void)connectionDidFinishLoading:(NSURLConnection *)conect
{
    if(conect==conn)
    {
        NSError *err;
        ///////////////Огород из за не соответствия ответа стадарту JSON
        NSString *st=[[NSString alloc] initWithData:data_table encoding:NSUTF8StringEncoding];
        st= [st stringByReplacingOccurrencesOfString:@"jsonFlickrApi" withString:@""];
        st= [st stringByReplacingOccurrencesOfString:@")" withString:@""];
        st= [st stringByReplacingOccurrencesOfString:@"(" withString:@""];
        NSData *data_=[st dataUsingEncoding:NSUTF8StringEncoding];
        ///////////////Огород из за не соответствия ответа стадарту JSON


        NSDictionary *dict_= [NSJSONSerialization JSONObjectWithData:data_ options:kNilOptions error:&err];
        NSDictionary *photos=[dict_ valueForKey:@"photos"];
       
        photo=[photo arrayByAddingObjectsFromArray:[photos valueForKey:@"photo"]];

        curpage=[photos valueForKey:@"page"];
        maxpage=[photos valueForKey:@"pages"];
    
        
        [self.table reloadData];
        [self.refresh endRefreshing];
        [progresspage stopAnimating];


    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return photo.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CellFliper *cell = [self.table dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    // [imgarray addObject:@"null"];
    cell.titl.text=[NSString stringWithFormat:@"%@", [[photo objectAtIndex:indexPath.row] valueForKey:@"title"] ];

    cell.img.image=[UIImage imageNamed:@"holder.jpg"];

    cell.index=indexPath.row;
    NSDictionary *tempy=[photo objectAtIndex:indexPath.row];

    NSString *url_img=[NSString stringWithFormat:@"https://farm%@.staticflickr.com/%@/%@_%@_q.jpg",[tempy valueForKey:@"farm"], [tempy valueForKey:@"server"],[tempy valueForKey:@"id"],[tempy valueForKey:@"secret"] ];
    
    
    if ([imgcash objectForKey:[NSString stringWithFormat:@"%d", indexPath.row]])
    {
        cell.img.image=[imgcash objectForKey:[NSString stringWithFormat:@"%d", indexPath.row]];
    }
    
    else
    {
        
        dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        {

            dispatch_async(concurrentQueue, ^{
                NSData *image = [[NSData alloc] initWithContentsOfURL:[ NSURL URLWithString:url_img]];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"dispatch_get_main_queue %d", indexPath.row);
                    
              //      NSLog([NSString stringWithFormat:@"index=%d, indexrow=%d", cell.index, indexPath.row ]);
                    
                    if (cell.index==indexPath.row)
                    {
                        cell.img.hidden=YES;
                        UIImage *imgtemp=[UIImage imageWithData:image];
                        cell.img.image =imgtemp;
                        
                            if(imgtemp)
                                [imgcash setObject:imgtemp forKey:[NSString stringWithFormat:@"%d", indexPath.row]];
                        
                        [cell setNeedsLayout];
                        cell.img.hidden=NO;
                        
                       // [cell.progress stopAnimating];
                    }
                });
                
                
            });
        }
    }

    if(indexPath.row==photo.count-1)
    {
        if (maxpage!=curpage)
        {[self addPage];[progresspage startAnimating];}
    }
    
    
    return cell;
    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"detail"])
    {
        NSIndexPath *index= [self.table indexPathForSelectedRow];
        [MySingleton sharedMySingleton].index=index;
        [MySingleton sharedMySingleton].photo=photo;

    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
