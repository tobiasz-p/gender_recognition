import sys

def recognize(file):
  sampling_rate, signal = scipy.io.wavfile.read(file)
  signal = [s[0] for s in signal]

if __name__ == "__main__":
  recognize(sys.argv[1])

