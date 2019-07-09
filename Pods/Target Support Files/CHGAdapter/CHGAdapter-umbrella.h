#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "CHGOneViewCollectionReusableView.h"
#import "CHGOneViewCollectionViewCell.h"
#import "CHGOneViewTableViewCell.h"
#import "CHGOneViewTableViewHeaderFooterView.h"
#import "UIView+AdapterContentModel.h"
#import "CHGAdapter.h"
#import "UICollectionView+CHGCollectionViewAdapter.h"
#import "UICollectionView+CHGSimpleCollectionViewAdapter.h"
#import "CHGCollectionReusableView.h"
#import "CHGCollectionViewAdapter.h"
#import "CHGCollectionViewCell.h"
#import "CHGSimpleCollectionViewAdapter.h"
#import "CHGCollectionViewEmptyDataShow.h"
#import "CHGCollectionViewAdapterData.h"
#import "UITableView+CHGSimpleTableViewAdapter.h"
#import "UITableView+CHGTableViewAdapter.h"
#import "CHGSimpleTableViewAdapter.h"
#import "CHGTableViewAdapter.h"
#import "CHGTableViewAdapterDefine.h"
#import "CHGTableViewCell.h"
#import "CHGTableViewHeaderFooterView.h"
#import "CHGTableViewEmptyDataShow.h"
#import "CHGTableViewAdapterData.h"
#import "UIView+CHGBehaviorListener.h"
#import "CHGScrollListener.h"
#import "CHGCollectionReusableViewLifeCycleProtocol.h"
#import "CHGSubDataOfKeyPathDelegate.h"
#import "CHGTableViewHeaderFooterLifeCycleProtocol.h"
#import "CHGViewLifeCycleProtocol.h"
#import "CHGViewPropertyProtocol.h"
#import "CHGBaseView.h"
#import "CHGTaskManager.h"

FOUNDATION_EXPORT double CHGAdapterVersionNumber;
FOUNDATION_EXPORT const unsigned char CHGAdapterVersionString[];

