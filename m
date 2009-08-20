Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <geert@sonycom.com>) id 1Me9WD-0000Qg-N4
	for Ltp-list@lists.sourceforge.net; Thu, 20 Aug 2009 15:25:37 +0000
Received: from vervifontaine.sonytel.be ([80.88.33.193]
	helo=pophost.sonytel.be) by 72vjzd1.ch3.sourceforge.com with esmtp 
	(Exim 4.69) id 1Me9W6-00005M-C6
	for Ltp-list@lists.sourceforge.net; Thu, 20 Aug 2009 15:25:37 +0000
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Date: Thu, 20 Aug 2009 17:25:17 +0200
Message-Id: <1250781918-23897-3-git-send-email-Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <1250781918-23897-2-git-send-email-Geert.Uytterhoeven@sonycom.com>
References: <1250781918-23897-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1250781918-23897-2-git-send-email-Geert.Uytterhoeven@sonycom.com>
Subject: [LTP] [PATCH] Spelling fixes: exectue => execute
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
To: Ltp-list@lists.sourceforge.net
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 testcases/commands/at/at_allow01     |    4 ++--
 testcases/commands/at/at_deny01      |    4 ++--
 testcases/commands/cron/cron_allow01 |    4 ++--
 testcases/commands/cron/cron_deny01  |    4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/testcases/commands/at/at_allow01 b/testcases/commands/at/at_allow01
index fcad4df..dab34bd 100755
--- a/testcases/commands/at/at_allow01
+++ b/testcases/commands/at/at_allow01
@@ -114,7 +114,7 @@ run_test()
         if [ ${exit_code} -eq 1 ]; then
             echo "At did not allow user to execute job, TEST FAILED."
 	else
-            echo "At allowed user to exectue test job, TEST PASSED."
+            echo "At allowed user to execute test job, TEST PASSED."
 	fi
 
 	rm -f "${tmpfile}" >/dev/null 2>&1
@@ -135,7 +135,7 @@ run_test()
         exit_code=1
         test -e "${tmpfile}" || exit_code=0
         if [ ${exit_code} -eq 1 ]; then
-            echo "At allowed user to exectue test job, TEST FAILED."
+            echo "At allowed user to execute test job, TEST FAILED."
         else
             echo "At did not allow user to execute job, TEST PASSED."
         fi
diff --git a/testcases/commands/at/at_deny01 b/testcases/commands/at/at_deny01
index 2fcb76d..9c03845 100755
--- a/testcases/commands/at/at_deny01
+++ b/testcases/commands/at/at_deny01
@@ -122,7 +122,7 @@ run_test()
         exit_code=1
         test -e "${tmpfile}" && exit_code=0
         if [ ${exit_code} -eq 1 ]; then
-            echo "At denyed user to exectue test job, TEST FAILED."
+            echo "At denyed user to execute test job, TEST FAILED."
         else
             echo "At did not deny user to execute job, TEST PASSED."
         fi
@@ -147,7 +147,7 @@ run_test()
         if [ ${exit_code} -eq 1 ]; then
             echo "At did not deny user to execute job, TEST FAILED."
         else
-            echo "At denyed user to exectue test job, TEST PASSED."
+            echo "At denyed user to execute test job, TEST PASSED."
         fi
 
         rm -f "${tmpfile}" >/dev/null 2>&1
diff --git a/testcases/commands/cron/cron_allow01 b/testcases/commands/cron/cron_allow01
index 266700a..404ca28 100755
--- a/testcases/commands/cron/cron_allow01
+++ b/testcases/commands/cron/cron_allow01
@@ -126,7 +126,7 @@ EOF
 	if [ $EXIT_CODE = 1 ]; then
 		echo "Cron did not allow user to execute job , TEST FAILED"
 	else
-		echo "Cron allowed user to exectue test job, TEST PASSED"
+		echo "Cron allowed user to execute test job, TEST PASSED"
 	fi
 	
 	 echo "restore old crontab..."
@@ -162,7 +162,7 @@ EOF
         if [ $EXIT_CODE = 0 ]; then
                 echo "Cron did not allow user to execute job , TEST PASSED"
         else
-                echo "Cron allowed user to exectue test job, TEST FAILED"
+                echo "Cron allowed user to execute test job, TEST FAILED"
         fi
 
 		echo "restore old crontab..."
diff --git a/testcases/commands/cron/cron_deny01 b/testcases/commands/cron/cron_deny01
index 527d79c..563f857 100755
--- a/testcases/commands/cron/cron_deny01
+++ b/testcases/commands/cron/cron_deny01
@@ -128,7 +128,7 @@ EOF
 	if [ $EXIT_CODE = 1 ]; then
 		echo "Cron did not allow user to execute job , TEST FAILED"
 	else
-		echo "Cron allowed user to exectue test job, TEST PASSED"
+		echo "Cron allowed user to execute test job, TEST PASSED"
 	fi
 
 	rm -f /tmp/cron_deny_test
@@ -156,7 +156,7 @@ EOF
         if [ $EXIT_CODE = 0 ]; then
                 echo "Cron did not allow user to execute job , TEST PASSED"
         else
-                echo "Cron allowed user to exectue test job, TEST FAILED"
+                echo "Cron allowed user to execute test job, TEST FAILED"
         fi
                                                                                                              
         rm -f /tmp/cron_deny_test1
-- 
1.6.2.4


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
