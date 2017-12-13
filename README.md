# ZeroG
Code for working with accelerometer data from parabolic flights.

# Compatibility
Tested with MATLAB 2017a on OS X 10.12 and Windows 10. Expected to work with MATLAB 2016a+.
Requires Signal Processing Toolbox.

# Citation
Carr CE, Bryan NC, Saboda K, Bhattaru SA, Ruvkun G, Zuber MT. Acceleration Profiles and Processing Methods for Parabolic Flight. TBD preprint.

# Installation
## Get Scripts
Download: <https://github.com/CarrCE/zerog/archive/master.zip> or use command line ```git clone git@github.com:CarrCE/zerog.git```.

Unzip to preferred location, here denoted ```/zerog-master```.

## Get Data
Download: <https://osf.io/5rqu9/download>. This 1.0 GB (compressed ZIP) dataset has a CC BY 4.0 US license.

Unzip into the same folder as your code, e.g. ```/zerog-master```

You should now have two folders in your ```/zerog-master``` directory, ```Flight``` and ```Lab```, which contain the flight data and a short lab test used in verifying accelerometer calibration accuracy.

## Run Analysis
In MATLAB, go to your ```/zerog-master``` path, and run the main script: ```analysis```. This will perform the same analysis as in the publication (see citation, above). For documentation and to adapt to your own data, see the contents of the ```analysis.m``` script.

# License
Distributed under an MIT license. See LICENSE for details.
