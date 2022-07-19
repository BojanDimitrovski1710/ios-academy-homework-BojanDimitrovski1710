# Interface Builder

## Key takeways

- `Main.storyboard` should have entry point, arrow on the left side of view controller UI component
    - if you expirience black screen that could be one of the reasons
    - also read the console log, usually above the stack trace in case of the crash you will have the name of the error

- Each `UIViewController` in **Storyboards** that you want to modify from code has to have its custom subclass
    - You need to set this subclass from Storyboards
    - You can set this when you select your `UIViewController` in Storyboards
        - View -> Inspectors -> Show identity inspector

- Each `UIView` component in **Storyboards** that you want to modify from code has to have its reference
    - This reference is marked by keyword `@IBOutlet`
    - You can create this by opening and selecting your `UIView` component in **Storyboards** and then opening Assistant Editor (ring like icons)
        - Then you CTRL + Right Touchpad/Mouse click and drag to your code, somewhere inside the `UIViewController` subclass but not inside the functions
        - This should create `@IBOutlet`
        - When you select your `UIView` component, you can inspect its connections (You can use this for both `@IBOutlet` and `IBAction`)
            - View -> Inspectors -> Show Connections Inspector
            - **Referencing Outlets**

- Each `UIView` component in **Storyboards** from which you wish to receive events (e.g. Java -> btn.click, C# -> btn.click += lambda) has to have is events action
    - This reference is marked by keyword `@IBAction`
    - You can create this by opening and selecting your `UIView` component in **Storyboards** and then opening Assistant Editor (ring like icons)
        - Then you CTRL + Right Touchpad/Mouse click and drag to your code, somewhere inside the `UIViewController` subclass but not inside the functions
        - This should create `@IBAction`
        - When you select your `UIView` component, you can inspect its connections (You can use this for both `@IBOutlet` and `IBAction`)
            - View -> Inspectors -> Show Connections Inspector
            - **Send Events**

- Each `UIViewController` is backed by `UIView`
    - You use its view to add other UI components
    - You use its view to change its background color

# ARC
- iOS uses ARC - Automatic reference counting
    - **strong** by default
    - **weak** when you need to break retain cycle
        - usually when you have PARENT <-> CHILD
        - usually when you use closures

