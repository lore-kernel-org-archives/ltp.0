Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <lingyun.xie@bj.cs2c.com.cn>) id 1UwsRd-0004QA-F7
	for ltp-list@lists.sourceforge.net; Wed, 10 Jul 2013 11:20:25 +0000
Received: from regular2.263xmail.com ([211.157.152.3])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UwsRU-0004K1-8a
	for ltp-list@lists.sourceforge.net; Wed, 10 Jul 2013 11:20:25 +0000
Received: from regular1.263xmail.com (unknown [192.168.165.230])
	by regular2.263xmail.com (Postfix) with ESMTP id 442A588C3
	for <ltp-list@lists.sourceforge.net>;
	Wed, 10 Jul 2013 19:04:48 +0800 (CST)
From: Xie Lingyun <lingyun.xie@bj.cs2c.com.cn>
Date: Wed, 10 Jul 2013 19:03:20 +0800
Message-Id: <1373454200-8630-2-git-send-email-lingyun.xie@bj.cs2c.com.cn>
In-Reply-To: <1373454200-8630-1-git-send-email-lingyun.xie@bj.cs2c.com.cn>
References: <1373454200-8630-1-git-send-email-lingyun.xie@bj.cs2c.com.cn>
Subject: [LTP] [PATCH 2/2 v3] xinetd/xinetd_tests.sh: add IPv6 test for
	xinetd
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
To: liuhangbin@gmail.com
Cc: ltp-list@lists.sourceforge.net, Xie Lingyun <lingyun.xie@bj.cs2c.com.cn>

If IPv6 is enabled, telnet ::1 will be tested. Otherwise, IPv4 only.
The IPv6 test will be executed first and give a separate result.

Signed-off-by: Xie Lingyun <lingyun.xie@bj.cs2c.com.cn>
---
 testcases/network/xinetd/xinetd_tests.sh | 81 +++++++++++++++++++++++++++++---
 1 file changed, 75 insertions(+), 6 deletions(-)

diff --git a/testcases/network/xinetd/xinetd_tests.sh b/testcases/network/xinetd/xinetd_tests.sh
index ea89658..143ea76 100755
--- a/testcases/network/xinetd/xinetd_tests.sh
+++ b/testcases/network/xinetd/xinetd_tests.sh
@@ -84,11 +84,22 @@ init()
          return $RC
     fi
 
+    # sometimes the default telnet may be /usr/kerberos/bin/telnet
+    TELNET_COMM='/usr/bin/telnet'
+
     # check if commands tst_*, xinetd, awk exists.
     chk_ifexists INIT tst_resm   || return $RC
     chk_ifexists INIT xinetd     || return $RC
     chk_ifexists INIT diff       || return $RC
-    chk_ifexists INIT telnet     || return $RC
+    chk_ifexists INIT ip         || return $RC
+    chk_ifexists INIT $TELNET_COMM || return $RC
+
+    IPV6_ENABLED=0
+    ip a | grep inet6 > /dev/null 2>&1
+    if [ $? -eq 0 ]
+    then
+        IPV6_ENABLED=1
+    fi
 
     # Create custom xinetd.conf file.
     # tst_xinetd.conf.1 config file has telnet service disabled.
@@ -128,7 +139,7 @@ EOF
 
     # Create expected file with telnet disabled.
     cat > $LTPTMP/tst_xinetd.exp.1 <<-EOF || RC=$?
-telnet: Unable to connect to remote host: Connection refused
+telnet: connect to address 127.0.0.1: Connection refused
 EOF
 
     if [ $RC -ne 0 ]
@@ -138,10 +149,23 @@ EOF
         return $RC
     fi
 
+    if [ $IPV6_ENABLED -eq 1 ]
+    then
+        cat > $LTPTMP/tst_xinetd.exp.1.ipv6 <<-EOF || RC=$?
+telnet: connect to address ::1: Connection refused
+EOF
+
+        if [ $RC -ne 0 ]
+        then
+            tst_brkm TBROK NULL \
+                "INIT: unable to create expected file $LTPTMP/tst_xinetd.exp.1"
+        fi
+    fi
+
     # Create expected file with telnet enabled.
     cat > $LTPTMP/tst_xinetd.exp.2 <<-EOF || RC=$?
 Trying 127.0.0.1...
-Connected to localhost (127.0.0.1).
+Connected to 127.0.0.1.
 Escape character is '^]'.
 Connection closed by foreign host.
 EOF
@@ -149,10 +173,26 @@ EOF
     if [ $RC -ne 0 ]
     then
         tst_brkm TBROK  NULL \
-            "INIT: unable to create expected file $LTPTMP/tst_xinetd.exp.1"
+            "INIT: unable to create expected file $LTPTMP/tst_xinetd.exp.2"
         return $RC
     fi
 
+    if [ $IPV6_ENABLED -eq 1 ]
+    then
+        cat > $LTPTMP/tst_xinetd.exp.2.ipv6 <<-EOF || RC=$?
+Trying ::1...
+Connected to ::1.
+Escape character is '^]'.
+Connection closed by foreign host.
+EOF
+
+        if [ $RC -ne 0 ]
+        then
+            tst_brkm TBROK NULL \
+                "INIT: unable to create expected file $LTPTMP/tst_xinetd.exp.2.ipv6"
+        fi
+    fi
+
     return $RC
 }
 
@@ -263,7 +303,20 @@ test01()
 
     # Not checking for exit code from telnet command because telnet is
     # not terminated by the test gracefully.
-    echo "" | telnet localhost 2>$LTPTMP/tst_xinetd.out 1>/dev/null
+    if [ $IPV6_ENABLED -eq 1 ]
+    then
+        echo "" | $TELNET_COMM ::1 2>$LTPTMP/tst_xinetd.out.ipv6 1>/dev/null
+        diff -iwB $LTPTMP/tst_xinetd.out.ipv6  $LTPTMP/tst_xinetd.exp.1.ipv6 \
+            > $LTPTMP/tst_xinetd.err.ipv6 2>&1 || RC=$?
+        if [ $RC -ne 0 ]
+        then
+            tst_res TFAIL $LTPTMP/tst_xinetd.err.ipv6 \
+                "Test #1: with telnet diabled expected out differs RC=$RC. Details:"
+            return $RC
+        fi
+    fi
+
+    echo "" | $TELNET_COMM 127.0.0.1 2>$LTPTMP/tst_xinetd.out 1>/dev/null
     diff -iwB $LTPTMP/tst_xinetd.out  $LTPTMP/tst_xinetd.exp.1 \
         > $LTPTMP/tst_xinetd.err 2>&1 || RC=$?
     if [ $RC -ne 0 ]
@@ -312,7 +365,23 @@ test01()
 
     # Not checking for exit code from telnet command because telnet is
     # not terminated by the test gracefully.
-    echo "" | telnet localhost > $LTPTMP/tst_xinetd.out 2>&1
+    if [ $IPV6_ENABLED -eq 1 ]
+    then
+        echo "" | $TELNET_COMM ::1 >$LTPTMP/tst_xinetd.out.ipv6 2>&1
+        diff -iwB $LTPTMP/tst_xinetd.out.ipv6  $LTPTMP/tst_xinetd.exp.2.ipv6 \
+            > $LTPTMP/tst_xinetd.err.ipv6 2>&1 || RC=$?
+        if [ $RC -ne 0 ]
+        then
+            tst_res TFAIL $LTPTMP/tst_xinetd.err.ipv6 \
+                "Test #1: with telnet diabled expected out differs RC=$RC. Details:"
+            return $RC
+        else
+            tst_resm TPASS \
+            "Test #1: xinetd reads the config file and starts or stops IPv6 services."
+        fi
+    fi
+
+    echo "" | $TELNET_COMM 127.0.0.1 > $LTPTMP/tst_xinetd.out 2>&1
 
     diff -iwB $LTPTMP/tst_xinetd.out  $LTPTMP/tst_xinetd.exp.2 \
         > $LTPTMP/tst_xinetd.err 2>&1 || RC=$?
-- 
1.8.3.1



------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
