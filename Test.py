import os
import subprocess
import time
import sys


def make_call_string(arglist):
    result_string = ""
    for arg in arglist:
        result_string += "".join(["--", arg[0], " ", arg[1], " "])
    return result_string


root_folder = os.path.dirname(os.path.abspath(__file__))
data_folder = os.path.join(root_folder, "Data_New")
model_folder = os.path.join(data_folder, "Model_Weights")
image_folder = os.path.join(data_folder, "Source_Images")
input_folder = os.path.join(image_folder, "Test_Images")
output_folder = os.path.join(image_folder, "Test_Image_Detection_Results")


if not os.path.exists(output_folder):
    os.mkdir(output_folder)

# Now run the DFU detector
detector_script = os.path.join(
    os.path.dirname(os.path.abspath(__file__)), "Detect_.py"
)


result_file = os.path.join(output_folder, "Detection_Results.csv")
model_weights = os.path.join(model_folder, "trained_weights_final.h5")
classes_file = os.path.join(model_folder, "data_classes.txt")
anchors = os.path.join(
    root_folder, "src", "keras_yolo3", "model_data", "yolo_anchors.txt"
)

arglist = [
    ["input_path", input_folder],
    ["classes", classes_file],
    ["output", output_folder],
    ["yolo_model", model_weights],
    ["box_file", result_file],
    ["anchors", anchors],
    ["file_types", ".jpg .jpeg .png"],
]
call_string = " ".join(["python", detector_script, make_call_string(arglist)])

print("Detecting DFU by calling: \n\n", call_string, "\n")
start = time.time()
subprocess.call(call_string, shell=True)
end = time.time()
print("Detected DFU in {0:.1f} seconds".format(end - start))
