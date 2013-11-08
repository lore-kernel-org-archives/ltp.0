Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xu.simon@oracle.com>) id 1Vecb8-0001kG-9n
	for ltp-list@lists.sourceforge.net; Fri, 08 Nov 2013 03:19:02 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Vecb6-0001oZ-4Q
	for ltp-list@lists.sourceforge.net; Fri, 08 Nov 2013 03:19:02 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by userp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id rA83Irmi010008
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 8 Nov 2013 03:18:54 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rA83IqVA002914
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Fri, 8 Nov 2013 03:18:53 GMT
Received: from abhmt105.oracle.com (abhmt105.oracle.com [141.146.116.57])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rA83Ipdm003013
	for <ltp-list@lists.sourceforge.net>; Fri, 8 Nov 2013 03:18:51 GMT
From: Simon Xu <xu.simon@oracle.com>
Date: Fri,  8 Nov 2013 11:18:47 +0800
Message-Id: <1383880727-723-1-git-send-email-xu.simon@oracle.com>
In-Reply-To: <20131107161433.GB9653@rei.Home>
References: <20131107161433.GB9653@rei.Home>
Subject: [LTP] [PATCH V2] xinetd_tests.sh: remove RECORD and eliminate "||
	RC=$?"
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

1) In xinetd.conf, `RECORD' is not a valid value for entry `log_on_failure'
   (I couldn't find a distro in which it's valid), and it makes xinetd
   successfully starts and promptly exit with error message:

   "Bad log_on_failure flag: RECORD [file=/etc/xinetd.conf] [line=6]",

   but the test will pass because telnet service is not started and that's
   what it expect.

2) Eliminate '|| RC=$?' because because it may not be excecuted and the
   original value in RC can mess things up.  Also remove the RC=0
   initializations that are now unnecessary.

Signed-off-by: Simon Xu <xu.simon@oracle.com>
---
 testcases/network/xinetd/xinetd_tests.sh | 74 +++++++++++++++++++-------------
 1 file changed, 43 insertions(+), 31 deletions(-)

diff --git a/testcases/network/xinetd/xinetd_tests.sh b/testcases/network/xinetd/xinetd_tests.sh
index a607d32..5024280 100755
--- a/testcases/network/xinetd/xinetd_tests.sh
+++ b/testcases/network/xinetd/xinetd_tests.sh
@@ -39,9 +39,8 @@
 #               - non-zero on failure.
 chk_ifexists()
 {
-    RC=0
-
-    which $2 > $LTPTMP/tst_xinetd.err 2>&1 || RC=$?
+    which $2 > $LTPTMP/tst_xinetd.err 2>&1
+    RC=$?
     if [ $RC -ne 0 ]
     then
         tst_brkm TBROK NULL "$1: command $2 not found."
@@ -61,7 +60,6 @@ chk_ifexists()
 init()
 {
     # Initialize global variables.
-    export RC=0
     export TST_TOTAL=2
     export TCID="xinetd"
     export TST_COUNT=0
@@ -77,7 +75,8 @@ init()
         LTPTMP=$TMP/tst_xinetd.$$
     fi
 
-    mkdir -p $LTPTMP > /dev/null 2>&1 || RC=$?
+    mkdir -p $LTPTMP > /dev/null 2>&1
+    RC=$?
     if [ $RC -ne 0 ]
     then
          tst_brkm TBROK NULL "INIT: Unable to create temporary directory"
@@ -103,19 +102,20 @@ init()
 
     # Create custom xinetd.conf file.
     # tst_xinetd.conf.1 config file has telnet service disabled.
-    cat > $LTPTMP/tst_xinetd.conf.1 <<-EOF || RC=$?
+    cat > $LTPTMP/tst_xinetd.conf.1 <<-EOF
 defaults
 {
     instances      = 25
     log_type       = FILE /var/log/servicelog
     log_on_success = HOST PID
-    log_on_failure = HOST RECORD
+    log_on_failure = HOST
     disabled       = telnet
 }
 EOF
+RC=$?
 
     # tst_xinetd.conf.2 config file has telnet enabled.
-    cat > $LTPTMP/tst_xinetd.conf.2 <<-EOF || RC=$?
+    cat > $LTPTMP/tst_xinetd.conf.2 <<-EOF
 defaults
 {
     instances      = 25
@@ -136,11 +136,13 @@ service telnet
     no_access       =
 }
 EOF
+RC=$?
 
     # Create expected file with telnet disabled.
-    cat > $LTPTMP/tst_xinetd.exp.1 <<-EOF || RC=$?
+    cat > $LTPTMP/tst_xinetd.exp.1 <<-EOF
 telnet: connect to address 127.0.0.1: Connection refused
 EOF
+RC=$?
 
     if [ $RC -ne 0 ]
     then
@@ -151,9 +153,10 @@ EOF
 
     if [ $IPV6_ENABLED -eq 1 ]
     then
-        cat > $LTPTMP/tst_xinetd.exp.1.ipv6 <<-EOF || RC=$?
+        cat > $LTPTMP/tst_xinetd.exp.1.ipv6 <<-EOF
 telnet: connect to address ::1: Connection refused
 EOF
+RC=$?
 
         if [ $RC -ne 0 ]
         then
@@ -163,12 +166,13 @@ EOF
     fi
 
     # Create expected file with telnet enabled.
-    cat > $LTPTMP/tst_xinetd.exp.2 <<-EOF || RC=$?
+    cat > $LTPTMP/tst_xinetd.exp.2 <<-EOF
 Trying 127.0.0.1...
 Connected to 127.0.0.1.
 Escape character is '^]'.
 Connection closed by foreign host.
 EOF
+RC=$?
 
     if [ $RC -ne 0 ]
     then
@@ -179,12 +183,13 @@ EOF
 
     if [ $IPV6_ENABLED -eq 1 ]
     then
-        cat > $LTPTMP/tst_xinetd.exp.2.ipv6 <<-EOF || RC=$?
+        cat > $LTPTMP/tst_xinetd.exp.2.ipv6 <<-EOF
 Trying ::1...
 Connected to ::1.
 Escape character is '^]'.
 Connection closed by foreign host.
 EOF
+RC=$?
 
         if [ $RC -ne 0 ]
         then
@@ -205,12 +210,12 @@ EOF
 #               - non-zero on failure.
 cleanup()
 {
-    RC=0
     # restore the original xinetd.conf if a back up exits.
     if [ -f /etc/xinetd.conf.orig ]
     then
         mv /etc/xinetd.conf.orig /etc/xinetd.conf \
-            > $LTPTMP/tst_xinetd.err 2>&1 || RC=$?
+            > $LTPTMP/tst_xinetd.err 2>&1
+        RC=$?
         if [ $RC -ne 0 ]
         then
             tst_res TINFO $LTPTMP/tst_xinetd.err \
@@ -220,7 +225,8 @@ cleanup()
         sleep 1s
 
         # restoring original services
-        /etc/init.d/xinetd restart > $LTPTMP/tst_xinetd.err 2>&1 || RC=$?
+        /etc/init.d/xinetd restart > $LTPTMP/tst_xinetd.err 2>&1
+        RC=$?
         if [ $RC -ne 0 ]
         then
             tst_res TINFO $LTPTMP/tst_xinetd.err \
@@ -250,13 +256,12 @@ test01()
     TCID=xinetd01
     TST_COUNT=1
     nhops=0             # Number of hops required to get to host.
-    RC=0                # Return value from commands.
 
     tst_resm TINFO "Test #1: restart xinetd with telnet disabled."
 
     # create a backup of the original xinetd.conf file.
-    mv /etc/xinetd.conf /etc/xinetd.conf.orig > $LTPTMP/tst_xinetd.err 2>&1 \
-        || RC=$?
+    mv /etc/xinetd.conf /etc/xinetd.conf.orig > $LTPTMP/tst_xinetd.err 2>&1
+    RC=$?
     if [ $RC -ne 0 ]
     then
         tst_brk TBROK $LTPTMP/tst_xinetd.err NULL \
@@ -265,8 +270,8 @@ test01()
     fi
 
     # install the new config file with telnet disabled.
-    mv $LTPTMP/tst_xinetd.conf.1 /etc/xinetd.conf > $LTPTMP/tst_xinetd.err 2>&1 \
-        || RC=$?
+    mv $LTPTMP/tst_xinetd.conf.1 /etc/xinetd.conf > $LTPTMP/tst_xinetd.err 2>&1
+    RC=$?
     if [ $RC -ne 0 ]
     then
         tst_brk TBROK $LTPTMP/tst_xinetd.err NULL \
@@ -279,7 +284,8 @@ test01()
     sleep 1s
 
     # restart xinetd to re-start the services
-    /etc/init.d/xinetd restart > $LTPTMP/tst_xinetd.out 2>&1 || RC=$?
+    /etc/init.d/xinetd restart > $LTPTMP/tst_xinetd.out 2>&1
+    RC=$?
     if [ $RC -ne 0 ]
     then
         tst_res TFAIL $LTPTMP/tst_xinetd.out \
@@ -288,7 +294,8 @@ test01()
     else
         # even if xinetd restart has zero exit value,
         # make certain there was no failure.
-        grep -i "fail" $LTPTMP/tst_xinetd.out > $LTPTMP/tst_xinetd.err 2>&1 || RC=$?
+        grep -i "fail" $LTPTMP/tst_xinetd.out > $LTPTMP/tst_xinetd.err 2>&1
+        RC=$?
         if [ $RC -eq 0 ]
         then
             tst_res TFAIL $LTPTMP/tst_xinetd.err \
@@ -307,7 +314,8 @@ test01()
     then
         echo "" | $TELNET_COMM ::1 2>$LTPTMP/tst_xinetd.out.ipv6 1>/dev/null
         diff -iwB $LTPTMP/tst_xinetd.out.ipv6  $LTPTMP/tst_xinetd.exp.1.ipv6 \
-            > $LTPTMP/tst_xinetd.err.ipv6 2>&1 || RC=$?
+            > $LTPTMP/tst_xinetd.err.ipv6 2>&1
+        RC=$?
         if [ $RC -ne 0 ]
         then
             tst_res TFAIL $LTPTMP/tst_xinetd.err.ipv6 \
@@ -318,7 +326,8 @@ test01()
 
     echo "" | $TELNET_COMM 127.0.0.1 2>$LTPTMP/tst_xinetd.out 1>/dev/null
     diff -iwB $LTPTMP/tst_xinetd.out  $LTPTMP/tst_xinetd.exp.1 \
-        > $LTPTMP/tst_xinetd.err 2>&1 || RC=$?
+        > $LTPTMP/tst_xinetd.err 2>&1
+    RC=$?
     if [ $RC -ne 0 ]
     then
         tst_res TFAIL $LTPTMP/tst_xinetd.err \
@@ -328,8 +337,8 @@ test01()
 
     tst_resm TINFO "Test #1: restart xinetd with telnet enabled."
     # install the xinetd config file with telnet enabled.
-    mv $LTPTMP/tst_xinetd.conf.2 /etc/xinetd.conf > $LTPTMP/tst_xinetd.err 2>&1 \
-        || RC=$?
+    mv $LTPTMP/tst_xinetd.conf.2 /etc/xinetd.conf > $LTPTMP/tst_xinetd.err 2>&1
+    RC=$?
     if [ $RC -ne 0 ]
     then
         tst_brk TBROK $LTPTMP/tst_xinetd.err NULL \
@@ -342,7 +351,8 @@ test01()
     sleep 1s
 
     # restart services.
-    /etc/init.d/xinetd restart > $LTPTMP/tst_xinetd.out 2>&1 || RC=$?
+    /etc/init.d/xinetd restart > $LTPTMP/tst_xinetd.out 2>&1
+    RC=$?
     if [ $RC -ne 0 ]
     then
         tst_res TFAIL $LTPTMP/tst_xinetd.out \
@@ -350,7 +360,8 @@ test01()
         return $RC
     else
         # even if restart has a zero exit value double check for failure.
-        grep -i "fail" $LTPTMP/tst_xinetd.out > $LTPTMP/tst_xinetd.err 2>&1 || RC=$?
+        grep -i "fail" $LTPTMP/tst_xinetd.out > $LTPTMP/tst_xinetd.err 2>&1
+        RC=$?
         if [ $RC -eq 0 ]
         then
             tst_res TFAIL $LTPTMP/tst_xinetd.err \
@@ -369,7 +380,8 @@ test01()
     then
         echo "" | $TELNET_COMM ::1 >$LTPTMP/tst_xinetd.out.ipv6 2>&1
         diff -iwB $LTPTMP/tst_xinetd.out.ipv6  $LTPTMP/tst_xinetd.exp.2.ipv6 \
-            > $LTPTMP/tst_xinetd.err.ipv6 2>&1 || RC=$?
+            > $LTPTMP/tst_xinetd.err.ipv6 2>&1
+        RC=$?
         if [ $RC -ne 0 ]
         then
             tst_res TFAIL $LTPTMP/tst_xinetd.err.ipv6 \
@@ -384,7 +396,8 @@ test01()
     echo "" | $TELNET_COMM 127.0.0.1 > $LTPTMP/tst_xinetd.out 2>&1
 
     diff -iwB $LTPTMP/tst_xinetd.out  $LTPTMP/tst_xinetd.exp.2 \
-        > $LTPTMP/tst_xinetd.err 2>&1 || RC=$?
+        > $LTPTMP/tst_xinetd.err 2>&1
+    RC=$?
     if [ $RC -ne 0 ]
     then
         tst_res TFAIL $LTPTMP/tst_xinetd.err \
@@ -406,7 +419,6 @@ test01()
 # Exit:            - zero on success
 #               - non-zero on failure.
 
-RC=0
 init || exit $?
 
 test01 || RC=$?
-- 
1.8.4.2


------------------------------------------------------------------------------
November Webinars for C, C++, Fortran Developers
Accelerate application performance with scalable programming models. Explore
techniques for threading, error checking, porting, and tuning. Get the most 
from the latest Intel processors and coprocessors. See abstracts and register
http://pubads.g.doubleclick.net/gampad/clk?id=60136231&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
