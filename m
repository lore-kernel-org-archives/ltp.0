From: Wei Jiangang <weijg.fnst@cn.fujitsu.com>
Date: Wed, 7 Oct 2015 09:45:35 +0800
Subject: [LTP] [PATCH v2 1/2] testscripts: make redirects happen in correct
	order
In-Reply-To: <20150930121613.GA8132@rei.suse.cz>
References: <20150930121613.GA8132@rei.suse.cz>
Message-ID: <1444182336-14628-1-git-send-email-weijg.fnst@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

It should redirect stdout to /dev/null firstly,
then redirect stderr to whatever stdout currently points at.

Signed-off-by: Wei Jiangang <weijg.fnst@cn.fujitsu.com>
---
 testscripts/ltpstress.sh   |  4 ++--
 testscripts/runEALtests.sh | 10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/testscripts/ltpstress.sh b/testscripts/ltpstress.sh
index 39a5caf..651d3da 100755
--- a/testscripts/ltpstress.sh
+++ b/testscripts/ltpstress.sh
@@ -265,10 +265,10 @@ fi
 ulimit -u unlimited
 
 if [ $PROC_NUM -gt 0 ];then
-  genload --vm $PROC_NUM --vm-bytes 1073741824 2>&1 1>/dev/null &
+  genload --vm $PROC_NUM --vm-bytes 1073741824 >/dev/null 2>&1 &
 fi
 if [ $leftover_memsize -gt 0 ];then
-  genload --vm 1 --vm-bytes $(($leftover_memsize * 1024)) 2>&1 1>/dev/null &
+  genload --vm 1 --vm-bytes $(($leftover_memsize * 1024)) >/dev/null 2>&1 &
 fi
 
 if [ $NO_NETWORK -eq 0 ];then
diff --git a/testscripts/runEALtests.sh b/testscripts/runEALtests.sh
index bcd3f29..a70bfad 100755
--- a/testscripts/runEALtests.sh
+++ b/testscripts/runEALtests.sh
@@ -84,7 +84,7 @@ fi
 while getopts cd:f:hi:l:m:Nnpqr:t:x arg
 do  case $arg in
     c)
-            $LTPROOT/../testcases/bin/genload --cpu 1 2>&1 1>/dev/null &
+            $LTPROOT/../testcases/bin/genload --cpu 1 >/dev/null 2>&1 &
 	    GenLoad=1 ;;
 
     d)      # append $$ to TMP, as it is recursively
@@ -97,9 +97,9 @@ do  case $arg in
 
     i)
             bytesize=$(($OPTARG * 1024 * 1024))
-            $LTPROOT/../testcases/bin/genload --io 1 2>&1 1>/dev/null &
+            $LTPROOT/../testcases/bin/genload --io 1 >/dev/null 2>&1 &
             $LTPROOT/../testcases/bin/genload --hdd 0 --hdd-bytes $bytesize \
-            2>&1 1>/dev/null &
+            >/dev/null 2>&1 &
 	    GenLoad=1 ;;
 
     l)
@@ -125,7 +125,7 @@ do  case $arg in
     m)
             memsize=$(($OPTARG * 1024 * 1024))
 	    $LTPROOT/../testcases/bin/genload  --vm 0 --vm-bytes $memsize\
-            2>&1 1>/dev/null &
+            >/dev/null 2>&1 &
 	    GenLoad=1;;
 
     N)	    run_netest=1;;
@@ -217,7 +217,7 @@ fi
 
 if [ $GenLoad -eq 1 ]
 then
-	killall -9 genload
+	killall -9 genload >/dev/null 2>&1
 fi
 
 if [ $NetPipe -eq 1 ]
-- 
1.9.3

