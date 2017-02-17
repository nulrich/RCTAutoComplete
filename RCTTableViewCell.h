#import <React/RCTRootView.h>
#import <UIKit/UIKit.h>

@interface RCTTableViewCell : UITableViewCell
@property (strong, nonatomic) RCTRootView *view;
-(void)initWithBridge:(RCTBridge*)bridge reactComponent:(NSString*)reactComponent json:(NSDictionary*)json;
@end
