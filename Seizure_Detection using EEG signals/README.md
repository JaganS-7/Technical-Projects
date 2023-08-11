# Seizure Detection using EEG Signals

## Introduction

Welcome to the "Seizure Detection using EEG Signals" project repository. 
This project focuses on the automated detection of seizure states utilizing EEG (Electroencephalography) signals. 
The primary objective is to develop a robust system that can accurately identify instances of seizure activity within EEG data, 
aiding in timely medical intervention and patient care.

## Table of Contents

- [Background](#background)
- [Dataset](#dataset)
- [Feature Extraction](#feature-extraction)
- [Model Development](#model-development)
- [Results](#results)

## Background

Seizure detection plays a crucial role in managing epilepsy and other neurological disorders. 
EEG signals, which record the brain's electrical activity, offer valuable insights into these conditions. 
This project employs advanced machine learning techniques to identify distinct EEG patterns associated with seizure occurrences, 
contributing to accurate and timely diagnosis.

## Dataset
We have taken the data set from PREPROCESSED CHB-MIT SCALP EEG DATABASE, from IEEEDataPort.
This data set contains balanced preictal and ictal data from all 24 patients. Only 23 channels are retained, the outcome column is added and amounts to 24 columns in this file. In the outcome column '0' indicates preictal and '1' indicates ictal.

## Feature Extraction
Feature extraction is a pivotal step in deciphering meaningful insights from EEG signals. This project utilizes techniques like entropy and statistical analyses to distill essential information for distinguishing between seizure and non-seizure states.

## Model Development
The classification task is approached using a Support Vector Machine (SVM) with a sigmoid kernel. The model is trained on extracted features and evaluated based on accuracy metrics. Dimensionality reduction techniques, including Mutual Information and PCA, are explored to enhance model efficiency.

## Results
The project yields promising results in accurately identifying seizure states.
Accuracy of 0.92 (92%) upon performing PCA using the SVM model.
Accuracy of 0.96 (96%) upon performing mutual_info and Wilcoxon test methods using the SVM model

