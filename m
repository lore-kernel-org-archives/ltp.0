Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <paul.larson@canonical.com>) id 1MbL9Q-0007or-Kj
	for ltp-list@lists.sourceforge.net; Wed, 12 Aug 2009 21:14:28 +0000
Received: from adelie.canonical.com ([91.189.90.139])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MbL9E-0007yt-MW
	for ltp-list@lists.sourceforge.net; Wed, 12 Aug 2009 21:14:23 +0000
Received: from hutte.canonical.com ([91.189.90.181])
	by adelie.canonical.com with esmtp (Exim 4.69 #1 (Debian))
	id 1MbL99-0002lp-9H
	for <ltp-list@lists.sourceforge.net>; Wed, 12 Aug 2009 22:14:11 +0100
Received: from 75-27-138-126.lightspeed.austtx.sbcglobal.net ([75.27.138.126]
	helo=[192.168.1.70]) by hutte.canonical.com with esmtpsa
	(TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32) (Exim 4.69)
	(envelope-from <paul.larson@canonical.com>) id 1MbL99-0006En-2S
	for ltp-list@lists.sourceforge.net; Wed, 12 Aug 2009 22:14:11 +0100
Message-ID: <4A8330A1.20001@canonical.com>
Date: Wed, 12 Aug 2009 16:14:09 -0500
From: Paul Larson <paul.larson@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090801070807060008090709"
Subject: [LTP] fix mail_tests for systems without mail installed
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: LTP Mailing List <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------090801070807060008090709
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

mail_tests should return tconf instead of tfail if mail is not installed.

Signed-off-by: Paul Larson <paul.larson@canonical.com>
---


--------------090801070807060008090709
Content-Type: text/x-patch;
 name="mail_tests.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mail_tests.patch"

diff --git a/testcases/commands/mail/mail_tests.sh b/testcases/commands/mail/mail_tests.sh
index 7458944..a2c6487 100755
--- a/testcases/commands/mail/mail_tests.sh
+++ b/testcases/commands/mail/mail_tests.sh
@@ -59,6 +59,11 @@ RC=0
 export TCID=SETUP
 export TST_COUNT=1
 
+`which mail`
+if [ $? != 0 ]; then
+    MAIL_NOT_INSTALLED=1
+fi
+
 # check if the user mail_test exists on this system.
 # if not add that user mail_test, will removed before exiting test.
 RC=$(awk '/^mail_test/ {print 1}' /etc/passwd)
@@ -97,6 +102,7 @@ $LTPBIN/tst_resm TINFO "Test #1: mail root@localhost will send mail to root"
 $LTPBIN/tst_resm TINFO "Test #1: user on local machine."
 
 
+if [ -z $MAIL_NOT_INSTALLED ]; then
 cat > $LTPTMP/tst_mail.in <<EOF
 This is a test email.
 EOF
@@ -125,6 +131,9 @@ else
         TFAILCNT=$(( $TFAILCNT+1 ))
     fi
 fi
+else
+    $LTPBIN/tst_resm TCONF "mail command not installed"
+fi
 
 
 # Test #2
@@ -142,6 +151,7 @@ $LTPBIN/tst_resm TINFO \
 $LTPBIN/tst_resm TINFO "Test #2: to deliver the mail. Mailer daemon should"
 $LTPBIN/tst_resm TINFO "Test #2: report this failure."
 
+if [ -z $MAIL_NOT_INSTALLED ]; then
 cat > $LTPTMP/tst_mail.in <<EOF
 This is a test email.
 EOF
@@ -193,7 +203,9 @@ fi
         fi
     fi
 fi
-    
+else
+    $LTPBIN/tst_resm TCONF "mail command not installed"
+fi    
 
 # Test #3
 # Test that mail non_existant_user@localhost will result in delivery failure.
@@ -210,6 +222,7 @@ $LTPBIN/tst_resm TINFO \
 $LTPBIN/tst_resm TINFO "Test #3: to deliver the mail. Mailer daemon should"
 $LTPBIN/tst_resm TINFO "Test #3: report this failure."
 
+if [ -z $MAIL_NOT_INSTALLED ]; then
 cat > $LTPTMP/tst_mail.in <<EOF
 This is a test email.
 EOF
@@ -260,6 +273,9 @@ fi
         fi
     fi
 fi
+else
+    $LTPBIN/tst_resm TCONF "mail command not installed"
+fi
 
 # Test #4 
 # Test that mail -c user@domain option will carbon copy that user.
@@ -270,6 +286,7 @@ RC=0
 
 $LTPBIN/tst_resm TINFO "Test #4: Test that mail -c user@domain will"
 $LTPBIN/tst_resm TINFO "Test #4: carbon copy user@domain"
+if [ -z $MAIL_NOT_INSTALLED ]; then
 
 # send mail to root and carbon copy mail_test 
 mail -s "Test" root@localhost -c mail_test@localhost < \
@@ -297,7 +314,9 @@ else
         TFAILCNT=$(( $TFAILCNT+1 ))
     fi
 fi
-
+else
+    $LTPBIN/tst_resm TCONF "mail command not installed"
+fi
 
 # Test #5 
 # Test that mail -b user@domain option will blind carbon copy that user.
@@ -308,6 +327,7 @@ RC=0
 
 $LTPBIN/tst_resm TINFO "Test #5: Test that mail -b user@domain will"
 $LTPBIN/tst_resm TINFO "Test #5: blind carbon copy user@domain"
+if [ -z $MAIL_NOT_INSTALLED ]; then
 
 # send mail to root and carbon copy mail_test 
 mail -s "Test" root@localhost -c mail_test@localhost < \
@@ -335,7 +355,9 @@ else
         TFAILCNT=$(( $TFAILCNT+1 ))
     fi
 fi
-    
+else
+    $LTPBIN/tst_resm TCONF "mail command not installed"
+fi
 
 #CLEANUP & EXIT
 # remove all the temporary files created by this test.

--------------090801070807060008090709
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--------------090801070807060008090709
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------090801070807060008090709--

