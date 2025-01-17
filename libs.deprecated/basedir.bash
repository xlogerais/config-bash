#!/bin/bash

function basedir() {
  (cd "$(dirname \"$-2\")" && pwd)
}
