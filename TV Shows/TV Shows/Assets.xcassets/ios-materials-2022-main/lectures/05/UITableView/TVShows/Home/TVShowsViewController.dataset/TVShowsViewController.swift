//
//  ViewController.swift
//  TVShows
//

import UIKit

struct TVShowItem {
    let name: String
    let image: UIImage?
}

// IMPORTANT: https://www.raywenderlich.com/8549-self-sizing-table-view-cells

final class TVShowsViewController: UIViewController {

    // MARK: - Private UI
    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Priavate
    private let items = [
        TVShowItem(name: "Fringe", image: nil),
        TVShowItem(name: "Dexter", image: nil),
        TVShowItem(name: "The X-Files", image: nil),
        TVShowItem(name: "The Office", image: nil),
        TVShowItem(name: "Fringe", image: nil),
        TVShowItem(name: "Dexter", image: nil),
        TVShowItem(name: "The X-Files", image: nil),
        TVShowItem(name: "The Office", image: nil)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

}

// MARK: - UITableView

// NOTE: - This functions will be called automatically during the initial setup of table view.
//         So this will work out of the box with mock data.
//         As your assignment will be to display data you get back from API, you will need to call `tableView.reloadData()` once your API is finished and you
//         added new data to the array.

extension TVShowsViewController: UITableViewDelegate {
    // Delegate UI events, open up `UITableViewDelegate` and explore :)

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = items[indexPath.row]
        print("Selected Item: \(item)")
    }
}

extension TVShowsViewController: UITableViewDataSource {

    // MARK: - UITableViewDataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        // Default implementation - if not implemented would return 1 as well
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // We need to tell the table view, how many rows we have in each section,
        // because we only have one section now, we can just return our items count.
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        print("CURRENT INDEX PATH BEING CONFIGURED: \(indexPath)")

        // We need to dequeue the instance of `UITableViewCell`
        // What does that even mean right??
        // Well in order for our scrolling TVShows to perform smoothly,
        // OS will try and reuse table view cells to achieve 60 FPS while scrolling

        // How will it achieve that?
        // Well once the cell goes off screen, it will be prepared for reuse for
        // the next data set (next TVShowItem)
        // This will keep memory in check.

        // If we are using Storyboards or XIBs to create table view cells
        // we need to use some sort of identifier, so that the system later
        // on knows which cell to reuse

        // Identifier should be setup inside the interface builder, rule of
        // thumb is to set it to be named as the subclass that we use
        // When you select your UITableViewCell in IB, yo can go to the
        // Attributes Inspector (fifth icon in the right menu) and there you can
        // setup the Identifier.

        // For that reason, we don't need to use String which is error prone
        // but we can use class name and convert it to String

        let cell = tableView.dequeueReusableCell(
            withIdentifier: String(describing: TVShowTableViewCell.self),
            for: indexPath
        ) as! TVShowTableViewCell

        // Once we get a reference to UITableViewCell, more specifically our special
        // subclass, we want to configure it with our data
        // As we have already learned to not leak implementation details, in this case
        // that would mean our label and image, we need to pass in the data
        // With this in place, adhere to Encapsulation principle of object oriented programming
        // Yes sure we can improve this further by using a protocol, but for now we will settle on this approach

        cell.configure(with: items[indexPath.row])

        // After our special cell is configured, we just return it so that it can be displayed

        return cell
    }
}

// MARK: - Private

private extension TVShowsViewController {

    func setupTableView() {
        // For now we are using automatic height, that means that the table view
        // cell will try to callculate its own size
        // For the system to knows that we plan to do that, we need to specifiy some estimated row height
        tableView.estimatedRowHeight = 110
        tableView.rowHeight = UITableView.automaticDimension

        // Little trick to remove empty table view cells from the screen, play with removing it.
        tableView.tableFooterView = UIView()

        // Setup delegate and data source
        // Both of these are using delegate pattern
        // One "delegate" is for providing data
        // One "delegate" is for providing responses to various UI events, like row tap ...
        // You can set those two in the interface builder as well
        tableView.delegate = self
        tableView.dataSource = self
    }
}

