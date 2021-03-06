## Installation

The simplest and the most convenient way to incorporate StonlySdk is via CocoaPods. You need to add the following line to your podfile:

```
pod 'StonlySdk', '1.0.1'
```

The good practise would be to specify a particular version of the pod you wish to download.

## Usage

### General

Once you integrated SDK via cocoapods you simply need to start with an import statement:

```
import StonlySdk
```

To present popup in it's simplest form you only need to add:

```
extension MyViewController: Guidable { }
```

so that you can call:

```
try? present(screenType: typeOfScreenYouWantToPresent)
```

More on `typeOfScreenYouWantToPresent` and the method itself in following sections.

### Initialization

Before first use of the framework it needs to be initialized. Usually there are two strategies. One is to initialize framework as soon as possible (potentially long before the first use) in AppDelegate so that when the time comes the framework will be ready. The second approach is to initialize it just before it's first actual use. Best approach will depend on the nature of the app and expected user behaviors.

```
Stonly.shared.initialize(widgetId: String, completion: ((Stonly.State) -> Void)?)
```

`completion` is optional so that the first strategy could be implemented without mention of the completion in so called "fire and forget" way.

If you decide that the second strategy is more applicable in your use case you can implement `completion` so that you get informed when initialization is finished and you will get to know if it succeeded. For more check Stonly.State.

### Showing Guide

To present a guide you need to call:

```
try? present(screenType: screenType)
```

where `screenType` is of `ScreenType.guide`. Guide have an associated value of `GuideConfiguration` type.

`GuideConfiguration` takes obligatory `explanationId` and `stepId`. Additionally you can add `theme` and `eventsListener`. More about these two objects in the following sections.

`present` function can also take `floatingPanelDelegate` of `FloatingPanelDelegate` type (its optional) if you need to customize behavior of `FloatingPanel`. More information on that customization can be found on `FloatingPanel` documentation.

By default presentation is animated but this can be set to `false` if no animation is needed.

### Showing Knowledge Base

To present Knowledge Base you need to call:

```
try? present(screenType: screenType)
```

where `screenType` is `ScreenType.knowledgeBase` with associated value of `KnowledgeBaseConfiguration`.

The only non optional attribute there is `baseURL`. `containerId` and `stepId` are optional. Similarly to `GuideConfiguration` it also can take `theme` and `eventsListener` objects.

### Other forms of presentation

In current version there is a wrapper for presenting pop ups using `FloatingPanel` but if the way of presentation or the wrapper is not the preferred way you can also use `StonlyWebViewController` yourself and call `start(screenType: ScreenType)` function to show guide or knowledge base.

### Theming

Popups can be customized by 2 parameters:

- language
- accent color

`language` should be in ISO 639-2 or ISO 630-1 format. Although attribute is of `String` type if developer passes string longer than 3 characters remaining part will be stripped out and only (up to) first 3 characters will be taken into account.

`accent` is of UIColor type. Alpha value of a color will be ignored assuming full alpha.

Both parameters are optional. Creation of object could look like:

```
let theme = ThemeConfig(language: "en", accent: .green)
```

### Events Listening

To be able to listen to events you need to create listener object and define which events you want to listen to and which completion block should be called if an event should happen. Events you can listen to are:

- currentStep
- currentSteps
- endOfExplanation
- explanationIntroduction
- goBackClicked
- goToNewRequest
- openFrontChat
- openIntercom
- openZendeskChat
- stonlyDataTransmission
- stonlyWidgetFullscreenOpen
- stonlyWidgetFullscreenClose

To actually listen to the specific event you have to:

```
let listener = EventListener()
listener.add(for: .currentStep) { params in
    // closure that will be called if event occur
}
```

`param` is of `[String : Any]?` type.

You can add multiple listeners to different types of events but only one closure will be called for a specific event. If you add closure for the same event more than once, the last added closure will be called when the event gets triggered.

## Notice

Framework is delivered in a form of universal framework (so that it can be launched on a simulator as well as a device). Please keep in mind that before submitting to the AppStore you need to strip binaries from unnecessary architectures.

## License

This framework is using [FloatingPanel](https://github.com/SCENEE/FloatingPanel) library by Shin Yamamoto shin@scenee.com | @scenee

StonlySdk is available under the MIT license. See the LICENSE file for more info.
