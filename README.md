# DFU2020: Developed code for DFU2020 Competition

This repo let's you train a detector that can accurately localise Ulcers caused by diabetes on foot images. 
The backbone of our method is based on using the state-of-the-art YOLOv3 computer vision algorithm. 

### Pipeline Overview

To build and test the DFU detection algorithm follow the below steps:

 1. [Transfer](/Transfer/)
	 - Transfers the annotations to yolo format
 2. [Training](/Training/)
 	- Download pre-trained weights
 	- Train your custom YOLO model on annotated images 
 3. [Test](/Test/)
 	- Detect objects in new images and videos
	- Removing Bonding boxes with big overlap (optional)

## Repo structure
+ [`src`](/src/): Keras implementation of YOLOv3
+ [`Data_New`](/Data_New/): Input Data, Output Data, Model Weights and Results
+ [`Utils`](/Utils/): Utility scripts used by main scripts

### Requisites
The only hard requirement is a running version of python 3.6 or 3.7. To install python 3.7 go to 
- [python.org/downloads](https://www.python.org/downloads/release/python-376/) 

and follow the installation instructions. Note that this repo has only been tested with python 3.6 and python 3.7 thus it is recommened to use either `python3.6` or `python3.7`.

To speed up training, it is recommended to use a **GPU with CUDA** support. For example on [AWS](/2_Training/AWS/) you can use a `p2.xlarge` instance (Tesla K80 GPU with 12GB memory). Inference is very fast even on a CPU with approximately ~2 images per second. 


### Installation

#### 1a Setting up Virtual Environment [Linux or Mac]

Clone this repo with:
```
git clone https://github.com/azalya-green/DFU2020

```
Create Virtual **(Linux/Mac)** Environment:
```
python3 -m venv env
source env/bin/activate
```
Make sure that, from now on, you **run all commands from within your virtual environment**.

#### 1b Setting up Virtual Environment [Windows]
Use the [Github Desktop GUI](https://desktop.github.com/) to clone this repo to your local machine. Navigate to the `TrainYourOwnYOLO` project folder and open a power shell window by pressing **Shift + Right Click** and selecting `Open PowerShell window here` in the drop-down menu.

Create Virtual **(Windows)** Environment:

```
py -m venv env
.\env\Scripts\activate
```
Make sure that, from now on, you **run all commands from within your virtual environment**.

#### 2 Install Required Packages [Windows, Mac or Linux]
Install all required packages with:

```
pip install -r requirements.txt 
pip install tensorflow==1.15.2 
```
If this fails, you may have to upgrade your pip version first with `pip install pip --upgrade`. If your system has working CUDA drivers, it will use your GPU automatically for training and inference.

## Inference on previously trained Weights
To test the DFU2020 on test images located in [`Data_New/Source_Images/Test_Images`](/Data_New/Source_Images/Test_Images), first download the pre-trained weights from:
"https://drive.google.com/file/d/1ZwKEvn9vnqGc2HGcnWYKzDgBpMY15k7O/view?usp=sharing"
and add that to ['Data_New/Model_Weights'] folder, then run the `Test.py` script in the root folder with:

```
python Test.py
```

The outputs are saved in [`/Data_New/Source_Images/Test_Image_Detection_Results`](/Data_New/Source_Images/Test_Image_Detection_Results). This includes:
 - DFU pictures with bounding boxes around Ulcers with confidence scores and
 - [`Detection_Results.csv`](/Data_New/Source_Images/Test_Image_Detection_Results/Detection_Results.csv) file with file names and locations of bounding boxes.

 If you want to detect DFU in your own pictures, replace the DFU images in [`Data_New/Source_Images/Test_Images`](/Data_New/Source_Images/Test_Images) with your own images.
 
 Then you need to run correct_overlap.R to remove bonding boxes with large overlap, the proccess favors the bonding box with higher score.

## Full Start (Training and Inference)

To train your own custom YOLO object detector please follow the instructions detailed bellow:
- [`1_Image_Annotation`]
	Add all the training images into (./Data_New/VoTT/), then add the training labels groundtruth.csv file into
	(./Data_New/) folders
	Then, to convert .csv format to the YOLOv3 format run the conversion script:

	``` 
	R CMD BATCH --no-save convert_ground.R 
	python Convert_.py
	```
	The script generates two output files: [`data_train.txt`](/Data_New/Source_Images/Training_Images/vott-csv-export/data_train.txt) 	  located in the [`Data_New/Source_Images/Training_Images/vott-csv-export`](/Data_New/Source_Images/Training_Images/vott-csv-export) 	     folder and [`data_classes.txt`](/Data_New/Model_Weights/data_classes.txt) located in the 						[`/Data_New/Model_Weights`](/Data_New/Model_Weights/) folder. 

- [`2_Training`] 
	Using the training images located in [`Data_New/Source_Images/VoTT`](/Data_New/Source_Images/Training_Images) and the 	 		annotation file [`data_train.txt`](/Data_New/Source_Images/VoTT/vott-csv-export) which we have created in the [previous step] 
	we are now ready to train our YOLOv3 detector. 
	#### Download and Convert Pre-Trained Weights
	Before getting started download the pre-trained YOLOv3 weights and convert them to the keras format, these weights are originally 	  trained by AntonMu/TrainYourOwnYOLO:

	```
	python Download_and_Convert_YOLO_weights.py
	```
	To list available command line options run `python Download_and_Convert_YOLO_weights.py -h`.

	The weights are pre-trained on the [ImageNet 1000 dataset](http://image-net.org/challenges/LSVRC/2015/index) and thus work well 	for object detection tasks that are very similar to the types of images and objects in the ImageNet 1000 dataset.

	#### Train YOLOv3 Detector
	To start the training, run the training script :
	```
	python Train_YOLO_DUF.py 
	```
	The final weights are saved in [`Data_New/Model_weights`](/Data/Model_weights). To list available command line options run 
	`python Train_YOLO.py -h`.

- [`3_Inference`]
 	
	Please refer to the prvious section ['Inference on previously trained Weights']
	
**To make everything run smoothly it is highly recommended to keep the original folder structure of this repo!**

Each `*.py` script has various command line options that help tweak performance and change things such as input and output directories. All scripts are initialized with good default values that help accomplish all tasks as long as the original folder structure is preserved. To learn more about available command line options of a python script `<script_name.py>` run:

```
python <script_name.py> -h
```

## License

Unless explicitly stated otherwise at the top of a file, all code is licensed under the MIT license. This repo makes use of [**ilmonteux/logohunter**](https://github.com/ilmonteux/logohunter) which itself is inspired by [**qqwweee/keras-yolo3**](https://github.com/qqwweee/keras-yolo3).

## Acknowledgements

Part of this code is forked and modified from :
1) qqwweee/keras-yolo3
2) https://github.com/AntonMu


## Troubleshooting

0. If you encounter any error, please make sure you follow the instructions **exactly** (word by word). Once you are familiar with the code, you're welcome to modify it as needed but in order to minimize error, I encourage you to not deviate from the instructions above. If you would like to file an issue, please use the provided template and make sure to fill out all fields. 

1. If you encounter a `FileNotFoundError` or a `Module not found` error, make sure that you did not change the folder structure. In particular, your  working directory needs to look like this: 
    ```
    TrainYourOwnYOLO
    └─── 1_Image_Annotation
    └─── 2_Training
    └─── 3_Inference
    └─── Data
    └─── Utils
    ```
    If you want to use a different folder layout (not recommended) you will have to specify your paths as command line arguments. Also, try to avoid spaces in folder names, i.e. don't use a folder name like this `my folder` but instead use `my_folder`.

2. If you are using [pipenv](https://github.com/pypa/pipenv) and are having trouble running `python3 -m venv env`, try:
    ```
    pipenv shell
    ```

3. If you are having trouble getting cv2 to run, try:

    ```
    apt-get update
    apt-get install -y libsm6 libxext6 libxrender-dev
    pip install opencv-python
    ```

4. If you are a Linux user and having trouble installing `*.snap` package files try:
    ```
    snap install --dangerous vott-2.1.0-linux.snap
    ```
    See [Snap Tutorial](https://tutorials.ubuntu.com/tutorial/advanced-snap-usage#2) for more information.

 




