#!/bin/bash

PATCH_DIR="$(dirname ${BASH_SOURCE[0]})"

function bazel_patch()
{
  [ ! -d "${PATCH_DIR}/patch/bazel/${BAZEL_VERSION}" ] && return 0
  for f in $(find "${PATCH_DIR}/patch/bazel/${BAZEL_VERSION}" -type f | sort); do
    patch -p1 < "$f" || return 1
  done
  return 0
}

function tf_patch()
{
  [ ! -d "${PATCH_DIR}/patch/tensorflow/${TF_VERSION}" ] && return 0
  for f in $(find "${PATCH_DIR}/patch/tensorflow/${TF_VERSION}" -type f | sort); do
    git apply "$f" || return 1
  done
  return 0
}

function tf_toolchain_patch()
{
  local CROSSTOOL_NAME="$1"
  local CROSSTOOL_DIR="$2"
  local CROSSTOOL_EXTRA_INCLUDE="$3"
  [ -z "$CROSSTOOL_EXTRA_INCLUDE" ] && CROSSTOOL_EXTRA_INCLUDE="/usr/local/include/"
  local CROSSTOOL_VERSION=$($CROSSTOOL_DIR/bin/$CROSSTOOL_NAME-gcc -dumpversion)
  git apply --stat ${PATCH_DIR}/patch.patch
}
