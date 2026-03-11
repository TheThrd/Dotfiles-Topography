import numpy as np
from PIL import Image
import perlin_noise as noise
import random
import os 
import colorsys as convertCol

dir_path = os.path.dirname(os.path.realpath(__file__)) + "\\"

generatedNoise = noise.PerlinNoise(seed=random.randint(-10000,10000))

imgSizeX = input("Image width (pixels):\n")
while imgSizeX.isnumeric() == False:
    imgSizeX = input("Image width (pixels):\n")
imgSizeX = int(imgSizeX)

imgSizeY = input("Image height (pixels):\n")
while imgSizeY.isnumeric() == False:
    imgSizeY = input("Image height (pixels):\n")
imgSizeY = int(imgSizeY)

scale = input("Scale:\n")
while scale.isdecimal() == False:
    scale = input("Scale:\n")
scale = float(scale)

steps = input("Steps:\n")
while steps.isdigit() == False:
    steps = input("Steps:\n")
steps = int(steps)

data = np.zeros((imgSizeY,imgSizeX,3), dtype=np.uint8 )

highColour = [142, 173, 142]
lowColour = [42,45,42]

count = 0

for x in range(imgSizeX):
    for y in range(imgSizeY):
        if count % 10000 == 0:
            print(f"You are at {count} operations!")

        noiseVal = generatedNoise.noise([(x/3 + 100000)/scale,(y/3 + 100000)/scale], [imgSizeX*10, imgSizeY*10])

        noiseVal *= 1.1
        noiseVal += 0.5

        if noiseVal < 0:
            noiseVal = 0
        if noiseVal > 1:
            noiseVal = 1
        
        noiseVal *= steps
        noiseVal = int(noiseVal)
        noiseVal /= steps

        blended = [noiseVal * (highColour[0]-lowColour[0]) + lowColour[0], noiseVal * (highColour[1]-lowColour[1]) + lowColour[1], noiseVal * (highColour[2]-lowColour[2]) + lowColour[2]]
        data[y][x] = blended
        count += 1

img = Image.fromarray(data)
img.show()

saveQ = input("Save? y/n\n")
if saveQ == "y":
    name = dir_path + input("Name\n") + ".png"
    img.save(name)
