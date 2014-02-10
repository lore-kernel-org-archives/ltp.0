Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1WCnQt-0000E9-3F
	for ltp-list@lists.sourceforge.net; Mon, 10 Feb 2014 09:45:43 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WCnQs-00063I-DY
	for ltp-list@lists.sourceforge.net; Mon, 10 Feb 2014 09:45:43 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s1A9jZBE032337
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 10 Feb 2014 09:45:36 GMT
Received: from userz7022.oracle.com (userz7022.oracle.com [156.151.31.86])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s1A9jZ6a024361
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Mon, 10 Feb 2014 09:45:35 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
	by userz7022.oracle.com (8.14.5+Sun/8.14.4) with ESMTP id
	s1A9jZ7A008627
	for <ltp-list@lists.sourceforge.net>; Mon, 10 Feb 2014 09:45:35 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Mon, 10 Feb 2014 13:45:28 +0400
Message-Id: <1392025529-10948-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH] mc_cmds: Set TCID and TST_-variables and use TMPDIR
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
 testcases/network/multicast/mc_cmds/mc_cmds |   17 +++++++++++++++--
 1 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/testcases/network/multicast/mc_cmds/mc_cmds b/testcases/network/multicast/mc_cmds/mc_cmds
index 180e93f..54fc69c 100755
--- a/testcases/network/multicast/mc_cmds/mc_cmds
+++ b/testcases/network/multicast/mc_cmds/mc_cmds
@@ -35,9 +35,20 @@
 $trace_logic
 
 TC=mc_cmds
-PING_OUT=/tmp/${TC}_out
+TCtmp=${TCtmp:-$TMPDIR/$TC$$}
+PING_OUT=${TCtmp}/PING_OUT
 HOSTNAME=`hostname`
 CLEANUP=${CLEANUP:-ON}
+
+export TCID=$TC
+export TST_TOTAL=1
+export TST_COUNT=1
+
+setup()
+{
+   mkdir -p $TCtmp || { tst_brkm TBROK NULL "Could not create $TCtmp"; exit 1; }
+}
+
 #*******************************************************************************
 #
 # FUNCTION:  do_test
@@ -119,6 +130,7 @@ for eth in $IFNAME
    if [ $? -eq 0 ]
    then
        tst_resm TCONF "Multicast ping disabled on this system (this is normal on post year:2005 kernels)"
+       rm -rf $TCtmp
        exit 0
    fi
 
@@ -158,7 +170,7 @@ do_cleanup()
 {
    $trace_logic
    echo "$this_file: doing $0."
-   rm -rf $PING_OUT
+   rm -rf $TCtmp
 }
 
 #=============================================================================
@@ -193,5 +205,6 @@ end_testcase()
 # OUTPUT:    Logged run results written to testcase run log
 #
 #*******************************************************************************
+setup
 do_test
 end_testcase
-- 
1.7.1


------------------------------------------------------------------------------
Managing the Performance of Cloud-Based Applications
Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
Read the Whitepaper.
http://pubads.g.doubleclick.net/gampad/clk?id=121051231&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
