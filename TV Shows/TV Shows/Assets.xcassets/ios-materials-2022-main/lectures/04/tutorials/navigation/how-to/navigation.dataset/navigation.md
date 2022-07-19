# Navigation in iOS

## Intro
- `UINavigationController`
    - subclass of `UIViewController`
    - basically just a view controller with array that is holding current navigation stack (view controllers)

## Types of navigation
- `Push` && `Present`

### PUSH
- **drill down**, you push on something
>
    ViewControllerA
        -> ViewControllerB
            -> ViewControllerC

- in order to push something, you need to have your view controller subclass wrapped up inside `UINavigationController`
- you will get `back button` for free, which means you can go back and unwind the navigation stack

### PRESENT
- **present**, you present on top of something
>
    ViewControllerC
        ^
        |
    ViewControllerB
        ^
        |
    ViewControllerA

- you will need to implement your own way of going back
- if you plan to **push** from that screen, you would also need to wrap it up inside `UINavigationController`

## Embedding view controller in navigation controller

Embed first view controller on navigation stack in **navigation controller**. This will be our root view controller on stack (for example, Login in home assignment)

![alt](embed.png)

Next step would be setting newly created navigation controller as **initial view controller**. Otherwise our app would start from previous screen, without having reference to navigation controller. **UINavigationController** is just a special subclass of a **UIViewController** which displays a stack of view controllers in a specific manner.

![alt](initial_vc.png)

## How to do navigation?

- `Storyboard` via `Seques`
- from code

### Storyboard and Seques
- `CTRL` + `Right Click` + dragg from target to the destination view controller -> `Show`
    - ![alt](navigation_drop_down_menu.png)
        - you can choose **push** (on menu above Show) or **present** (Present Modally)
    - ![alt](navigation_segue.png)
- you can tap and select the `Segue` and then on the right hand side, you can inspect it
    - ![alt](navigation_segue_inspection.png)

### Code - preferred way
- in order for us to navigate using code we need following

```swift
    // We need to instantiate the Storyboard in which our view controller that we want to go to lives
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    // We need to instantiate the view controller that we want to go to
    let viewControllerD = storyboard.instantiateViewController(withIdentifier: "ViewController_D")
    
    // We need to push that view controller on top of the navigation stack
    navigationController?.pushViewController(viewControllerD, animated: true)
```

- most important part is that if we are navigating to the view controller from `Storyboard` we need to instantiate it from `Storyboard`.
    - in order for us to do that using code above, we need to assign each view controller some sort of identifier
        - in above case `ViewController_D` ![alt](navigation_view_controller_identifier.png)
