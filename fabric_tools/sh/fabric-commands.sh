#!/usr/bin/env bash

fab set_worker:build,launch=true

fab set_worker:build build:upload=false,add_channels=true

fab set_worker:build \
    build:upload=true,add_channels=true,no_test=true \
    test_conda_ocgis

fab set_worker:build \
    build:upload=true \
    test_conda_ocgis

fab set_worker:build worker_terminate