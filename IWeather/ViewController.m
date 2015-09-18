//
//  ViewController.m
//  IWeather
//
//  Created by Dzung Tran on 8/9/15.
//  Copyright (c) 2015 IOS32 class - Techmaster. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UIButton *temperatureBtn;
@property (weak, nonatomic) IBOutlet UIImageView *weatherIconImg;
@property (weak, nonatomic) IBOutlet UILabel *quoteLabel;
@property (weak, nonatomic) IBOutlet UILabel *temperatureUnitLabel;

@property float currentCelsiusTemperature;
@property NSString* currentLocation;
@property NSString* currentQuote;
@property NSString* currentPhotoFile;
@property NSNumber* currentTemperatureUnit;

@end

@implementation ViewController
{
    NSArray* quotes;
    NSArray* locations;
    NSArray* photoFiles;
    NSDictionary* temperatureUnitLabels;

    NSNumber* CELSIUS;
    NSNumber* FAHRENHEIT;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    quotes = @[@"Một con ngựa đau cả tàu bỏ cỏ", @"Có công mài sắt có ngày nên kim", @"Chớ thấy sóng cả mà ngã tay chèo", @"Không có gì quý hơn độc lập tự do hạnh phúc", @"Đi một ngày đàng học một sàng không"];
    
    locations = @[@"Hai Ba Trung, Hanoi", @"Sydney, Australia", @"New York, USA"];
    
    photoFiles = @[@"rain", @"sunny", @"thunder", @"windy"];
    
    CELSIUS = @1;
    FAHRENHEIT = @2;
    
    temperatureUnitLabels = @{CELSIUS: @"C", FAHRENHEIT: @"F"};
    
    [self initFirstView];
}

- (void)initFirstView {
    self.currentTemperatureUnit = CELSIUS;
    [self updateWeatherInfo];
    [self redrawWeatherView];
}

- (IBAction)refreshBtnTouch:(id)sender {
    [self updateWeatherInfo];
    [self redrawWeatherView];
}

- (IBAction)temperatureBtnTouch:(id)sender {
    [self switchTemperatureUnit];
    [self redrawWeatherView];
}

- (void)updateWeatherInfo {
    self.currentCelsiusTemperature = [self getCelsiusTemperature];
    self.currentLocation = locations[arc4random_uniform((u_int32_t)locations.count)];
    self.currentPhotoFile = photoFiles[arc4random_uniform((u_int32_t)photoFiles.count)];
    self.currentQuote = quotes[arc4random_uniform((u_int32_t)quotes.count)];
}

- (void)redrawWeatherView {
    float t = self.currentCelsiusTemperature;
    if ([self isFahrenheit]) {
        t = [self convertCelsiusToFahrenheit:(self.currentCelsiusTemperature)];
    }
    NSString* str = [NSString stringWithFormat:@"%2.1f", t];
    [self.temperatureBtn setTitle:str forState:UIControlStateNormal];

    self.locationLabel.text = self.currentLocation;
    self.quoteLabel.text = self.currentQuote;
    self.weatherIconImg.image = [UIImage imageNamed:self.currentPhotoFile];
    self.temperatureUnitLabel.text = temperatureUnitLabels[self.currentTemperatureUnit];
}

- (void)switchTemperatureUnit {
    if ([self isCelsius]) {
        self.currentTemperatureUnit = FAHRENHEIT;
    }
    else {
        self.currentTemperatureUnit = CELSIUS;
    }
}

- (bool)isCelsius {
    return self.currentTemperatureUnit == CELSIUS;
}

- (bool)isFahrenheit {
    return self.currentTemperatureUnit == FAHRENHEIT;
}

- (float) getCelsiusTemperature {
    return 14.0 + arc4random_uniform(18) + (float)arc4random() / (float)INT32_MAX;
}

- (float) convertCelsiusToFahrenheit:(float)temperature {
    return temperature * 1.8 + 32;
}


@end
