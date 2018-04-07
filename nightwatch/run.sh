#!/bin/bash

rm -rf reports/*.xml && rm -rf screenshots/*.png

nightwatch tests -e default,chrome,safari
