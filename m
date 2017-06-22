From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 22 Jun 2017 11:35:24 +0200
Subject: [LTP] [COMMITTED] [PATCH] runltp: Remove references to netpipe.sh
Message-ID: <20170622093524.7509-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The netpipe was removed in commit:

commit f7201dfc68422c4c51eb4f093ebb6fe85997c401
Author: Cyril Hrubis <chrubis@suse.cz>
Date:   Mon Nov 21 12:18:04 2016 +0100

    tools: Remove unused code.

    The Makefile skips netpipe* and top-LTP directories since it's
    introduction moreover nobody attempted to fix these over the years so
    it's reasonably safe to remove them.

Closes #158.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 runltp                     | 6 +-----
 testscripts/ltpstress.sh   | 4 ----
 testscripts/runEALtests.sh | 5 +----
 3 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/runltp b/runltp
index f08180510..f519d56fa 100755
--- a/runltp
+++ b/runltp
@@ -220,7 +220,7 @@ main()
 
     version_date=$(cat "$LTPROOT/Version")
 
-    while getopts a:c:C:T:d:D:f:F:ehi:I:K:g:l:m:M:Nno:pqr:Rs:S:t:T:w:x:b:B:z:Z: arg
+    while getopts a:c:C:T:d:D:f:F:ehi:I:K:g:l:m:M:No:pqr:Rs:S:t:T:w:x:b:B:z:Z: arg
     do  case $arg in
         a)  EMAIL_TO=$OPTARG
             ALT_EMAIL_OUT=1;;
@@ -393,10 +393,6 @@ main()
 
         N)  RUN_NETEST=1;;
 
-        n)
-            $LTPROOT/testcases/bin/netpipe.sh
-            NETPIPE=1;;
-
         o)  OUTPUTFILE_NAME="$OPTARG"
             case $OPTARG in
             /*)
diff --git a/testscripts/ltpstress.sh b/testscripts/ltpstress.sh
index a487db595..cd041b1d7 100755
--- a/testscripts/ltpstress.sh
+++ b/testscripts/ltpstress.sh
@@ -271,9 +271,6 @@ if [ $leftover_memsize -gt 0 ];then
   genload --vm 1 --vm-bytes $(($leftover_memsize * 1024)) >/dev/null 2>&1 &
 fi
 
-if [ $NO_NETWORK -eq 0 ];then
- netpipe.sh >/dev/null 2>/dev/null &
-fi
 sort -R ${LTPROOT}/runtest/stress.part1 -o ${TMP}/stress.part1
 sort -R ${LTPROOT}/runtest/stress.part2 -o ${TMP}/stress.part2
 sort -R ${LTPROOT}/runtest/stress.part3 -o ${TMP}/stress.part3
@@ -325,7 +322,6 @@ fi
 killall -9 ltp-pan >/dev/null 2>&1
 killall -9 genload >/dev/null 2>&1
 if [ $NO_NETWORK -eq 0 ];then
-  killall -9 netpipe.sh >/dev/null 2>&1
   killall -9 NPtcp >/dev/null 2>&1
 fi
 if [ $Iostat -eq 1 ];then
diff --git a/testscripts/runEALtests.sh b/testscripts/runEALtests.sh
index a70bfada7..810dc4718 100755
--- a/testscripts/runEALtests.sh
+++ b/testscripts/runEALtests.sh
@@ -81,7 +81,7 @@ if [ $? -ne 0 ]; then
   exit
 fi
 
-while getopts cd:f:hi:l:m:Nnpqr:t:x arg
+while getopts cd:f:hi:l:m:Npqr:t:x arg
 do  case $arg in
     c)
             $LTPROOT/../testcases/bin/genload --cpu 1 >/dev/null 2>&1 &
@@ -130,9 +130,6 @@ do  case $arg in
 
     N)	    run_netest=1;;
 
-    n)	    $LTPROOT/../testcases/bin/netpipe.sh
-	    NetPipe=1;;
-
     p)      pretty_prt=" -p ";;
 
     q)      quiet_mode=" -q ";;
-- 
2.13.0

