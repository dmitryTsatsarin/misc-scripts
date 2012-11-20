#!/bin/bash

# symlink this script to mlint and matlab-nw

# Env vars
export MATLABROOT=/Applications/MATLAB_R2011a.app
export DYLD_LIBRARY_PATH=$MATLABROOT/runtime/maci64:$MATLABROOT/bin/maci64:$MATLABROOT/sys/os/maci64:$DYLD_LIBRARY_PATH
export XAPPLRESDIR=$MATLABROOT/X11/app-defaults

MATLAB_BIN=$MATLABROOT/bin/matlab
MLINT_BIN=$MATLABROOT/bin/maci64/mlint
MEX_BIN=$MATLABROOT/bin/mex

# check which program to call
SCRIPT_NAME=$(basename "$0")
if [ "$SCRIPT_NAME" = "matlab" ]; then
    TARGET_BIN=$MATLAB_BIN
    TARGET_ARGS=
elif [ "$SCRIPT_NAME" = "matlab-nw" ]; then
    TARGET_BIN=$MATLAB_BIN
    TARGET_ARGS='-nodesktop -nosplash'
elif [ "$SCRIPT_NAME" = "mlint" ]; then
    TARGET_BIN=$MLINT_BIN
    TARGET_ARGS=
elif [ "$SCRIPT_NAME" = "mex" ]; then
    TARGET_BIN=$MEX_BIN
    TARGET_ARGS=
else
    echo "Script must be named matlab, matlab-nw or mlint."
    exit 1
fi

if [ ! -e "$TARGET_BIN" ]; then
    echo "File '$TARGET_BIN' cannot be found, is matlab installed?"
    exit 2
fi

$TARGET_BIN $TARGET_ARGS $@
