# deepdreamers
**a collective deepdream**, or, The Over-Ambitious Attempt to Experience Deepdream Film, Created Based on Your Current Mental State, With Other Humans

> **a work in progress** -- this is not functional

> It will eventually use the [rosshamish/docker-deep-dream-video](https://github.com/rosshamish/docker-deep-dream-video) docker image (also a work in progress).

\#deepdream video, watched in a group, where the #deepdream is affected in realtime by participants' mental state (as measured by brain wave sensors).

Video processing based on [graphific/DeepDreamVideo](https://github.com/graphific/DeepDreamVideo). Docker image based on [ryankennedyio/deep-dream-generator](https://github.com/ryankennedyio/deep-dream-generator).

**Creative Request from [graphific](https://github.com/graphific)**

> It would be very helpful for other deepdream researchers, if you could **include the used parameters in the description of your youtube videos**. You can find the parameters in the image filenames.

### "#deepdream video" 
(by [graphific](https://github.com/graphific): Deep Dreaming Fear & Loathing in Las Vegas: the Great Fan Francisco Acid Wave)

![deepdreamanim1](http://media.giphy.com/media/l41lRx92QqsIXy5MI/giphy.gif "deep dream animation 1")
![deepdreamanim2](http://media.giphy.com/media/l41lSzjTsGJcIzpKg/giphy.gif "deep dream animation 2")

### "watched in a group"
(by [michelar]/[iStock]/Thinkstock from https://www.pacsafe.com/blog/if-you-ever-have-to-chaperone-a-trip-scare-them-with-these-movies/)

![](http://i.imgur.com/aygaWLF.jpg "watched in a group")

### "affected in realtime by participants' mental state"
(by [Juanix Land aka Overstruck](http://overstruck.com/how-to-customize-googles-deepdream/): How to customize Google's Deep Dream)

Mental State 0:

![](http://i.imgur.com/aE0hNWK.jpg "Mental State 0")

Mental State 1:

![](http://i.imgur.com/MHC3T2b.jpg "Mental State 1")

Mental State 2:

![](http://i.imgur.com/HgGXDy0.jpg "Mental State 2")

Mental State 3:

![](http://i.imgur.com/EruFjNy.jpg "Mental State 3")

## Roadmap

Technical
- [ ] create a short deepdream video (2s) inside a docker image on a development machine
- [ ] create one on a raspberry pi
- [ ] create a medium-length deepdream video (10min)
- [ ] write mock brainwave input, and feed that into the deepdream as parameters (jitter, octaves, # of iterations)
- [ ] collect real brainwave input, and feed that into the deepdream
- [ ] get deepdream video processing performance to at least 1s of video per 10s processing time
- [ ] allow switching back and forth between real video and deepdream video
  - this allows the hardware time to generate deepdream. Think 10s original -> 5s deepdream -> 10s original -> 5s deepdream -> ...

Creative
- [ ] screen (size, orientation)
- [ ] way to wrap/cover screen
- [ ] chair/couch/bench to sit on
- [ ] brainwave sensor aesthetics (+ wired vs wireless)
- [ ] group dynamics (how does each individual's brainwave input affect the deepdream?)

Stretch goals
- [ ] do it massively in parallel - speed up processing by MANYx
- [ ] create a long deepdream video (30-60min)

## Setup

Install [docker](https://docs.docker.com/installation/).

That's it.

## Usage

`docker pull rosshamish/deepdreamer:latest`

`docker run rosshamish/deepdreamer:latest ./deepdreamer.sh [inputFilename.mp4] [outputFilename.mp4]`

Eg `docker run rosshamish/deepdreamer:latest ./deepdreamer.sh short-charlie-brown.mp4 short-charlie-brown-output.mp4`

## parameters used (and useful to play with):

- network: standard reference GoogLeNet model trained on ImageNet from the Caffe Model Zoo (https://github.com/BVLC/caffe/wiki/Model-Zoo)

- iterations: 5

- jitter: 32 (default)

- octaves: 4 (default)

- layers locked to moving upwards from inception_4c/output to inception_5b/output (only the output layers, as they are most sensitive to visualizing "objects", where reduce layers are more like "edge detectors") and back again

- [unimplemented](graphific/DeepDreamVideo#25) every next unprocessed frame in the movie clip is blended with the previous processed frame before being "dreamed" on, moving the alpha from 0.5 to 1 and back again (so 50% previous image net created, 50% the movie frame, to taking 100% of the movie frame only). This takes care of "overfitting" on the frames and makes sure we don't iteratively build more and more "hallucinations" of the net and move away from the original movie clip.

## More information

[Graphific's DeepDreamVideo](https://github.com/graphific/DeepDreamVideo) implements a video processing workflow for [google deepdream](https://github.com/google/deepdream), a hallucinating neural network. Find out more about deepdream [here](http://googleresearch.blogspot.nl/2015/06/inceptionism-going-deeper-into-neural.html).
