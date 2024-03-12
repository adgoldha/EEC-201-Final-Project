# EEC-201-Final-Project: Speech Recognition

To run our repo:
  1. Please clone or download the repo (datasets as well)
  2. Open the testing.m file and hit run in your environment
  3. Output should be displayed in the terminal

Our results so far:
  1. Centroids initialized as a linear line (8/8) (15 centroids used)
    ![100% with Centroids Linear](https://github.com/adgoldha/EEC-201-Final-Project/assets/146307216/22dc646c-b979-426f-bd0f-3bf58be8ba1a)
  2. Centroids initialized based on division mean of input (7/8) (15 centroids used)
    ![Best results with Division Centroids](https://github.com/adgoldha/EEC-201-Final-Project/assets/146307216/5a23e600-f549-41a8-bde4-0e00401009d5)

Notes of results so far:
  1. Our results have better repeatability with centroid approach #2
  2. Sometimes with centroid approach #1 we get 100% accuracy. However, performance can degrade to getting 2-3 incorrect at times.
