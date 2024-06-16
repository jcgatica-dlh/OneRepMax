# FitBod One Rep Max and Charts Coding Assessment
by Juan C Gatica

## Build Notes
Please note that this app pulls in the Swift Algorithms package using the Swift Package
Manager, which is used in chunking the workout data by day (when displaying the chart)

## Run Notes
To actually run, you can either have text files already present on the device's Downloads
folder, or you can drag a file onto the simulator.  Please note that if the application is
already installed, the file will automatically be opened by the app.  To test the file
browser, it looks like you have to make sure to uninstall the application before dragging
files onto the simulator.

This application displays a welcome screen with a single button, which brings up
a file browser.  As long as a text file with a .txt extension is present on the
device, it should be able to open that file.

If the file is unreadable for any reason, an alert dialog should mention that it's unable
to read it.  If the file is readable, it groups the raw workout data by name, and pushes to
the exercise list view onto the navigation stack.  The exercise list shows the exercise
name and the largest One Rep Max value for that exercise, computed using the Brzycki Formula.

Tapping on one of the rows pushes the exercise details for the given exercise name.
showing exactly the same UI shown on the table row on the previous screen, but also a
graph of the One Rep Max data.  Given that the raw data contains multiple attempts
of the exercise on a day, the application only draws the largest One Rep Max attempt
for that day, as an attempt to clean up the graph.

Also, although the design mock shows "Month/Day" and "Day" labels on the X axis, if the workout
data spans more than three months, the X axis labels will be "Year/Month" and "Month".
If the data spans less than 3 months, the labels remain at "Month/Day" and "Day".
