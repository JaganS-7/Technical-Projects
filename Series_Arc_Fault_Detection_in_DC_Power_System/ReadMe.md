
# Series Arc Fault Detection in DC Power Systems and Electric Vehicles
Electrical arc faults represent a significant safety concern in electrical systems, posing
fire risks and equipment damage. These faults can occur in various areas, including
in railway traction, ship, aircraft power systems, industrial machinery, and electric vehicles (EVs), and are challenging to detect especially in direct current (DC) systems. Also, the recent popularity of the EV revolution came into the picture, there are potential arc faults in EVs due to their dependency on DC sources.

This repository contains MATLAB code for detecting series arc faults (SAF) in DC-powered systems and electric vehicles by analyzing electrical signals. The methodology involves processing a concatenated signal comprising both normal and series arcing signals of current data, applying various filtering techniques, and using peak detection algorithms to identify arc faults.

## Table of Contents

- [Introduction](#introduction)
- [Methodology](#methodology)
- [Dependencies](#dependencies)
- [Results](#results)
- [Contributing](#contributing)
- [Note](note)


## Introduction

SAFs are high-power discharges of electricity between two or more conductors due to wire insulation damages/poor connection and are a significant cause of electrical fires. This project aims to detect SAFs by analyzing the current signal data. The provided MATLAB code processes the signal applies wavelet decomposition, and detects peaks that correspond to potential arc faults.

## Methodology

1. **Data Reading and Preparation**: The code reads the raw current signal data from an Excel file and concatenates normal and arc current signals.
2. **Signal Filtering**: Various filters, including moving average and median filters, are applied to smoothen the signal and remove noise.
3. **Peak Detection**: The processed signal is divided into windows, and peak-to-peak values are calculated for each window. Wavelet decomposition is then used to further process the signal.
4. **Arc Fault Detection**: Peaks in the reconstructed signal are identified, and a detection algorithm is applied to determine the presence of arc faults based on the number of peaks and their amplitude.
   
## Dependencies
1. MATLAB
2. Signal Processing Toolbox
3. Wavelet Toolbox
## Results
The proposed algorithm was executed over ten times (10 iterations), consistently
yielding identical results with each test. This uniformity across multiple trials suggests
a success rate of approximately 100% for the current data acquired under a rheostat load
within the DC network.

## Contributing
Contributions are welcome! If you have suggestions or improvements, feel free to fork the repository, make your changes, and submit a pull request.

## Note
This project involves a load such as a rheostat. So present algorithm works for this load. But changes may apply in the code for other loads such as motor, etc...
