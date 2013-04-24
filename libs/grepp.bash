grepp() { x=$1; shift; perl -00ne ' print if /'"$x"'/i ' "$*" ; }
