# F.I.R.E.SAT

### Building a 3U CubeSat to combat the spread of wildfires.

## TL;DR
F.I.R.E.SAT (Fire Intervention Rescue Expedition Satellite) is a student-led CubeSat concept designed to monitor and detect wildfires from low Earth orbit. This project adds detailed CAD Modelling in Autodesk Inventor with intense FEA Testing in Ansys to create a flight-ready satellite chassis. Additionally, a CNN was retrained in MATLAB to detect fires from an augmented dataset of terrestrial fires and achieved ~94% accuracy, which was then implemented into a pipeline created in Simulink to simulate downlinking logic from orbit. More details on F.I.R.E.SAT can be found below or in the various branches of this repo. Thank you for visiting!  

## Table of Contents
- [Introduction](#Introduction)
- [Motivation and Objective](#Motivation-and-Objective)
- [CAD Modelling](#CAD-Modelling)
- [FEA Testing](#FEA-Testing)
- [CNN Retraining](#CNN-Retraining)
- [Simulink Pipeline](#Simulink-Pipeline)
- [How to View/Use Files](#How-to-View-/-Use-Files)
- [Acknowledgements](#Acknowledgements)
- [Concluding Details](#Concluding-Details)
- [References](#References)

## Introduction
F.I.R.E.SAT (Fire Intervention Rescue Expedition Satellite) is a self-conducted project where I designed a 3U (10 cm x 10 cm x 30 cm) CubeSat that can withstand launch and low Earth orbit conditions, all while using a Convolutional Neural Network (CNN), retrained using augmented terrestrial pictures to detect fire signatures and downlink them using a Simulink pipeline. If this project were to be made and launched, the total cost to build, develop, and launch F.I.R.E.SAT would be about $400,000 USD, which is certainly not pocket money. However, feel free to explore this repo to learn more about F.I.R.E.SAT!

![F.I.R.E.SAT Exploded View](https://github.com/KiranSuresh612/F.I.R.E.SAT-CubeSat-Project/blob/cfb4e0ef8275dba22b265b11921efdde663f630b/F.I.R.E.SAT%20Exploded%20View%20Video%20(Final%20GIF).gif)

## Motivation and Objective
Wildfires are a growing threat to ecosystems around the world, especially in Canada, with severe cases across the country. Current wildfire detection satellites cannot both rapidly detect and capture fine-resolution imagery to detect wildfires. The payload is a FLIR BOSON+ 640 Infrared Camera, which will perform better than most wildfire detection satellites today since infrared cameras perform better than regular cameras when the CubeSat is in Earth's shadow. Though F.I.R.E.SAT may not solve all the listed problems with modern satellites, I want it to be a mission-ready concept that, with more resources and development, may become a flight-ready mission that improves our wildfire detection and prevention capabilities. All concept sketches and art are under the "preliminary-sketches" branch.

### CAD Modelling
The CAD model was developed in Autodesk Inventor using various industry-sourced components and several self-developed parts. The CubeSat model has the dimensions 9.8 cm x 9.8 cm x 30 cm and is 1:1 in scale. I did not make the side lengths 10 cm, as I wanted about 0.2 cm as clearance for the CubeSat launcher's deployer rails. To make my CAD model as accurate as possible, I got CAD models from the vendors themselves. These components are: (NanoMind A3200), Power System (NanoPower P60), Comms (NanoCom AX100), Docking System (NanoDock DMC-3), GPS Kit (NanoSense NovAtel OEM-719), Thermal Camera (FLIR BOSON+ 640 with a 73mm lens), Star Trackers (AAC Hyperion ST200), Sun Sensors (AAC Hyperion SS200), Battery (AAC Clyde Space Optimus 30-Watt Battery). I created several parts as well, such as most of the Attitude Determination and Control System or ADCS (controls the orientation of the satellite in space) shown below, the Antennae Deployer, all Mainframe parts, Protective Germanium Lens (to shield the thermal sensor from space), and Solar Cells. 

![Labelled Diagram of the ADCS](https://github.com/KiranSuresh612/F.I.R.E.SAT-CubeSat-Project/blob/9b32aa0dada37bc581c20ed287b66366abdaa5f9/Labelled%20ADCS.png)

By gathering CAD models of flight-proven components from vendors, I was able to devote more time to the structure/mainframe of F.I.R.E.SAT to make it more rigid and stable. The system layout is one aspect I am very proud of, as they are placed in such a manner that their respective abilities are optimized. For example, the battery is placed farthest from the thermal sensor and ADCS to prevent the heat from those components from reaching the battery, since the battery requires a strict temperature range between 30 and 50 degrees Celsius. Another example would be the placement of the ADCS system, as it is placed close to the satellite's center of mass, allowing for better attitude control. 

I often wanted to add several components to F.I.R.E.SAT, but had to hold myself back because it would not fit within my mainframe design. The CAD model allowed me to explore my vision for F.I.R.E.SAT and helped establish trade-offs between functionality and factors like weight and volume.

![Labelled Diagram of F.I.R.E.SAT](https://github.com/KiranSuresh612/F.I.R.E.SAT-CubeSat-Project/blob/fe3751d426fa1ecd6f2429fbabb1b5e104a1eb7d/Labelled%20Diagram.png)

### FEA Testing
To test if the satellite would survive under launch and orbital conditions, Finite Element Analysis (FEA) was conducted on the model. FEA is the process of breaking complex structures into tiny parts called finite elements and then applying specific conditions to those elements to test how the entire structure behaves. I assigned Aluminum 6061-T6 to be the material for my CubeSat mainframe and exterior because it is commonly used in satellite structures, and then conducted three tests: Deformation, Modal Frequency, and Transient Thermal. The Deformation and Modal Frequency tests were specifically designed to mimic launch conditions (i.e. when the satellite is brought up to space in a rocket). The tests were only done on the exterior walls and mainframe, since having the interior components built would create an unstable mesh, which couldn't be properly tested.  

In the Deformation tests, I installed a fixed support only to the bottom plate and applied 10Gs of force onto the entire structure from the X, Y, and Z axes to ensure the satellite would survive in all orientations. From the tests, the plate holding the battery faced the most deformation, which was not a lot either (~8.44e-6 m). To calculate the strain on the thinnest part of the plate (0.2 cm), we use the formula: deformation/length => 8.44e-6/0.002 => 4.22e-3%. This strain is well within the elastic limit for Aluminum 6061-T6, so it is negligible.

![Deformation X-Axis](https://github.com/KiranSuresh612/F.I.R.E.SAT-CubeSat-Project/blob/f8e1473a0fdbe9c96f02f900fe5acb25c7d69a45/Deformation%20(X-Axis).png)

In the Modal Frequency (Max Vibration before the structure collapses) test, it was found that the max modal frequency of F.I.R.E.SAT's exterior and mainframe was about 655 Hz, which is well above the minimum 100 Hz requirement imposed by launch operators such as SpaceX. Even if I added the internal components, the modal frequency might drop to around 300 Hz (being harsh), which is still above the minimum frequency.

![Modal Frequency](https://github.com/KiranSuresh612/F.I.R.E.SAT-CubeSat-Project/blob/f8e1473a0fdbe9c96f02f900fe5acb25c7d69a45/Modal%20Frequency%20Test%20Result.png)
NOTE: The model in the picture is distorted as it shows how the components WANT to move when subjected to force, but ACTUALLY will not. 

In the Transient Thermal (how temperature affects a body over time) test, I checked if the satellite would remain in its Goldilocks zone of 30-50 degrees Celsius during its 90-minute orbit around Earth. In its orbit, F.I.R.E.SAT would spend 45 minutes in sunlight and 45 minutes in shadow, so it would need to withstand a maximum temperature of 260 degrees Celsius and a minimum temperature of -100 degrees Celsius. The test showed temperatures between ~21 and 45 degrees Celsius on the exterior and 26 to 44 degrees Celsius inside the satellite. I also calculated the minimum radiator area using the Stefan-Boltzmann Law, finding that an area of at least 194 cm^2 needs to be dedicated to radiators to dissipate 9.5 W, the average power usage. I decided to allocate 277 cm^2 of radiator area, providing a 70% safety margin so the radiators can dissipate up to 13.5 W during peak operation (i.e. when everything inside the satellite, including heaters, is running). Below is a GIF of the Transient Thermal test running:

![Transient Thermal GIF](https://github.com/KiranSuresh612/F.I.R.E.SAT-CubeSat-Project/blob/4cc3310f679b087f6d5bbb8ed4168484ff53ca37/Transient%20Thermal%20Animation%20GIF.gif)

More Test Results can be viewed in the "fea-analysis" branch!

### CNN Retraining
I retrained the pre-existing Convolutional Neural Network (CNN), SqueezeNet, to detect fire signatures using a dataset containing terrestrial fire images in .png format compiled by a team of researchers at Mendeley Data (citation in References) in MATLAB. SqueezeNet was chosen due to its low hardware requirements, which is a constant constraint in CubeSats such as F.I.R.E.SAT. The training set consisted of two folders, each containing thousands of pictures of either fires or no fires. These pictures were augmented to challenge the CNN and reduce the chances of the CNN memorizing the images instead of learning to differentiate between the two classes. These augmentations consisted of resizing, random rotations, and translations, which greatly helped the CNN generalize (i.e. make it adaptable so it can detect fires in any set of pictures instead of just the training set). 

During training, a set of images was fed alongside the training set, called the validation set, to see if the CNN was memorizing images and measure its learning after each epoch (i.e. each loop of the training set). After training, the model was tested on classifying a brand new set of images called the testing dataset, where the retrained model achieved an accuracy of ~94%! Though this is a great result, a part of me wishes I were able to use .HDF files containing thermal imagery from real satellite data to retrain the CNN, which would make it very close to being mission-ready. However, I am still proud of my progress and am very glad I took on this challenge to learn more about AI applications in wildfire detection. Below are the training progress graphs and the confusion matrix, which organizes the predictions of the CNN during testing.

![Training and Validation Graphs](https://github.com/KiranSuresh612/F.I.R.E.SAT-CubeSat-Project/blob/1c3b485fed3a6990a82ccc0be8e04153f3ffe5f0/Training%20and%20Validation%20Graphs.png)

![Confusion Matrix](https://github.com/KiranSuresh612/F.I.R.E.SAT-CubeSat-Project/blob/1c3b485fed3a6990a82ccc0be8e04153f3ffe5f0/Confusion%20Matrix.png)

### Simulink Pipeline
The pipeline created in Simulink was made to complement the retrained CNN by simulating how F.I.R.E.SAT handles wildfire imaging and processing in orbit, with the only constraint in this simulation being a limited battery power. The process starts with an image being captured and preprocessed for image classification by the CNN. After classification, the CNN outputs the prediction on whether the image contains a fire or not and a percentage to show how confident it is in its prediction. The prediction enters a stateflow chart meant to be a downlink logic box with three states: Idle, ReadyToTransmit, and LowBattery. The prediction is passed through (i.e. approved for being sent down to Earth) if and only if a fire has been detected and there is sufficient charge in the battery. This measure is to reduce the volume of data sent down to Earth and automate the process of pinpointing the locations of fires. 

The battery factor was included to simulate how the satellite downlinking logic should react at different battery levels to either send data of detected fires immediately or send the last reading, then enter Safe Mode to preserve the satellite for future use instead of entirely using it up and potentially missing fires along the line. One thing I wanted to figure out was how to feed a folder of images instead of one image at a time to test the downlink logic under more realistic circumstances.

![Simulink Pipeline Picture](https://github.com/KiranSuresh612/F.I.R.E.SAT-CubeSat-Project/blob/542c342aecb6dbfcaf5b9e63448345007e6e9592/Simulink%20Model%20Picture.png)

## How to View/Use Files

If you would like to go through my work on F.I.R.E.SAT, feel free to do so via the various branches of this repo. If you are having trouble, please take a look at the instructions below.

CAD Model: 
Go to the "cad-files" branch, download the file named "F.I.R.E.SAT Mk.2 (Final Design).iam" and open with a CAD-friendly software like SolidWorks, Autodesk Inventor, etc (preferably Autodesk Inventor).

NOTE: I used Autodesk Inventor 2025, so I cannot guarantee that the file will open at the time of download.

FEA Workflow: 
Go to the "fea-analysis" branch, download the file named "FEA Model.wbpj" and open it with Ansys Workbench. The workflow and the used model are already in the workbench file! 

NOTE: I used Ansys Workbench/Mechanical 2025 R2 (Student Version), so I don't know if the Workbench file will behave the same for you when you download it.

CNN Retraining: 
Download the dataset by following the link in the References section and extract all the files. Please note that you will be using the folders in the Classification folder. Then, go to the "wildfire-classifier-cnn-files" branch, download the file named "Training Script.m" and open it in MATLAB. Fill in the sections listed in the code and finally run. Make sure all the files you download and use are in the same folder. It will take a varying amount of time to train (depends on your specs) and then test, but after that, you will have your very own retrained wildfire detection CNN. 

NOTE: I used MATLAB R2025a, so I do not know if the syntax or script will still work at the time of download. I also had to download the Deep Learning Toolbox and the Statistics and Machine Learning Toolbox (not 100% sure if needed by install just in case) using the Add-On explorer. 

Simulink Pipeline: 
Go to the "simulink-model-files" branch, download the files named "simulink_OBC_Diagram.slx" and "simulink_OBC_Diagram.slxc" and save them to the same folder. Then, transfer a copy of your retrained CNN from the folder you used for MATLAB (previous activity) to your newly made folder. Also, be sure to have a folder containing a few images from the dataset mentioned previously (fire and no fire samples) in the same primary folder. Then insert the file path of a sample of your choosing into the field given by double-clicking the Image Input box (farthest left). Then hit Run to see the results on the displays to the far right of the model. Be sure to test with both types of samples and by tweaking the battery level (small white box with 100) to a number between 1 and 100 of your choosing while also being to enter the same number in the "Initial Condition" field in the other small white box to the right of the battery box (denoted with a 1/z). 

NOTE: I used Simulink R2025a, so I cannot confirm if my model still works at the time of download. I also downloaded Stateflow, Computer Vision Toolbox, and Image Processing Toolbox, so you may need to as well if the model does not run properly. 

## Acknowledgements
I want to extend a deep appreciation to GomSpace, TELEDYNE, and AAC Clyde Space for allowing me to use their CAD files for their company's components in my project. It made the design process infinitely easier with their help. This project is not to be used for commercial purposes unless permission is gained from all three entities.

To gain the skills necessary to work on the tasks I wanted to in this project, I often used MathWorks courses such as Deep Learning Onramp and Stateflow Onramp. If you have access to them, they are extremely useful and also provide a digital certificate.

Software Used: Autodesk Inventor 2025, Ansys Workbench/Mechanical 2025 R2 (Student Version), MATLAB R2025a, Simulink R2025a

## Concluding Details

You made it to the end of the README file! Congratulations! Or you could have skipped down here; either way, thank you for taking the time to look through the project that took two months of pure dedication and grit! If you would like to work together on improving F.I.R.E.SAT or want to contact me for other purposes, please do so with the contact details listed on my profile. Thank you, and have a great day!

## References

Database Citation: Ibn Jafar, Anam; Islam, Al Mohimanul ; Binta Masud, Fatiha; Ullah, Jeath Rahmat; Ahmed, Md. Rayhan (2023), “FlameVision : A new dataset for wildfire classification and detection using aerial imagery ”, Mendeley Data, V4, doi: 10.17632/fgvscdjsmt.4 (Link: https://data.mendeley.com/datasets/fgvscdjsmt/4)

NASA's CubeSAT 101: Basic Concepts and Processes for First-Time CubeSat Developers NASA CubeSat Launch Initiative. (n.d.). https://www.nasa.gov/wp-content/uploads/2017/03/nasa_csli_cubesat_101_508.pdf?emrc=05d3e2

Youtube Videos: The Efficient Engineer. (2024, May 21). How to Build a Satellite. YouTube. https://www.youtube.com/watch?v=5voQfQOTem8

Mark Rober. (2024, November 29). My New Satellite Can Take Your Selfie From Space. YouTube. https://www.youtube.com/watch?v=6KcV1C1Ui5s‌

‌


