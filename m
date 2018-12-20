From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 20 Dec 2018 16:02:09 +0100
Subject: [LTP] [RFC PATCH 1/1] Remove ADP tests
Message-ID: <20181220150209.5186-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

They're not used in any runtest, not using shell API.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

I know I cannot delete everything, but I don't see much value in these tests.

Kind regards,
Petr
---
 testscripts/adp.sh          | 89 -------------------------------------
 testscripts/adp_children.sh | 11 -----
 testscripts/adp_test.sh     |  6 ---
 3 files changed, 106 deletions(-)
 delete mode 100755 testscripts/adp.sh
 delete mode 100755 testscripts/adp_children.sh
 delete mode 100755 testscripts/adp_test.sh

diff --git a/testscripts/adp.sh b/testscripts/adp.sh
deleted file mode 100755
index d22bf8f81..000000000
--- a/testscripts/adp.sh
+++ /dev/null
@@ -1,89 +0,0 @@
-#!/bin/bash
-#
-# adp.sh -- run ADP's stress test on /proc/[0-9]*/cmdline
-#
-#
-
-usage()
-{
-  cat << EOF
-  usage: $0 options
-
-  This script runs ADP's stress test on /proc/[0-0]*/cmdline.
-
-  OPTIONS
-    -h    display this message and exit
-    -d    delay for top, in seconds
-    -n    number of iterations for top
-EOF
-}
-
-
-checkvar()
-{
-  VAR=$1
-  eval VALUE='$'$VAR
-  if [ "x$VALUE" = "x" ]; then
-      echo "`basename $0`: $VAR is not set."
-      return 1
-	else
-      return 0
-  fi
-}
-
-
-while getopts hd:n: OPTION
-do
-  case $OPTION in
-    h)
-      usage
-      exit 1
-      ;;
-    d)
-      delay=$OPTARG
-      ;;
-    n)
-      iterations=$OPTARG
-      ;;
-    ?)
-      usage
-      exit 1
-      ;;
-  esac
-done
-
-
-#check all vars
-checkvar delay && checkvar iterations || {
-  usage
-  exit 2
-}
-
-echo "-------------------------------------------------------------------------"
-date
-echo "Starting tests..."
-
-for i in 1 2 3 4 5
-do
-	./adp_children.sh &
-done
-
-echo "Stressing /proc/[0-9]*/cmdline..."
-
-for i in 1 2 3 4 5
-do
-	./adp_test.sh &
-done
-
-echo "Starting 'top', redirecting output to 'adp.log'..."
-top -b -d $delay -n $iterations > adp.log &
-
-echo "LTP ADP Test done. Killing processes..."
-killall adp_test.sh
-killall adp_children.sh
-
-echo "Done. Please check adp.log."
-date
-
-echo "-------------------------------------------------------------------------"
-
diff --git a/testscripts/adp_children.sh b/testscripts/adp_children.sh
deleted file mode 100755
index 4c1c94e36..000000000
--- a/testscripts/adp_children.sh
+++ /dev/null
@@ -1,11 +0,0 @@
-#!/bin/bash
-
-while :
-do
-	for i in 1 2 3 4 5 6 7 8 9 0
-	do
-		sleep 1 &
-	done
-
-	wait
-done
diff --git a/testscripts/adp_test.sh b/testscripts/adp_test.sh
deleted file mode 100755
index df0d48acf..000000000
--- a/testscripts/adp_test.sh
+++ /dev/null
@@ -1,6 +0,0 @@
-#!/bin/bash
-
-while :
-do
-	cat /proc/[0-9]*/cmdline > /dev/null 2>/dev/null
-done
-- 
2.19.2

