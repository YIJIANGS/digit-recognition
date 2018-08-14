# digit-recognition

When given an input image of size 28*28 (this is from the test set), I first vectorize it and put the vector into the trained model, in Matlab sim(net,input) function will output the prediction result in the form of 1*10 vector. I then use max() function to find the index of the maximum number in the vector. For instance, if the output vector is [0.0788    0.4853    0.9523    0.2427    0.4001    0.0709    0.2109    0.4579    0.3961    0.4797], the 3rd number has the highest value. Use 3-1 I then get 2 which is the prediction of the given input.

When running this on test set, it has achieved a 96% accuracy on 2000 test images. 

run Number_recognition.m to give it a go.
