Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <liubo2009@cn.fujitsu.com>) id 1N9xMI-0007Ek-TD
	for ltp-list@lists.sourceforge.net; Mon, 16 Nov 2009 08:54:50 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N9xMB-0001V5-Au
	for ltp-list@lists.sourceforge.net; Mon, 16 Nov 2009 08:54:50 +0000
Message-ID: <4B011376.1010006@cn.fujitsu.com>
Date: Mon, 16 Nov 2009 16:55:18 +0800
From: liubo <liubo2009@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] mail: fix the bug of mail01
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
To: ltp-list@lists.sourceforge.net

In the testcase "mail01",

when mail is send to nosuchuser@domain
and mail is send to user@nosuchdomain,
mail program may return either "Returnedmail:"
or "UndeliveredMailReturned", regardless of
the existence of /etc/redhat-release.

So, we did a bit of changes to recognize both of
returned values.

This patch fixes the problem.

Signed-off-by: Liu Bo <liubo2009@cn.fujitsu.com>
---
 testcases/commands/mail/mail_tests.sh |   65 ++++++++++++++++-----------------
 1 files changed, 31 insertions(+), 34 deletions(-)

diff --git a/testcases/commands/mail/mail_tests.sh b/testcases/commands/mail/mail_tests.sh
index 45bac93..024120f 100755
--- a/testcases/commands/mail/mail_tests.sh
+++ b/testcases/commands/mail/mail_tests.sh
@@ -172,28 +172,27 @@ else
     echo "d" | mail -u root > $LTPTMP/tst_mail.res 2>&1
     RC1=$(awk '/^>N/ {IGNORECASE=1; print match($3, "Mailer-Daemon")}' \
 	$LTPTMP/tst_mail.res)
-    RC2=$(awk '/^>N/ {print match($9 $10 $11, "Maildeliveryfailed:")}' \
-        $LTPTMP/tst_mail.res)
-#####
-# Some mailers (e.g., Red Hat's sendmail) print different messages 
-#####
-if [ -f /etc/redhat-release ] 
-then 
-  [ -z "$RC2" -o "X$RC2" = "X0" ] && \
+##################################################################
+# In this testcase, mail will get "Returnedmail:", while mailx will
+# get "UndeliveredMailReturned:".
+# Either of mail and mailx may be linked to another.
+# For example,
+# /bin/mail -> /bin/mailx
+# or
+# /bin/mailx -> /bin/mail
+##################################################################
      RC2=$(awk '/^>N/ {print match($9 $10, "Returnedmail:")}' \
              $LTPTMP/tst_mail.res)
-else 
-  [ -z "$RC2" -o "X$RC2" = "X0" ] && \
-     RC2=$(awk '/^>N/ {print match($9 $10 $11, "UndeliveredMailReturned")}' \
+     RC3=$(awk '/^>N/ {print match($9 $10, "UndeliveredMail")}' \
              $LTPTMP/tst_mail.res)
 fi 
-    if [ -z "$RC1" -a -z "$RC2" ]
+    if [ -z "$RC1" -a -z "$RC2" -a -z "$RC3" ]
     then
         $LTPBIN/tst_res TFAIL $LTPTMP/tst_mail.res \
         "Test #2: No new mail for root. Reason:"
         TFAILCNT=$(( $TFAILCNT+1 ))
     else
-        if [ $RC1 -ne 0 -a $RC2 -ne 0 ]
+        if [ $RC1 -ne 0 -a $RC2 -ne 0 ] || [ $RC1 -ne 0 -a $RC3 -ne 0 ]
         then
             $LTPBIN/tst_resm TPASS \
                 "Test #2: Mailer-Deamon reported delivery failure"
@@ -203,7 +202,6 @@ fi
             TFAILCNT=$(( $TFAILCNT+1 ))
         fi
     fi
-fi
 else
     $LTPBIN/tst_resm TCONF "mail command not installed"
 fi    
@@ -242,29 +240,28 @@ else
     echo "d" | mail -u root > $LTPTMP/tst_mail.res 2>&1
     RC1=$(awk '/^>N/ {IGNORECASE=1; print match($3, "Mailer-Daemon")}' \
 	$LTPTMP/tst_mail.res)
-    RC2=$(awk '/^>N/ {print match($9 $10 $11, "Maildeliveryfailed:")}' \
-        $LTPTMP/tst_mail.res)
-#####
-# Some mailers (e.g., Red Hat's sendmail) print different messages 
-#####
-if [ -f /etc/redhat-release ] 
-then 
-   [ -z "$RC2" -o "X$RC2" = "X0" ] && \
-      RC2=$(awk '/^>N/ {print match($9 $10, "Returnedmail:")}' \
-              $LTPTMP/tst_mail.res)
-else 
-    [ -z "$RC2" -o "X$RC2" = "X0" ] && \
-        RC2=$(awk '/^>N/ {print match($9 $10 $11, "UndeliveredMailReturned")}' \
-                $LTPTMP/tst_mail.res)
-fi 
-    if [ -z "$RC1" -a -z "$RC2" ]
+##################################################################
+# In this testcase, mail will get "Returnedmail:", while mailx will
+# get "UndeliveredMailReturned:".
+# Either of mail and mailx may be linked to another.
+# For example,
+# /bin/mail -> /bin/mailx
+# or
+# /bin/mailx -> /bin/mail
+##################################################################
+     RC2=$(awk '/^>N/ {print match($9 $10, "Returnedmail:")}' \
+             $LTPTMP/tst_mail.res)
+     RC3=$(awk '/^>N/ {print match($9 $10, "UndeliveredMail")}' \
+             $LTPTMP/tst_mail.res)
+fi
+    if [ -z "$RC1" -a -z "$RC2" -a -z "$RC3" ]
     then
         $LTPBIN/tst_res TFAIL $LTPTMP/tst_mail.res \
-        "Test #3: No new mail for root. Reason:"
+        "Test #2: No new mail for root. Reason:"
         TFAILCNT=$(( $TFAILCNT+1 ))
     else
-        if [ $RC1 -ne 0 -a $RC2 -ne 0 ]
-        then
+        if [ $RC1 -ne 0 -a $RC2 -ne 0 ] || [ $RC1 -ne 0 -a $RC3 -ne 0 ]
+	then
             $LTPBIN/tst_resm TPASS \
                 "Test #3: Mailer-Deamon reported delivery failure"
         else
@@ -273,7 +270,7 @@ fi
             TFAILCNT=$(( $TFAILCNT+1 ))
         fi
     fi
-fi
+
 else
     $LTPBIN/tst_resm TCONF "mail command not installed"
 fi
-- 
1.6.2.2




------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
