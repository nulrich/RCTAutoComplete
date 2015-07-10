#import "RCTBridgeModule.h"
#import "RCTViewManager.h"
#import "MLPAutoCompleteTextField/MLPAutoCompleteTextField.h"

@interface RCTAutoComplete : RCTViewManager <MLPAutoCompleteTextFieldDataSource, MLPAutoCompleteTextFieldDelegate>

@end