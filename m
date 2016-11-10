From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 10 Nov 2016 11:09:21 +0100
Subject: [LTP] [COMMITTED] [PATCH 1/5] testscripts/math.sh: Remove.
Message-ID: <1478772565-12167-1-git-send-email-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The script just calls runltp -f math and does not seem to be called from
any other script inside LTP.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testscripts/math.sh | 4 ----
 1 file changed, 4 deletions(-)
 delete mode 100755 testscripts/math.sh

diff --git a/testscripts/math.sh b/testscripts/math.sh
deleted file mode 100755
index 0d709fb..0000000
--- a/testscripts/math.sh
+++ /dev/null
@@ -1,4 +0,0 @@
-#!/bin/sh
-cd `dirname $0`
-cd ..
-./runltp -f ${PWD}/runtest/math -q "$@"
-- 
2.7.3

