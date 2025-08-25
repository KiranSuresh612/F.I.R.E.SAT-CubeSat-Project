# F.I.R.E.SAT

### Building a 3U CubeSat to actively combat the spread of wildfires.

## Introduction
F.I.R.E.SAT (Fire Intervention Rescue Expedition Satellite) is a self-conducted project where I designed a 3U (10 cm x 10 cm x 30 cm) CubeSat that can withstand launch and low Earth orbit conditions, all while using a Convolutional Neural Network (CNN), retrained using augmented terrestrial pictures to detect fire signatures and downlink them using a Simulink pipeline. Feel free to explore this repo to learn more about F.I.R.E.SAT!

![F.I.R.E.SAT Exploded View](https://github.com/KiranSuresh612/F.I.R.E.SAT-CubeSat-Project/blob/cfb4e0ef8275dba22b265b11921efdde663f630b/F.I.R.E.SAT%20Exploded%20View%20Video%20(Final%20GIF).gif)

## Motivation and Objective
Wildfires are a growing threat to ecosystems around the world, especially in Canada. Current wildfire detection satellites cannot both rapidly detect and capture fine-resolution imagery to detect wildfires. F.I.R.E.SAT does not claim to fix these issues, but instead provides an idea of how a student-founded CubeSat concept could integrate AI to support wildfire monitoring and detection. 

The goal for this project was to design a flight-ready 3U nanosatellite concept that can detect and downlink warnings about small wildfire hotspots while in Low Earth Orbit (LEO). All components, functions, and code have to be suitable for a nanosatellite in space. A proof-of-concept for the AI-powered wildfire detection pipeline should also be developed.  

## Table of Contents

### CAD Modelling
The CAD model was developed in Autodesk Inventor using various industry-sourced components and several self-developed parts. The CubeSat model has the dimensions 9.8 cm x 9.8 cm x 30 cm and is 1:1 in scale. I did not make the side lengths 10 cm, as I wanted about 0.2 cm as clearance for the CubeSat launcher's deployer rails. To make my CAD model as accurate as possible, I got CAD models from the vendors themselves. These components are: (NanoMind A3200), Power System (NanoPower P60), Comms (NanoCom AX100), Docking System (NanoDock DMC-3), GPS Kit (NanoSense NovAtel OEM-719), Thermal Camera (FLIR BOSON+ 640 with a 73mm lens), Star Trackers (AAC Hyperion ST200), Sun Sensors (AAC Hyperion SS200), Battery (AAC Clyde Space Optimus 30-Watt Battery). I created several parts as well, such as most of the Attitude Determination and Control System (ADCS), Antennae Deployer, all Mainframe parts, Protective Germanium Lens (to shield the thermal sensor from space), and Solar Cells. 

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
I retrained the pre-existing Convolutional Neural Network, SqueezeNet
### Simulink Pipeline

## How to View/Use Files

## Acknowledgements

## Contact Details

## References
