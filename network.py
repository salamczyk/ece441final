import tensorflow as tf
import tensorflow_datasets as tfds
import sys
import numpy
numpy.set_printoptions(threshold=sys.maxsize)


tf.random.set_seed(1234)


(ds_train, ds_test), ds_info = tfds.load(
    'mnist',
    split=['train', 'test'],
    shuffle_files=True,
    as_supervised=True,
    with_info=True,
)

def normalize_img(image, label):
  """Normalizes images: `uint8` -> `float32`."""
  return tf.cast(image, tf.float32) / 255., label

ds_train = ds_train.map(
    normalize_img, num_parallel_calls=tf.data.AUTOTUNE)
ds_train = ds_train.cache()
ds_train = ds_train.shuffle(ds_info.splits['train'].num_examples)
ds_train = ds_train.batch(128)
ds_train = ds_train.prefetch(tf.data.AUTOTUNE)

ds_test = ds_test.map(
    normalize_img, num_parallel_calls=tf.data.AUTOTUNE)
ds_test = ds_test.batch(128)
ds_test = ds_test.cache()
ds_test = ds_test.prefetch(tf.data.AUTOTUNE)



model = tf.keras.models.Sequential([
  tf.keras.layers.Flatten(input_shape=(28, 28)),
  tf.keras.layers.Dense(128, activation='relu'),
  tf.keras.layers.Dense(10)
])
model.compile(
    optimizer=tf.keras.optimizers.Adam(0.001),
    loss=tf.keras.losses.SparseCategoricalCrossentropy(from_logits=True),
    metrics=[tf.keras.metrics.SparseCategoricalAccuracy()],
)

model.fit(
    ds_train,
    epochs=6,
    validation_data=ds_test,
)

f = open("raw_weights.txt", "w")
for layer in model.layers[1:]:
    f.write(layer.name)
    f.write("\n")
    f.write("Weight Shape:\n")
    f.write(str(layer.get_weights()[0].shape))
    f.write("\n")
    f.write("Bias Shape:\n")
    f.write(str(layer.get_weights()[1].shape))
    f.write("\n")
    f.write("weights:\n")
    f.write(str(layer.get_weights()[0]))
    f.write("\n")
    f.write("biases:\n")
    f.write(str(layer.get_weights()[1]))
    f.write("\n")
    f.write("\n")
f.close()

f = open("clean_weights.txt", "w")
for layer in model.layers[1:]:
    f.write(layer.name)
    f.write("\n")
    f.write("Weight Shape:\n")
    f.write(str(layer.get_weights()[0].shape))
    f.write("\n")
    f.write("Bias Shape:\n")
    f.write(str(layer.get_weights()[1].shape))
    f.write("\n")

    f.write("weights:\n")
    weights = layer.get_weights()[0]
    weights = weights * 100
    weights = weights.astype(int)

    binaryweights = weights.astype(str)
    for i in range(weights.shape[0]):
        for j in range(weights.shape[1]):
            binaryweights[i, j] = bin(weights[i, j] & 0b111111111)[2:].zfill(9)


    f.write(str(binaryweights))
    f.write("\n")
    
    f.write("biases:\n")
    bias = layer.get_weights()[1]
    bias = bias * 100
    bias = bias.astype(int)
    binarybias = bias.astype(str)
    for i in range(bias.shape[0]):
        binarybias[i] = bin(bias[i] & 0b111111111)[2:].zfill(9)
        
    f.write(str(binarybias))
    f.write("\n")
    f.write("\n")
f.close()


