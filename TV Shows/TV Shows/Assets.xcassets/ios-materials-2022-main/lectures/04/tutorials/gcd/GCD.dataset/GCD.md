# GCD - Grand Central Dispatch
- abstraction over threads

# iOS
- as noted above, you don't work with raw threads, there is layer of abstraction on top of it, called queue, you manipulate it with API called GCD

- UI thread or **main thread** is a serial queue
    - events are executed in order in which they arrived
    - long running events will block other events, which in turn will freez and or block UI
    - you never want to block UI
    - for that reason, all long running events should be dispatched on background thread

- Background thread
    - used for long running operations
    - can have various priority
    - can be serial or concurrent

- API calls should be executed on the background thread
- UI calls should be executed on the main thread

```swift
AF.request {

    // Maybe background thread
    // Can be verified with Thread.isMain
    // Or you can see it when you add breakpoint to it

    // Use this to transfer code execution to main thread
    DispatchQueue.main.async {
        view.reloadData()
    }

}
```
More info can be found here:
`https://www.raywenderlich.com/5370-grand-central-dispatch-tutorial-for-swift-4-part-1-2`
