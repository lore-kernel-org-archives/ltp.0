Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <lingyun.xie@bj.cs2c.com.cn>) id 1UwsRm-00048Z-LM
	for ltp-list@lists.sourceforge.net; Wed, 10 Jul 2013 11:20:34 +0000
Received: from regular2.263xmail.com ([211.157.152.4])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UwsRe-0003Ry-1p
	for ltp-list@lists.sourceforge.net; Wed, 10 Jul 2013 11:20:34 +0000
Received: from regular1.263xmail.com (unknown [192.168.165.234])
	by regular2.263xmail.com (Postfix) with ESMTP id B029B163C55
	for <ltp-list@lists.sourceforge.net>;
	Wed, 10 Jul 2013 19:04:48 +0800 (CST)
From: Xie Lingyun <lingyun.xie@bj.cs2c.com.cn>
Date: Wed, 10 Jul 2013 19:03:19 +0800
Message-Id: <1373454200-8630-1-git-send-email-lingyun.xie@bj.cs2c.com.cn>
Subject: [LTP] [PATCH 1/2 v3] xinetd/xinetd_tests.sh: cleanup tabs
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

replace tabs with 4 spaces.
The echo <<-EOF lines become no indentation.

Signed-off-by: Xie Lingyun <lingyun.xie@bj.cs2c.com.cn>
---
 testcases/network/xinetd/xinetd_tests.sh | 246 +++++++++++++++----------------
 1 file changed, 123 insertions(+), 123 deletions(-)

diff --git a/testcases/network/xinetd/xinetd_tests.sh b/testcases/network/xinetd/xinetd_tests.sh
index 83eb8a7..ea89658 100755
--- a/testcases/network/xinetd/xinetd_tests.sh
+++ b/testcases/network/xinetd/xinetd_tests.sh
@@ -90,46 +90,46 @@ init()
     chk_ifexists INIT diff       || return $RC
     chk_ifexists INIT telnet     || return $RC
 
-	# Create custom xinetd.conf file.
-	# tst_xinetd.conf.1 config file has telnet service disabled.
-	cat > $LTPTMP/tst_xinetd.conf.1 <<-EOF || RC=$?
-	defaults
-	{
-		instances      = 25
-		log_type       = FILE /var/log/servicelog
-		log_on_success = HOST PID
-		log_on_failure = HOST RECORD
-	    disabled       = telnet
-	}
-	EOF
-
-	# tst_xinetd.conf.2 config file has telnet enabled.
-	cat > $LTPTMP/tst_xinetd.conf.2 <<-EOF || RC=$?
-	defaults
-	{
-		instances      = 25
-		log_type       = FILE /var/log/servicelog
-		log_on_success = HOST PID
-		log_on_failure = HOST
-		# disabled       = telnet
-	}
-
-	service telnet
-	{
-        socket_type     = stream
-        protocol        = tcp
-        wait            = no
-        user            = root
-        server          = /usr/sbin/in.telnetd
-        server_args     = -n
-        no_access       =
-    }
-	EOF
+    # Create custom xinetd.conf file.
+    # tst_xinetd.conf.1 config file has telnet service disabled.
+    cat > $LTPTMP/tst_xinetd.conf.1 <<-EOF || RC=$?
+defaults
+{
+instances      = 25
+log_type       = FILE /var/log/servicelog
+log_on_success = HOST PID
+log_on_failure = HOST RECORD
+disabled       = telnet
+}
+EOF
+
+    # tst_xinetd.conf.2 config file has telnet enabled.
+    cat > $LTPTMP/tst_xinetd.conf.2 <<-EOF || RC=$?
+defaults
+{
+instances      = 25
+log_type       = FILE /var/log/servicelog
+log_on_success = HOST PID
+log_on_failure = HOST
+# disabled       = telnet
+}
+
+service telnet
+{
+socket_type     = stream
+protocol        = tcp
+wait            = no
+user            = root
+server          = /usr/sbin/in.telnetd
+server_args     = -n
+no_access       =
+}
+EOF
 
     # Create expected file with telnet disabled.
     cat > $LTPTMP/tst_xinetd.exp.1 <<-EOF || RC=$?
-	telnet: Unable to connect to remote host: Connection refused
-	EOF
+telnet: Unable to connect to remote host: Connection refused
+EOF
 
     if [ $RC -ne 0 ]
     then
@@ -139,12 +139,12 @@ init()
     fi
 
     # Create expected file with telnet enabled.
-	cat > $LTPTMP/tst_xinetd.exp.2 <<-EOF || RC=$?
-	Trying 127.0.0.1...
-	Connected to localhost (127.0.0.1).
-	Escape character is '^]'.
-	Connection closed by foreign host.
-	EOF
+    cat > $LTPTMP/tst_xinetd.exp.2 <<-EOF || RC=$?
+Trying 127.0.0.1...
+Connected to localhost (127.0.0.1).
+Escape character is '^]'.
+Connection closed by foreign host.
+EOF
 
     if [ $RC -ne 0 ]
     then
@@ -165,28 +165,28 @@ init()
 #               - non-zero on failure.
 cleanup()
 {
-	RC=0
-	# restore the original xinetd.conf if a back up exits.
-	if [ -f /etc/xinetd.conf.orig ]
-	then
-		mv /etc/xinetd.conf.orig /etc/xinetd.conf \
-			> $LTPTMP/tst_xinetd.err 2>&1 || RC=$?
-		if [ $RC -ne 0 ]
-		then
-			tst_res TINFO $LTPTMP/tst_xinetd.err \
-			"CLEANUP: failed restoring original xinetd.conf RC=$RC. Details:"
-		fi
-
-		sleep 1s
-
-		# restoring original services
-		/etc/init.d/xinetd restart > $LTPTMP/tst_xinetd.err 2>&1 || RC=$?
-		if [ $RC -ne 0 ]
-		then
-			tst_res TINFO $LTPTMP/tst_xinetd.err \
-			"CLEANUP: failed restoring original services RC=$RC. Details:"
-		fi
-	fi
+    RC=0
+    # restore the original xinetd.conf if a back up exits.
+    if [ -f /etc/xinetd.conf.orig ]
+    then
+        mv /etc/xinetd.conf.orig /etc/xinetd.conf \
+            > $LTPTMP/tst_xinetd.err 2>&1 || RC=$?
+        if [ $RC -ne 0 ]
+        then
+            tst_res TINFO $LTPTMP/tst_xinetd.err \
+            "CLEANUP: failed restoring original xinetd.conf RC=$RC. Details:"
+        fi
+
+        sleep 1s
+
+        # restoring original services
+        /etc/init.d/xinetd restart > $LTPTMP/tst_xinetd.err 2>&1 || RC=$?
+        if [ $RC -ne 0 ]
+        then
+            tst_res TINFO $LTPTMP/tst_xinetd.err \
+            "CLEANUP: failed restoring original services RC=$RC. Details:"
+        fi
+    fi
 
     # remove all the temporary files created by this test.
     tst_resm TINFO "CLEAN: removing $LTPTMP"
@@ -214,9 +214,9 @@ test01()
 
     tst_resm TINFO "Test #1: restart xinetd with telnet disabled."
 
-	# create a backup of the original xinetd.conf file.
-	mv /etc/xinetd.conf /etc/xinetd.conf.orig > $LTPTMP/tst_xinetd.err 2>&1 \
-		|| RC=$?
+    # create a backup of the original xinetd.conf file.
+    mv /etc/xinetd.conf /etc/xinetd.conf.orig > $LTPTMP/tst_xinetd.err 2>&1 \
+        || RC=$?
     if [ $RC -ne 0 ]
     then
         tst_brk TBROK $LTPTMP/tst_xinetd.err NULL \
@@ -224,9 +224,9 @@ test01()
         return $RC
     fi
 
-	# install the new config file with telnet disabled.
-	mv $LTPTMP/tst_xinetd.conf.1 /etc/xinetd.conf > $LTPTMP/tst_xinetd.err 2>&1 \
-		|| RC=$?
+    # install the new config file with telnet disabled.
+    mv $LTPTMP/tst_xinetd.conf.1 /etc/xinetd.conf > $LTPTMP/tst_xinetd.err 2>&1 \
+        || RC=$?
     if [ $RC -ne 0 ]
     then
         tst_brk TBROK $LTPTMP/tst_xinetd.err NULL \
@@ -236,36 +236,36 @@ test01()
 
     tst_resm TINFO "Test #1: new xinetd.conf installed with telnet disabled."
 
-	sleep 1s
+    sleep 1s
 
-	# restart xinetd to re-start the services
+    # restart xinetd to re-start the services
     /etc/init.d/xinetd restart > $LTPTMP/tst_xinetd.out 2>&1 || RC=$?
     if [ $RC -ne 0 ]
     then
         tst_res TFAIL $LTPTMP/tst_xinetd.out \
        "Test #1: unable to restart service with telnet disabled. Details:"
         return $RC
-	else
-		# even if xinetd restart has zero exit value,
-		# make certain there was no failure.
-		grep -i "fail" $LTPTMP/tst_xinetd.out > $LTPTMP/tst_xinetd.err 2>&1 || RC=$?
-		if [ $RC -eq 0 ]
-		then
-			tst_res TFAIL $LTPTMP/tst_xinetd.err \
-				"Test #1: xinetd failed to restart. Details"
-			return $RC
-		else
-			RC=0
-			tst_resm TINFO \
-				"Test #1: xinetd re-started successfully with telnet disabled."
-		fi
-	fi
-
-	# Not checking for exit code from telnet command because telnet is
-	# not terminated by the test gracefully.
-	echo "" | telnet localhost 2>$LTPTMP/tst_xinetd.out 1>/dev/null
-	diff -iwB $LTPTMP/tst_xinetd.out  $LTPTMP/tst_xinetd.exp.1 \
-		> $LTPTMP/tst_xinetd.err 2>&1 || RC=$?
+    else
+        # even if xinetd restart has zero exit value,
+        # make certain there was no failure.
+        grep -i "fail" $LTPTMP/tst_xinetd.out > $LTPTMP/tst_xinetd.err 2>&1 || RC=$?
+        if [ $RC -eq 0 ]
+        then
+            tst_res TFAIL $LTPTMP/tst_xinetd.err \
+                "Test #1: xinetd failed to restart. Details"
+            return $RC
+        else
+            RC=0
+            tst_resm TINFO \
+                "Test #1: xinetd re-started successfully with telnet disabled."
+        fi
+    fi
+
+    # Not checking for exit code from telnet command because telnet is
+    # not terminated by the test gracefully.
+    echo "" | telnet localhost 2>$LTPTMP/tst_xinetd.out 1>/dev/null
+    diff -iwB $LTPTMP/tst_xinetd.out  $LTPTMP/tst_xinetd.exp.1 \
+        > $LTPTMP/tst_xinetd.err 2>&1 || RC=$?
     if [ $RC -ne 0 ]
     then
         tst_res TFAIL $LTPTMP/tst_xinetd.err \
@@ -274,9 +274,9 @@ test01()
     fi
 
     tst_resm TINFO "Test #1: restart xinetd with telnet enabled."
-	# install the xinetd config file with telnet enabled.
-	mv $LTPTMP/tst_xinetd.conf.2 /etc/xinetd.conf > $LTPTMP/tst_xinetd.err 2>&1 \
-		|| RC=$?
+    # install the xinetd config file with telnet enabled.
+    mv $LTPTMP/tst_xinetd.conf.2 /etc/xinetd.conf > $LTPTMP/tst_xinetd.err 2>&1 \
+        || RC=$?
     if [ $RC -ne 0 ]
     then
         tst_brk TBROK $LTPTMP/tst_xinetd.err NULL \
@@ -286,44 +286,44 @@ test01()
 
     tst_resm TINFO "Test #1: new xinetd.conf installed with telnet enabled."
 
-	sleep 1s
+    sleep 1s
 
-	# restart services.
+    # restart services.
     /etc/init.d/xinetd restart > $LTPTMP/tst_xinetd.out 2>&1 || RC=$?
     if [ $RC -ne 0 ]
     then
         tst_res TFAIL $LTPTMP/tst_xinetd.out \
             "Test #1: unable to restart services with telnet enabled. Details:"
         return $RC
-	else
-		# even if restart has a zero exit value double check for failure.
-		grep -i "fail" $LTPTMP/tst_xinetd.out > $LTPTMP/tst_xinetd.err 2>&1 || RC=$?
-		if [ $RC -eq 0 ]
-		then
-			tst_res TFAIL $LTPTMP/tst_xinetd.err \
-				"Test #1: xinetd failed to restart. Details"
-			return $RC
-		else
-			RC=0
-			tst_resm TINFO \
-				"Test #1: xinetd re-started successfully with telnet enabled."
-		fi
-	fi
-
-	# Not checking for exit code from telnet command because telnet is
-	# not terminated by the test gracefully.
-	echo "" | telnet localhost > $LTPTMP/tst_xinetd.out 2>&1
-
-	diff -iwB $LTPTMP/tst_xinetd.out  $LTPTMP/tst_xinetd.exp.2 \
-		> $LTPTMP/tst_xinetd.err 2>&1 || RC=$?
+    else
+        # even if restart has a zero exit value double check for failure.
+        grep -i "fail" $LTPTMP/tst_xinetd.out > $LTPTMP/tst_xinetd.err 2>&1 || RC=$?
+        if [ $RC -eq 0 ]
+        then
+            tst_res TFAIL $LTPTMP/tst_xinetd.err \
+                "Test #1: xinetd failed to restart. Details"
+            return $RC
+        else
+            RC=0
+            tst_resm TINFO \
+                "Test #1: xinetd re-started successfully with telnet enabled."
+        fi
+    fi
+
+    # Not checking for exit code from telnet command because telnet is
+    # not terminated by the test gracefully.
+    echo "" | telnet localhost > $LTPTMP/tst_xinetd.out 2>&1
+
+    diff -iwB $LTPTMP/tst_xinetd.out  $LTPTMP/tst_xinetd.exp.2 \
+        > $LTPTMP/tst_xinetd.err 2>&1 || RC=$?
     if [ $RC -ne 0 ]
     then
         tst_res TFAIL $LTPTMP/tst_xinetd.err \
             "Test #1: expected output differes from actual. Details:"
         return $RC
-	else
-		tst_resm TPASS \
-		"Test #1: xinetd reads the config file and starts or stops services."
+    else
+        tst_resm TPASS \
+        "Test #1: xinetd reads the config file and starts or stops services."
     fi
 
     return $RC
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
