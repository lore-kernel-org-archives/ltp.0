Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1WUbsV-0000M6-83
	for ltp-list@lists.sourceforge.net; Mon, 31 Mar 2014 13:03:51 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WUbsU-0001am-DJ
	for ltp-list@lists.sourceforge.net; Mon, 31 Mar 2014 13:03:51 +0000
Received: from ucsinet22.oracle.com (ucsinet22.oracle.com [156.151.31.94])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s2VD3itY016411
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 31 Mar 2014 13:03:44 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by ucsinet22.oracle.com (8.14.5+Sun/8.14.5) with ESMTP id
	s2VD3hM8016624
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Mon, 31 Mar 2014 13:03:44 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s2VD3hX9014566
	for <ltp-list@lists.sourceforge.net>; Mon, 31 Mar 2014 13:03:43 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Mon, 31 Mar 2014 17:03:36 +0400
Message-Id: <1396271016-18890-2-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1396271016-18890-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1396271016-18890-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH V2 2/2] ltpstress.sh: explicit passing of -p and -q
	ltp-pan parameters
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: vasily.isaenko@oracle.com

Added cmdline options to pass -p and/or -q arguments to the
ltp-pan instances. The same way as runltp does.

It's needed if we parse the output of the ltp-pans by scripts.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 testscripts/ltpstress.sh |   25 +++++++++++++++++++------
 1 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/testscripts/ltpstress.sh b/testscripts/ltpstress.sh
index 31cc553..0ce01a4 100755
--- a/testscripts/ltpstress.sh
+++ b/testscripts/ltpstress.sh
@@ -50,13 +50,15 @@ Sar=0
 Top=0
 Iostat=0
 LOGGING=0
+PRETTY_PRT=""
+QUIET_MODE=""
 NO_NETWORK=0
 
 usage()
 {
 
 	cat <<-END >&2
-	usage: ${0##*/} [ -d datafile ] [ -i # (in seconds) ] [ -I iofile ] [ -l logfile ] [ -m # (in Mb) ] [ -n ] [ -t duration ] [ -x TMPDIR ] [ [-S]|[-T] ]
+	usage: ${0##*/} [ -d datafile ] [ -i # (in seconds) ] [ -I iofile ] [ -l logfile ] [ -m # (in Mb) ] [ -n ] [ -p ] [ -q ] [ -t duration ] [ -x TMPDIR ] [ [-S]|[-T] ]
 
     -d datafile     Data file for 'sar' or 'top' to log to. Default is "/tmp/ltpstress.data".
     -i # (in sec)   Interval that 'sar' or 'top' should take snapshots. Default is 10 seconds.
@@ -64,6 +66,8 @@ usage()
     -l logfile      Log results of test in a logfile. Default is "/tmp/ltpstress.log"
     -m # (in Mb)    Specify the _minimum_ memory load of # megabytes in background. Default is all the RAM + 1/2 swap.
     -n              Disable networking stress.
+    -p              Human readable format logfiles.
+    -q              Print less verbose output to the output files.
     -S              Use 'sar' to measure data.
     -T              Use LTP's modified 'top' tool to measure data.
     -t duration     Execute the testsuite for given duration in hours. Default is 24.
@@ -84,7 +88,7 @@ check_memsize()
   leftover_memsize=$memsize
 }
 
-while getopts d:hi:I:l:STt:m:nx:\? arg
+while getopts d:hi:I:l:STt:m:npqx:\? arg
 do  case $arg in
 
 	d)	datafile="$OPTARG";;
@@ -105,6 +109,10 @@ do  case $arg in
 
 	n)	NO_NETWORK=1;;
 
+	p)	PRETTY_PRT=" -p ";;
+
+	q)	QUIET_MODE=" -q ";;
+
         S)      if [ $Top -eq 0 ]; then
                   Sar=1
                 else
@@ -285,9 +293,9 @@ output1=${TMPBASE}/ltpstress.$$.output1
 output2=${TMPBASE}/ltpstress.$$.output2
 output3=${TMPBASE}/ltpstress.$$.output3
 
-${LTPROOT}/bin/ltp-pan -e -p -q -S -t ${hours}h -a stress1 -n stress1 -l $logfile -f ${TMP}/stress.part1 -o $output1 &
-${LTPROOT}/bin/ltp-pan -e -p -q -S -t ${hours}h -a stress2 -n stress2 -l $logfile -f ${TMP}/stress.part2 -o $output2 &
-${LTPROOT}/bin/ltp-pan -e -p -q -S -t ${hours}h -a stress3 -n stress3 -l $logfile -f ${TMP}/stress.part3 -o $output3 &
+${LTPROOT}/bin/ltp-pan -e ${PRETTY_PRT} ${QUIET_MODE} -S -t ${hours}h -a stress1 -n stress1 -l $logfile -f ${TMP}/stress.part1 -o $output1 &
+${LTPROOT}/bin/ltp-pan -e ${PRETTY_PRT} ${QUIET_MODE} -S -t ${hours}h -a stress2 -n stress2 -l $logfile -f ${TMP}/stress.part2 -o $output2 &
+${LTPROOT}/bin/ltp-pan -e ${PRETTY_PRT} ${QUIET_MODE} -S -t ${hours}h -a stress3 -n stress3 -l $logfile -f ${TMP}/stress.part3 -o $output3 &
 
 echo "Running LTP Stress for $hours hour(s) using $(($memsize/1024)) Mb"
 echo ""
@@ -317,7 +325,12 @@ fi
 rm -rf ${TMP}
 echo "Testing done"
 if [ $LOGGING -eq 1 ];then
-  grep FAIL $logfile >/dev/null 2>&1
+  if [ ! -z $PRETTY_PRT ]; then
+    grep FAIL $logfile > /dev/null 2>&1
+  else
+    grep 'stat=' $logfile | grep -v 'stat=0' > /dev/null 2>&1
+  fi
+
   if [ $? -eq 1 ]; then
     echo "All Tests PASSED!"
   else
-- 
1.7.1


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
