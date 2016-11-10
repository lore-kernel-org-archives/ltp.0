From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 10 Nov 2016 11:09:22 +0100
Subject: [LTP] [COMMITTED] [PATCH 2/5] testscripts/runpan.sh: Remove.
In-Reply-To: <1478772565-12167-1-git-send-email-chrubis@suse.cz>
References: <1478772565-12167-1-git-send-email-chrubis@suse.cz>
Message-ID: <1478772565-12167-2-git-send-email-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The script just calls runltp -f quickhit and does not seem to be called
from any other script inside LTP.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testscripts/runpan.sh | 23 -----------------------
 1 file changed, 23 deletions(-)
 delete mode 100755 testscripts/runpan.sh

diff --git a/testscripts/runpan.sh b/testscripts/runpan.sh
deleted file mode 100755
index 510feec..0000000
--- a/testscripts/runpan.sh
+++ /dev/null
@@ -1,23 +0,0 @@
-#!/bin/sh
-# This will only run the quickhit tests.
-cd `dirname $0`
-LTPROOT=${PWD}
-echo $LTPROOT | grep testscripts > /dev/null 2>&1
-if [ $? -eq 0 ]; then
- cd ..
- export LTPROOT=${PWD}
-fi
-
-
-mkdir /tmp/runpan-$$
-cd /tmp/runpan-$$
-
-export PATH="${PATH}:${LTPROOT}/doio:${LTPROOT}/testcases/bin"
-
-${LTPROOT}/bin/ltp-pan -e $@ -a ltp -n ltp -f ${LTPROOT}/runtest/quickhit
-
-if [ $? -eq "0" ]; then
-  echo ltp-pan reported PASS
-else
-  echo ltp-pan reported FAIL
-fi
-- 
2.7.3

