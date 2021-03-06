# ZeroG
Code for working with accelerometer data from parabolic flights.

We use two-stage change-point detection to identify transitions between g-levels and periods of statistically stable g-levels outside these transitions.

# Compatibility
Tested with MATLAB 2017a on OS X 10.12 and Windows 7 and Windows 10. Expected to work with MATLAB 2016a+.
Requires Signal Processing Toolbox.

# Citation
Carr CE, Bryan NC, Saboda KN, Bhattaru SA, Ruvkun G, Zuber MT. Acceleration Profiles and Processing Methods for Parabolic Flight. npj Microgravity 4, Article number: 14 (2018) <https://doi.org/10.1038/s41526-018-0050-3>. Preprint: arXiv:1712.05737 <https://arxiv.org/abs/1712.05737>

# Installation
## Get Scripts
Download: <https://github.com/CarrCE/zerog/archive/master.zip> or use command line ```git clone git@github.com:CarrCE/zerog.git```.

Unzip to preferred location, here denoted ```/zerog-master```.

## Get Data
Download: <https://osf.io/5rqu9/download>. This 1.0 GB (compressed ZIP) dataset has a CC BY 4.0 US license. More details at: <https://osf.io/nk2w4/>

Unzip into the same folder as your code, e.g. ```/zerog-master```

You should now have two folders in your ```/zerog-master``` directory, ```Flight``` and ```Lab```, which contain the flight data and a short lab test used in verifying accelerometer calibration accuracy.

## Run Analysis
In MATLAB, go to your ```/zerog-master``` path, and run the main script: ```analysis```. This will perform the same analysis as in the publication (see citation, above). For documentation and to adapt to your own data, see the contents of the ```analysis.m``` script.

The results of running this analysis in MATLAB include a series of PDF figures, replicating those in the preprint, the filtered g-level data, and a tab-delimited file of all periods in the flight. All times are elapsed time, and for reference, the start time is: 2017-11-17 18:28:51 UTC. The analysis results are also available (188 MB ZIP) at: <https://osf.io/pmhj4/download>

# License
Distributed under an MIT license. See LICENSE for details.
