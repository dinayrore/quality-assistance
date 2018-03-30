#!/bin/bash

rm reports/*.xml && screenshots/*.png

nightwatch tests -e default,chrome,safari
