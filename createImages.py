#!/usr/bin/python3

import tensorflow as tf
import tensorflow_datasets as tfds
import matplotlib.pyplot as plt
import matplotlib.image as mpimg
import random

(x_train, y_train), (x_test, y_test) = tf.keras.datasets.mnist.load_data()
print(len(x_train))
length = len(x_train)

random.seed(0)

# From manually picking images using `searchNums` function
image_d = {'1':40101,
           '2':59621,
           '3':49673,
           '4':58906,
           '5':51367,
           '6':23465,
           '7':2653,
           '8':27562,
           '9':25247
}

# for i in image_d:
#     print(image_d[i])

def searchNums():
    while True:
        i = random.randint(0,length-1)
        image = x_train[i]
        imgplot = plt.imshow(image)
        print(i)
        plt.show()

def showNums(image_d):
    for num in image_d:
        image = x_train[image_d[num]]
        imgplot = plt.imshow(image)
        imageFile = 'images/image%s.png' % num
        plt.savefig(imageFile)
        plt.show()
        image = (image / 255 ) * 256
        image = image.flatten().astype(int)
        imageTxt = 'images/image%s.txt' % num
        with open(imageTxt, "w") as f:
            f.write("(")
            for i in range(len(image)):
                f.write(str(image[i]) + ",")
            f.write(")")

showNums(image_d)
