#!/usr/bin/env python
# -*- coding: utf-8 -*-
from setuptools import setup, find_packages

setup(
    name='randori_infra_as_code_legacy',
    version='1.0',
    license='',
    long_description=open('README.md').read(),
    entry_points = {
        'console_scripts': [],
    },
    install_requires = [
      'testinfra'
    ]
)
