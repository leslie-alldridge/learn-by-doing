#!/usr/bin/env python3
"""
Creates zip archives and sends them to S3
for use in Lambda and Layers
"""

import argparse
import os
import shutil
import subprocess
import sys
from pathlib import Path

EXCLUDED_FILES_FROM_BUILD = ['*.zip', 'requirements_test*', '__pycache__', 'build']

def parse_args():
  """
  Parses input args: --dir and --name are required
  """
  parser=argparse.ArgumentParser()

  parser.add_argument("--dir", help="Source code directory e.g. src/rds_notifier", required=True)
  parser.add_argument("--layer", help="Build archive for Lambda Layer", action='store_true')
  parser.add_argument("--name", help="Name of archive", required=True)

  args=parser.parse_args()
  return args


def build_artifact(build_dir, get_requirements, args):
  """
  Build lambda archive and send to S3
  """
  print("Building lambda")
  # 1. Remove build directory if it exists
  if os.path.exists(build_dir):
    shutil.rmtree(build_dir)

  # 2. Copy entire source directory into build (exluding ignored files)
  shutil.copytree(args.dir, build_dir, ignore=shutil.ignore_patterns(*EXCLUDED_FILES_FROM_BUILD))

  if get_requirements.is_file():
    print("Found requirements.txt! Installing dependendencies...")
    # 3. (OPTIONAL) Run pip install to obtain additional packages
    subprocess.check_call([sys.executable, '-m', 'pip', 'install', '-r', f'{args.dir}/requirements.txt', '--target', build_dir, '--upgrade'])

  # 4. Create zip archive based on provided --name argument
  shutil.make_archive(f"{args.dir}/{args.name}", 'zip', build_dir)


def main():
  """
  Main entrypoint
  """
  args = parse_args()
  print(f"Building artifacts. name: {args.name} dir: {args.dir} layer {args.layer}")

  build_dir = f"{args.dir}/build"
  requirements_file = f"{args.dir}/requirements.txt"
  get_requirements = Path(requirements_file)
  build_artifact(build_dir, get_requirements, args)

if __name__ == "__main__":
  main()
