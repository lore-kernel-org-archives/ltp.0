Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <czhang@redhat.com>) id 1ObQAZ-0005n1-Dl
	for ltp-list@lists.sourceforge.net; Wed, 21 Jul 2010 03:40:31 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24]
	helo=mx01.colomx.prod.int.phx2.redhat.com)
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1ObQAY-00064m-Du
	for ltp-list@lists.sourceforge.net; Wed, 21 Jul 2010 03:40:31 +0000
Received: from mail04.corp.redhat.com (zmail04.collab.prod.int.phx2.redhat.com
	[10.5.5.44])
	by mx01.colomx.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id
	o6L3eOgQ003455
	for <ltp-list@lists.sourceforge.net>; Tue, 20 Jul 2010 23:40:24 -0400
Date: Tue, 20 Jul 2010 23:40:24 -0400 (EDT)
From: Caspar Zhang <czhang@redhat.com>
Message-ID: <1012448207.707951279683624684.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
In-Reply-To: <1072286102.707931279683604082.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_30820_1457437594.1279683624683"
Subject: [LTP] [PATCH] fix mail test
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
To: LTP List <ltp-list@lists.sourceforge.net>

------=_Part_30820_1457437594.1279683624683
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hi all,
   In latest RHEL6, the mail format sometimes becomes "...Mail 
   Delivery System..." instead of "...Mail Delivery Subsys...".
   This patch fixes this problem. Plus, corrected misspelling.

   Signed-off-by: Caspar Zhang <czhang@redhat.com>

diff --git a/testcases/commands/mail/mail_tests.sh b/testcases/commands/mail/mail_tests.sh
index 53a5d90..2aaf764 100755
--- a/testcases/commands/mail/mail_tests.sh
+++ b/testcases/commands/mail/mail_tests.sh
@@ -160,7 +160,7 @@ if [ $? -ne 0 ]; then
            "Test #2: mail command failed. Reason:"
        : $(( TFAILCNT += 1 ))
 else
-       # check if Mailer-Deamon reported any delivery failure.
+       # check if Mailer-Daemon reported any delivery failure.
        # but wait for the mail to arrive first, sleep 5.
        sleep 5
        echo "d" | mail -u root > $LTPTMP/tst_mail.res 2>&1
@@ -169,7 +169,7 @@ else
                RC1=$(awk '/^>N/ {IGNORECASE=1; print match($3, "Mailer-Daemon")}' \                                                                                 
                    $LTPTMP/tst_mail.res)                                                                                                                            
        else                                                                                                                                                         
-               RC1=$(awk '/^>N/ {IGNORECASE=1; print match($3 $4 $5, "MailDeliverySubsys")}' \                                                                      
+               RC1=$(awk '/^>N/ {IGNORECASE=1; print match($3 $4 $5, "MailDelivery(Subsys|System)")}' \                                                             
                    $LTPTMP/tst_mail.res)                                                                                                                            
        fi                                                                                                                                                           
 
@@ -208,10 +208,10 @@ else
 
                if [ $RC1 -ne 0 -a $RC2 -ne 0 ] || [ $RC1 -ne 0 -a $RC3 -ne 0 ]; then
                        tst_resm TPASS \
-                               "Test #2: Mailer-Deamon reported delivery failure"
+                               "Test #2: Mailer-Daemon reported delivery failure"
                else
                        tst_res TFAIL $LTPTMP/tst_mail.res \
-                       "Test #2: Mailer-Deamon failed to report delivery failure. Reason:"
+                       "Test #2: Mailer-Daemon failed to report delivery failure. Reason:"
                        : $(( TFAILCNT += 1 ))
                fi
 
@@ -222,7 +222,7 @@ fi
 
 # Test #3
 # Test that mail non_existent_user@localhost will result in delivery failure.
-# Mailer-Deamon will report this failure.
+# Mailer-Daemon will report this failure.
 
 export TCID=mail_tests::mail03
 export TST_COUNT=3
@@ -241,7 +241,7 @@ if [ $? -ne 0 ]; then
            "Test #3: mail command failed. Reason: "
        : $(( TFAILCNT += 1 ))
 else
-       # check if Mailer-Deamon reported any delivery failure.
+       # check if Mailer-Daemon reported any delivery failure.
        # but wait for the mail to arrive first, sleep 5.
        sleep 5
        echo "d" | mail -u root > $LTPTMP/tst_mail.res 2>&1
@@ -250,7 +250,7 @@ else
                RC1=$(awk '/^>N/ {IGNORECASE=1; print match($3, "Mailer-Daemon")}' \
                    $LTPTMP/tst_mail.res)
        else
-               RC1=$(awk '/^>N/ {IGNORECASE=1; print match($3 $4 $5, "MailDeliverySubsys")}' \
+               RC1=$(awk '/^>N/ {IGNORECASE=1; print match($3 $4 $5, "MailDelivery(Subsys|System)")}' \
                    $LTPTMP/tst_mail.res)
        fi
        ##################################################################

-- 
Quality Assurance Associate (Kernel) in
Red Hat Inc. (Beijing R&D Branch)

TEL: +86-10-62608150
Web: http://www.redhat.com/

------=_Part_30820_1457437594.1279683624683
Content-Type: text/x-patch; name=commands-mail.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=commands-mail.patch

Hi all,
   In latest RHEL6, the mail format sometimes becomes "...Mail 
   Delivery System..." instead of "...Mail Delivery Subsys...".
   This patch fixes this problem. Plus, corrected misspelling.

   Signed-off-by: Caspar Zhang <czhang@redhat.com>

diff --git a/testcases/commands/mail/mail_tests.sh b/testcases/commands/mail/mail_tests.sh
index 53a5d90..2aaf764 100755
--- a/testcases/commands/mail/mail_tests.sh
+++ b/testcases/commands/mail/mail_tests.sh
@@ -160,7 +160,7 @@ if [ $? -ne 0 ]; then
 	    "Test #2: mail command failed. Reason:"
 	: $(( TFAILCNT += 1 ))
 else
-	# check if Mailer-Deamon reported any delivery failure.	
+	# check if Mailer-Daemon reported any delivery failure.	
 	# but wait for the mail to arrive first, sleep 5.
 	sleep 5
 	echo "d" | mail -u root > $LTPTMP/tst_mail.res 2>&1
@@ -169,7 +169,7 @@ else
 		RC1=$(awk '/^>N/ {IGNORECASE=1; print match($3, "Mailer-Daemon")}' \
 		    $LTPTMP/tst_mail.res)
 	else
-		RC1=$(awk '/^>N/ {IGNORECASE=1; print match($3 $4 $5, "MailDeliverySubsys")}' \
+		RC1=$(awk '/^>N/ {IGNORECASE=1; print match($3 $4 $5, "MailDelivery(Subsys|System)")}' \
 		    $LTPTMP/tst_mail.res)
 	fi
 
@@ -208,10 +208,10 @@ else
 
 		if [ $RC1 -ne 0 -a $RC2 -ne 0 ] || [ $RC1 -ne 0 -a $RC3 -ne 0 ]; then
 			tst_resm TPASS \
-				"Test #2: Mailer-Deamon reported delivery failure"
+				"Test #2: Mailer-Daemon reported delivery failure"
 		else
 			tst_res TFAIL $LTPTMP/tst_mail.res \
-			"Test #2: Mailer-Deamon failed to report delivery failure. Reason:"
+			"Test #2: Mailer-Daemon failed to report delivery failure. Reason:"
 			: $(( TFAILCNT += 1 ))
 		fi
 
@@ -222,7 +222,7 @@ fi
 
 # Test #3
 # Test that mail non_existent_user@localhost will result in delivery failure.
-# Mailer-Deamon will report this failure.
+# Mailer-Daemon will report this failure.
 
 export TCID=mail_tests::mail03
 export TST_COUNT=3
@@ -241,7 +241,7 @@ if [ $? -ne 0 ]; then
 	    "Test #3: mail command failed. Reason: "
 	: $(( TFAILCNT += 1 ))
 else
-	# check if Mailer-Deamon reported any delivery failure.	
+	# check if Mailer-Daemon reported any delivery failure.	
 	# but wait for the mail to arrive first, sleep 5.
 	sleep 5
 	echo "d" | mail -u root > $LTPTMP/tst_mail.res 2>&1
@@ -250,7 +250,7 @@ else
 		RC1=$(awk '/^>N/ {IGNORECASE=1; print match($3, "Mailer-Daemon")}' \
 		    $LTPTMP/tst_mail.res)
 	else
-		RC1=$(awk '/^>N/ {IGNORECASE=1; print match($3 $4 $5, "MailDeliverySubsys")}' \
+		RC1=$(awk '/^>N/ {IGNORECASE=1; print match($3 $4 $5, "MailDelivery(Subsys|System)")}' \
 		    $LTPTMP/tst_mail.res)
 	fi
 	##################################################################

------=_Part_30820_1457437594.1279683624683
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
------=_Part_30820_1457437594.1279683624683
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_Part_30820_1457437594.1279683624683--

