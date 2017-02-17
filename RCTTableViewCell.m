#import <React/RCTRootView.h>
#import "RCTTableViewCell.h"

@implementation RCTTableViewCell

@synthesize view;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    return [super initWithStyle:style reuseIdentifier:reuseIdentifier];
}

-(void)initWithBridge:(RCTBridge*)bridge reactComponent:(NSString*)reactComponent json:(NSDictionary*)json  {
    if (view == nil) {
        view = [[RCTRootView alloc] initWithBridge:bridge moduleName:reactComponent initialProperties:@{@"data": json}];
        [self.contentView addSubview:view];
        view.frame = self.contentView.frame;
    } else {
        view.appProperties = @{@"data": json};
    }
}

@end
