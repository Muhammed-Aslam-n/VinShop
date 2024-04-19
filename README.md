# VinShop

A Brand new flutter app for purchasing the best products.

## Overview

A simple application to purchase products based on the details and reviews.
Users needs to login with their valid credentials like Email and Password.

## Installation

You can directly take the application by running the command flutter build apk android-arm,android-arm64,android-x64 -- split-per-abi
.apk file will be generated and can be easily installed.


**If you're getting error while running in iOS, Add the GoogleService-info.plist again from XCode. Since I don not possess one, I couldn't test it properly.**

## Getting Started

Below are the packages and uses of theirs:
    flutter_animate: Version 4.5.0 - Provides animations for various UI elements, adding dynamic visual effects to the app.
    flutter_spinkit: Version 5.2.0 - Offers a collection of beautiful loading indicators or spinners to indicate ongoing background processes.
    provider: State management library for Flutter applications, enabling efficient and scalable management of application state.
    shared_preferences: Allows storing key-value pairs locally on the device for persisting user preferences and settings.
    go_router: Version 13.2.0 - A flexible and powerful routing library for Flutter applications, enabling navigation management with ease.
    google_fonts: Version 6.1.0 - Provides easy access to a vast collection of open-source fonts from Google Fonts for styling text in the app.
    iconly: Version 1.0.1 - Offers a comprehensive set of customizable icons to enhance the visual appeal and usability of the app.
    icons_plus: Version 5.0.0 - A package providing additional icon assets to complement the default Flutter icon set, expanding design options.
    firebase_auth: Integrates Firebase Authentication into the app, enabling secure and seamless user authentication using Firebase services.
    dio: Version 5.4.0 - A powerful HTTP client for Dart that simplifies making network requests and handling responses efficiently.
    path_provider: Version 2.1.1 - Provides a platform-agnostic way to access the filesystem path for storing and retrieving files on the device.
    connectivity_plus: Version 5.0.2 - Offers enhanced connectivity detection capabilities, allowing the app to respond intelligently to network changes.
    flutter_typeahead: Version 5.2.0 - Implements a typeahead (autocomplete) widget for Flutter, enabling predictive text input and search functionality.

## Features

    Login to begin with user credentials
    Home screen listing all the products with an Search option to find specific product
    About section to get to know application
    Invite Friends option to increase publicity of application
    Logout for logging out of the current session

## Folder Architecture

Animation folder : Contains animation widget such as FadeInSlide animation widget used in the project. duration and direction can be altered to tailor the experience.

App folder: 
    - Contains router folder with router configuration done using go_router package.
    - Theme for theme configuration of application
    - app_assets: contains paths to the assets currently in use
    - app_const: contains integration values of providers like firebase

features:
    - About App : About section view of app
    - auth: Model,Views and controllers associated with auth features such as sign-in, sign-up etc.
    - home: Model,Views and controllers associated with home screen feature
    - invite_friends: Model,Views and controllers associated with invite friend feature
    - launch: Model,Views and controllers associated with launcher feature

services:
    - connectivity_service: Provides real time status of application connectivity to the internet

utils:
    - logger: To Log efficiently and evidently
    - popups: Custom widget for showing simple popup
    - validators_and_extensions: Contains validations for FormFields and extension.

widgets:
    - app_bar: Common app bar for application
    - loading_overlay: Overlay widget to denote on going tasks or operations
    - status_widgets: Widgets for app statuses like NoDataFound, UnexpectedErrorOccurred, NoNetworkFound, etc.