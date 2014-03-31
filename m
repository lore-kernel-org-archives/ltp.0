Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1WUbsV-0006qp-DC
	for ltp-list@lists.sourceforge.net; Mon, 31 Mar 2014 13:03:51 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WUbsT-00040C-HX
	for ltp-list@lists.sourceforge.net; Mon, 31 Mar 2014 13:03:51 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s2VD3g2r016390
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 31 Mar 2014 13:03:43 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s2VD3gGW014484
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Mon, 31 Mar 2014 13:03:42 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s2VD3gU8014476
	for <ltp-list@lists.sourceforge.net>; Mon, 31 Mar 2014 13:03:42 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Mon, 31 Mar 2014 17:03:35 +0400
Message-Id: <1396271016-18890-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH V2 1/2] ltpstress.sh: added a cmdline option to set
	temporary directory
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

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 testscripts/ltpstress.sh |   34 ++++++++++++++++++++++------------
 1 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/testscripts/ltpstress.sh b/testscripts/ltpstress.sh
index 49fc5a2..31cc553 100755
--- a/testscripts/ltpstress.sh
+++ b/testscripts/ltpstress.sh
@@ -36,7 +36,6 @@ if [ $? -eq 0 ]; then
  export LTPROOT=${PWD}
 fi
 export TMPBASE="/tmp"
-export TMP="${TMPBASE}/ltpstress-$$"
 export PATH=$LTPROOT/testcases/bin:$PATH
 memsize=0
 hours=24
@@ -57,7 +56,7 @@ usage()
 {
 
 	cat <<-END >&2
-	usage: ${0##*/} [ -d datafile ] [ -i # (in seconds) ] [ -I iofile ] [ -l logfile ] [ -m # (in Mb) ] [ -n ] [ -t duration ] [ [-S]|[-T] ]
+	usage: ${0##*/} [ -d datafile ] [ -i # (in seconds) ] [ -I iofile ] [ -l logfile ] [ -m # (in Mb) ] [ -n ] [ -t duration ] [ -x TMPDIR ] [ [-S]|[-T] ]
 
     -d datafile     Data file for 'sar' or 'top' to log to. Default is "/tmp/ltpstress.data".
     -i # (in sec)   Interval that 'sar' or 'top' should take snapshots. Default is 10 seconds.
@@ -68,6 +67,7 @@ usage()
     -S              Use 'sar' to measure data.
     -T              Use LTP's modified 'top' tool to measure data.
     -t duration     Execute the testsuite for given duration in hours. Default is 24.
+    -x TMPDIR       Directory where temporary files will be created.
 
 	example: ${0##*/} -d /tmp/sardata -l /tmp/ltplog.$$ -m 128 -t 24 -S
 	END
@@ -84,16 +84,7 @@ check_memsize()
   leftover_memsize=$memsize
 }
 
-
-mkdir -p ${TMP}
-
-cd ${TMP}
-if [ $? -ne 0 ]; then
-  echo "could not cd ${TMP} ... exiting"
-  exit
-fi
-
-while getopts d:hi:I:l:STt:m:n\? arg
+while getopts d:hi:I:l:STt:m:nx:\? arg
 do  case $arg in
 
 	d)	datafile="$OPTARG";;
@@ -137,11 +128,30 @@ do  case $arg in
         t)      hours=$OPTARG
 		duration=$(($hours * 60 * 60));;
 
+	x)	export TMPBASE=$(readlink -f ${OPTARG});;
+
         \?)     echo "Help info:"
 		usage;;
         esac
 done
 
+export TMP="${TMPBASE}/ltpstress-$$"
+export TMPDIR=${TMP}
+mkdir -p ${TMP}
+
+# to write as user nobody into tst_tmpdir()
+chmod 777 $TMP || \
+{
+	echo "unable to chmod 777 $TMP ... aborting"
+	exit 1
+}
+
+cd $TMP || \
+{
+	echo "could not cd ${TMP} ... exiting"
+	exit 1
+}
+
 if [ $NO_NETWORK -eq 0 ];then
   # Networking setup
   echo `hostname` >> /root/.rhosts
-- 
1.7.1


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
