Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MXhWG-0002gm-R6
	for ltp-list@lists.sourceforge.net; Sun, 02 Aug 2009 20:19:00 +0000
Received: from qw-out-1920.google.com ([74.125.92.150])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MXhWE-00009d-Ll
	for ltp-list@lists.sourceforge.net; Sun, 02 Aug 2009 20:19:00 +0000
Received: by qw-out-1920.google.com with SMTP id 5so1416453qwc.4
	for <ltp-list@lists.sourceforge.net>;
	Sun, 02 Aug 2009 13:18:52 -0700 (PDT)
MIME-Version: 1.0
Date: Sun, 2 Aug 2009 13:18:52 -0700
Message-ID: <364299f40908021318y7cb6f8edl24ae1a9b85157758@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: [LTP] [PATCH] Fix rsh01
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: LTP list <ltp-list@lists.sourceforge.net>

1. The indentation in this script was off (defacto standard for shell
scripts is 4-space indents).
2. rsh is becoming a deprecated app, so the likelihood of someone
executing this app and having it fail the first time and succeed in
the remaining runs is low. So let's do two things:
    i. Provide a means to toggle immediately failure to provide a
quick failure short circuit (FAIL_IMMEDIATELY => 1).
    ii. Fail on the first try if FAIL_IMMEDIATELY is set and exit the script.
3. Export TCID, TST_COUNT, and TST_TOTAL so tst_resm doesn't complain.
4. Prefix the number of tries so folks don't need to scroll up the
terminal buffer and count to see what iteration they're executing.
5. Convert `"$CHECK" -eq 9' to `"$CHECK" = "9"' so test(1) doesn't
complain if and when the rsh(1) fails, and thus doesn't return an
integer value to stdout.

Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

Index: testcases/network/tcp_cmds/rsh/rsh01
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/network/tcp_cmds/rsh/rsh01,v
retrieving revision 1.5
diff -u -r1.5 rsh01
--- testcases/network/tcp_cmds/rsh/rsh01	13 Aug 2003 20:39:48 -0000	1.5
+++ testcases/network/tcp_cmds/rsh/rsh01	2 Aug 2009 20:12:00 -0000
@@ -37,10 +37,14 @@
 #trace_logic=${trace_logic:-"set -x"}
 $trace_logic

+FAIL_IMMEDIATELY=${FAIL_IMMEDIATELY:-1}
 RHOST=${RHOST:-`hostname`}
 SLEEPTIME=${SLEEPTIME:-0}
-NUMLOOPS=${NUMLOOPS:-25}
+NUMLOOPS=${NUMLOOPS:-1}

+export TCID=rsh01
+export TST_TOTAL=$NUM_LOOPS
+export TST_COUNT=$NUM_LOOPS

 #-----------------------------------------------------------------------
 #
@@ -50,15 +54,12 @@

 exists()
 {
-   for cmd in $1
-   do
-       which $cmd 2>&1 1>/dev/null
-	   if [ $? -ne 0 ]
-	   then
-	       tst_resm TBROK "Test broke: command $cmd not found"
-		   exit 1
-       fi
-   done
+    for cmd in $1; do
+        if ! which $cmd 2>&1 1>/dev/null; then
+            tst_resm TBROK "$cmd not found"
+            exit 1
+        fi
+    done
 }

 #-----------------------------------------------------------------------
@@ -69,21 +70,27 @@

 do_test()
 {
-   $trace_logic
+    $trace_logic

-   COUNT=1
-   while [ $COUNT -le $NUMLOOPS ]
-   do
-      CHECK=$(rsh -n -l root $RHOST "ls -l /etc/hosts | wc -w")
-
-      if [ "$CHECK" -eq 9 ]; then
-         tst_resm TINFO "rsh Test successful in loop $COUNT"
-      else
-         tst_resm TBROK "FAILED: rsh failed"
-      fi
-      sleep $SLEEPTIME
-      COUNT=$(( $COUNT + 1 ))
-   done
+    COUNT=1
+    while [ $COUNT -le $NUMLOOPS ]
+    do
+        CHECK=$(rsh -n -l root $RHOST "ls -l /etc/hosts | wc -w")
+
+        if [ "$CHECK" -eq 9 ]; then
+            tst_resm TINFO "[$COUNT/$NUM_LOOPS] rsh to $RHOST test succeeded"
+        else
+            tst_resm TFAIL "[$COUNT/$NUM_LOOPS] rsh to $RHOST failed"
+            # If the first rsh failed, the likelihood that the rest will
+            # succeed is low.
+            if [ -n "$FAIL_IMMEDIATELY" -a "$FAIL_IMMEDIATELY" = "1"
] && [ $COUNT -eq 1 ]
+            then
+                exit 2
+            fi
+        fi
+        sleep $SLEEPTIME
+        COUNT=$(( $COUNT + 1 ))
+    done
 }

 #=============================================================================
@@ -98,11 +105,11 @@

 end_testcase()
 {
-   $trace_logic
+    $trace_logic

-   [ $# -eq 0 ] && { tst_resm TPASS "Test Successful"; exit 0; }
-   tst_resm TFAIL "Test Failed: $@"
-   exit 1
+    [ $# -eq 0 ] && { tst_resm TPASS "Test Successful"; exit 0; }
+    tst_resm TFAIL "Test Failed: $@"
+    exit 1
 }

 #----------------------------------------------------------------------

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
