#import "WMFShareCardViewController.h"
#import "WMFShareCardImageContainer.h"
@import WMF;

@interface WMFShareCardViewController ()

@property (weak, nonatomic) IBOutlet WMFShareCardImageContainer *shareCardImageContainer;
@property (weak, nonatomic) IBOutlet UILabel *shareSelectedText;
@property (weak, nonatomic) IBOutlet UILabel *shareArticleTitle;
@property (weak, nonatomic) IBOutlet UILabel *shareArticleDescription;
@property (weak, nonatomic) IBOutlet UIImageView *wikipediaWordmarkImageView;
@end

@implementation WMFShareCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.wikipediaWordmarkImageView.image = [[UIImage imageNamed:@"wikipedia"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.wikipediaWordmarkImageView.tintColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)fillCardWithArticleURL:(nullable NSURL *)articleURL articleTitle:(nullable NSString *)articleTitle articleDescription:(nullable NSString *)articleDescription text:(nullable NSString *)text image:(nullable UIImage *)image {
    // The layout system will transpose the Wikipedia logo, CC-BY-SA,
    // title, and Wikidata description for congruence with the lead
    // image's title and description, which is determined by system
    // language, so we just adjust the text layout accordingly for the
    // title and Wikidata description. For the snippet, we want to mimic
    // the webview's layout alignment, which is based upon actual article
    // language directionality.
    NSString *language = articleURL.wmf_language;
    UISemanticContentAttribute attribute = [MWLanguageInfo semanticContentAttributeForWMFLanguage:language];
    NSTextAlignment snippetAlignment = attribute == UISemanticContentAttributeForceRightToLeft ? NSTextAlignmentRight : NSTextAlignmentLeft;
    self.shareSelectedText.text = text;
    self.shareSelectedText.textAlignment = snippetAlignment;

    NSTextAlignment subtextAlignment = NSTextAlignmentNatural;
    self.shareArticleTitle.text = articleTitle;
    self.shareArticleTitle.textAlignment = subtextAlignment;
    self.shareArticleDescription.text = articleDescription;
    self.shareArticleDescription.textAlignment = subtextAlignment;

    if (image) {
        // in case the image has transparency, make its container white
        self.shareCardImageContainer.image = image;
        self.shareCardImageContainer.backgroundColor = [UIColor whiteColor];
        //self.shareCardImageContainer.leadImage = article.image;
    } else {
        // no image, set the background color to black
        self.shareCardImageContainer.backgroundColor = [UIColor blackColor];
    }
}

@end
