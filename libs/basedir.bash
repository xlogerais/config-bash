#!/bin/bash

function basedir() {
  echo $( cd $(dirname $0) && pwd )
}
