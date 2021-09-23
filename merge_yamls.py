#!/usr/bin/env python3

import os
import glob
import hiyapyco
import argparse
from pprint import pprint
import sys
import yaml

try:
    from collections import OrderedDict
except ImportError:
    # try importing the backported replacement
    # requires a: `pip-2.6 install ordereddict`
    from ordereddict import OrderedDict

import yaml.loader
import yaml.dumper
import yaml.representer
from hiyapyco.odyldo import ODYD
import six

import datetime
import  types


class ODYD(yaml.SafeDumper):
    """Ordered Dict Yaml Dumper"""
    def __init__(self, *args, **kwargs):
        yaml.SafeDumper.__init__(self, *args, **kwargs)
        yaml.representer.SafeRepresenter.add_representer(str, type(self).repr_str)
        yaml.representer.SafeRepresenter.add_representer(OrderedDict, type(self)._odyrepr)

    def rstrip_multilines(self, data):
        out = []
        for line in data.splitlines():
            out.append(line.rstrip())

        return '\n'.join(out)
    def _odyrepr(self, data):
        """see: yaml.representer.represent_mapping"""
        return self.represent_mapping('tag:yaml.org,2002:map', data.items())
    def repr_str(self, data):
        if '\n' in data:
            return self.represent_scalar(u'tag:yaml.org,2002:str', self.rstrip_multilines(data), style='|')
        elif len(data) > 80:
            return self.represent_scalar(u'tag:yaml.org,2002:str', data, style='|')
        else:
            return self.represent_scalar(u'tag:yaml.org,2002:str', data, style=None)


def safe_dump(data, stream=None, **kwds):
    """implementation of safe dumper using Ordered Dict Yaml Dumper"""
    return yaml.dump(data, stream=stream, Dumper=ODYD, **kwds)


def merge_yamls(files, output):
    conf = hiyapyco.load(*files, method=hiyapyco.METHOD_MERGE, interpolate=True, failonmissingfiles=True)

    # print(safe_dump(conf))
    with open(output, 'w') as file:
        safe_dump(conf, file)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Merge some yamls')
    parser.add_argument('--yaml-files', metavar='N', type=str, nargs='+',
                        help='YAML Files to merge', required=True)
    parser.add_argument('--output', help='Path to Destination file', required=True)
    args = parser.parse_args()
    merge_yamls(args.yaml_files, args.output)