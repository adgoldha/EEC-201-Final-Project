# EEC-201-Final-Project: Speech Recognition

To run our repo:
  1. Please clone or download the repo (datasets as well)
  2. Separate the .m files and .mlx files (.m files are our project submission code, .mlx files are for testing new ideas/implementation of our code)
  3. Open the testing.m file (based on number of train files will need to change variable n & based on number of test files will need to change variable m. Also, make sure all .wav files are of the format s#.wav for program to run properly)
  4. Hit run in your environment (if you are not satisfied with your initial results, try tuning the number of centroids)
  5. Output should be displayed in the terminal

See report link here to see our results (must be signed into UC Davis email to view report): https://docs.google.com/document/d/1XA_Kub8cc-9Oyi5M5pXoQIUEcrIrhQ39NqxBc4pRC2E/edit?usp=sharing

See video link here for a walkthrough of our code and report (must be signed into UC Davis email to view): https://drive.google.com/file/d/1o1mRzZjTAh8eqHwgxkiyfFaPcK9cjwpv/view?usp=drive_link

For those viewing with out a UC Davis email, our group was able to achieve 97.727-100% accuracy by using 40 centroids on the train and test sets in this repo.

Lastly, for testing and visualizations of all our plots please see the Preprocessing.mlx. If you are going to run the Preprocessing.mlx make sure to have downloaded LBGAlgorithmTester.mlx, melfb.mlx, and disteu.mlx. Without the extra files the Preprocessing.mlx will not run and you will not be able to see visualizations if desired by user.
