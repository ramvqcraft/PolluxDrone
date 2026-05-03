import csv
import FreeCAD

doc = FreeCAD.open("C:\\Users\\RamVQ\\Documents\\Pollux\\PolluxDrone\\Modeling\\_temp.Humanoid.FCStd")

labels = ["Human","Torso", "Head", "RA", "LA", "RL", "LL"]
threshold = 10.0  # degrees

def angles_changed(last, current, threshold):
    """Return True if any angle differs by more than threshold."""
    for i in range(len(last)):
        if isinstance(current[i], (int, float)) and isinstance(last[i], (int, float)):
            if abs(current[i] - last[i]) > threshold:
                return True
    return False

with open("AnglesOutput.csv", "w", newline="") as f:
    writer = csv.writer(f)
    header = ["step"]
    for label in labels:
        header += [f"{label}X", f"{label}Y", f"{label}Z"]
    writer.writerow(header)

    last_angles = None

    for step in range(10):  # replace with however many steps you want
        row = [step]
        current_angles = []
        for label in labels:
            obj = next((o for o in doc.Objects if o.Label == label), None)
            if obj:
                euler = obj.Placement.Rotation.toEuler()
                current_angles += [euler[0], euler[1], euler[2]]
            else:
                current_angles += ["", "", ""]
        # Only save if threshold is met
        if last_angles is None or angles_changed(last_angles, current_angles, threshold):
            row += current_angles
            writer.writerow(row)
            last_angles = current_angles

App.closeDocument(doc.Name)
