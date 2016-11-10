From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 10 Nov 2016 11:09:25 +0100
Subject: [LTP] [COMMITTED] [PATCH 5/5] testscripts/test_filecaps.sh: Remove.
In-Reply-To: <1478772565-12167-1-git-send-email-chrubis@suse.cz>
References: <1478772565-12167-1-git-send-email-chrubis@suse.cz>
Message-ID: <1478772565-12167-5-git-send-email-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The script just calls runltp -f filecaps and does not seem to be called
from any other script inside LTP.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testscripts/test_filecaps.sh | 47 --------------------------------------------
 1 file changed, 47 deletions(-)
 delete mode 100755 testscripts/test_filecaps.sh

diff --git a/testscripts/test_filecaps.sh b/testscripts/test_filecaps.sh
deleted file mode 100755
index ecb0691..0000000
--- a/testscripts/test_filecaps.sh
+++ /dev/null
@@ -1,47 +0,0 @@
-#!/bin/bash
-#
-# Copyright 2007 IBM
-#
-# This program is free software; you can redistribute it and/or modify it
-# under the terms of the GNU General Public License as published by the Free
-# Software Foundation; either version 2 of the License, or (at your option)
-# any later version.
-#
-# test_filecaps.sh - Run the file capabilities test suite.
-
-# Must be root to run the containers testsuite
-if [ $UID != 0 ]
-then
-        echo "FAILED: Must be root to execute this script"
-        exit 1
-fi
-
-# set the LTPROOT directory
-cd `dirname $0`
-LTPROOT=${PWD}
-echo $LTPROOT | grep testscripts > /dev/null 2>&1
-if [ $? -eq 0 ]
-then
-	cd ..
-	LTPROOT=${PWD}
-fi
-
-# set the PATH to include testcase/bin
-
-export PATH=$PATH:/usr/sbin:$LTPROOT/testcases/bin
-export LTPBIN=$LTPROOT/testcases/bin
-
-# We will store the logfiles in $LTPROOT/results, so make sure
-# it exists.
-if [ ! -d $LTPROOT/results ]
-then
-	mkdir $LTPROOT/results
-fi
-
-# Check the role and mode testsuite is being executed under.
-echo "Running the file capabilities testsuite..."
-
-$LTPROOT/bin/ltp-pan -S -a $LTPROOT/results/filecaps -n ltp-filecaps -l $LTPROOT/results/filecaps.logfile -o $LTPROOT/results/filecaps.outfile -p -f $LTPROOT/runtest/filecaps
-
-echo "Done."
-exit 0
-- 
2.7.3

