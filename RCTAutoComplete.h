#import <React/RCTBridgeModule.h>
#import <React/RCTViewManager.h>
#import "MLPAutoCompleteTextField/MLPAutoCompleteTextField.h"

@interface RCTAutoComplete : RCTViewManager <MLPAutoCompleteTextFieldDataSource, MLPAutoCompleteTextFieldDelegate>

@end