import io
import sys
import urllib
from itertools import izip

from PIL import Image
from havenondemand.hodclient import *
from scipy import sum

def compare(img1, img2):
    pairs = izip(img1.getdata(), img2.getdata())
    if len(img1.getbands()) == 1:
        dif = sum(abs(p1 - p2) for p1, p2 in pairs)
    else:
        dif = sum(abs(c1 - c2) for p1, p2 in pairs for c1, c2 in zip(p1, p2))
    ncomponents = img1.size[0] * img2.size[1] * 3
    return (dif / 256.0 * 100) / ncomponents

def compareImages(file1,file2):
    img1 = Image.open(io.BytesIO(urllib.urlopen(file1).read()))
    img2 = Image.open(io.BytesIO(urllib.urlopen(file2).read()))
    return compare(img1,img2)

def main():
    if (len(sys.argv) < 3 or sys.argv[1] == "learn"):
        print("high")
    else:
        file1, file2 = sys.argv[1:1 + 2]
        img1 = Image.open(io.BytesIO(urllib.urlopen(file1).read()))
        img2 = Image.open(io.BytesIO(urllib.urlopen(file2).read()))
        percentage = compare(img1, img2)
        return percentage


if __name__ == "__main__":
    main()

client = HODClient("d028225e-f3d7-49ce-b431-c2d769602f1f", version="v1")