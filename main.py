import sys
import scipy.io
import numpy as np
import warnings
from pylab import *
from scipy.io import wavfile

def HPS(rate, signal):
    beg = max(0, int(len(signal) / 2) - int(3 / 2 * rate))
    end = min(len(signal) - 1, int(len(signal) / 2) + int(3 / 2 * rate))
    signal = signal[beg : end]
    if len(signal.shape) == 2:
        signal = [(s[0] + s[1]) / 2 for s in signal]

    parts_array = []
    length = int(rate)
    for i in range(3):
        parts_array.append(signal[ i*length : (i+1)*length ])

    results = []
    for data in parts_array:
        if (len(data)==0):
            continue
        window = np.hamming(len(data))
        data = data * window
        fft1 = abs(fft(data)) / rate
        fft2 = np.copy(fft1)
        for i in range(2, 6):
            tab = np.copy(fft1[::i])
            fft2 = fft2[:len(tab)]
            fft2 *= tab
        results.append(fft2)

    result = np.zeros(len(results[int(len(results)/2)]))
    for res in results:
        if (len(res) != len(result)): 
            continue
        result += res
        
    man = np.sum(result[85:180])
    woman = np.sum(result[165:255])
    if (man > woman):
        return "M"
    return "K"

def recognize(file):
    sampling_rate, signal = scipy.io.wavfile.read(file)
    print(HPS(sampling_rate, signal))

if __name__ == "__main__":
    warnings.filterwarnings("ignore")
    recognize(sys.argv[1])

