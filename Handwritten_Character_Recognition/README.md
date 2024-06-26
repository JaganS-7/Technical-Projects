# Handwritten Character Recognition using Convolutional Neural Networks (CNN)

This repository contains a Python implementation of a Convolutional Neural Network (CNN) for recognizing handwritten English alphabet characters (A-Z). The CNN model is built using TensorFlow and Keras, and it aims to accurately classify handwritten characters, making it useful for applications like optical character recognition (OCR).

## Table of Contents

- [Introduction](#introduction)
- [Data-set](#data-set)
- [Prerequisites](#prerequisites)
- [Usage](#usage)
- [Model Overview](#model-overview)
- [Results](#results)
- [Custom Image Prediction](#custom-image-prediction)

## Introduction

Recognizing and classifying handwritten characters is a fundamental task in image recognition and artificial intelligence. This repository showcases a CNN-based solution for achieving accurate handwritten character recognition. The model is trained on a large dataset of labeled handwritten characters and can predict the alphabet corresponding to an input image.

## Data set

This data set is taken from the Kaggle platform. It contains a large number of English characters in an Excel sheet.

### Prerequisites
- NumPy
- Pandas
- Matplotlib
- OpenCV (cv2)
- TensorFlow
- Keras

## Usage
This project demonstrates the entire process of creating, training, and evaluating the CNN model for handwritten character recognition. It includes visualizations that help you understand the model's behavior and performance. You can also use a custom image to test the model's prediction capabilities

## Model Overview
The CNN model architecture is designed to efficiently capture features from handwritten character images. It consists of multiple convolutional layers and max-pooling layers to extract and downsample features. The model also includes fully connected layers for classification and an output layer with a softmax activation function.

## Results
The script displays the training progress over epochs, showing accuracy and loss values for both training and testing datasets. The accuracy of the model on the testing dataset indicates its performance in correctly classifying unseen data.

## Custom Image Prediction
This project also provides an option to test the model on a custom image. By providing an image file, you can observe how the model predicts the alphabet corresponding to the provided image.


