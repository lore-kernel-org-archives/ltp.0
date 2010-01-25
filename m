Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <shiwh@cn.fujitsu.com>) id 1NZJbc-0000Lz-RP
	for ltp-list@lists.sourceforge.net; Mon, 25 Jan 2010 07:43:28 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NZJba-0006gk-Uo
	for ltp-list@lists.sourceforge.net; Mon, 25 Jan 2010 07:43:28 +0000
Received: from tang.cn.fujitsu.com (tang.cn.fujitsu.com [10.167.250.3])
	by song.cn.fujitsu.com (Postfix) with ESMTP id 06A1A17012D
	for <ltp-list@lists.sourceforge.net>;
	Mon, 25 Jan 2010 15:43:15 +0800 (CST)
Received: from fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id o0P7ggQ3008466
	for <ltp-list@lists.sourceforge.net>; Mon, 25 Jan 2010 15:42:42 +0800
Received: from [10.167.141.106] (unknown [10.167.141.106])
	by fnst.cn.fujitsu.com (Postfix) with ESMTPA id 868B3D477C
	for <ltp-list@lists.sourceforge.net>;
	Mon, 25 Jan 2010 15:44:26 +0800 (CST)
Message-ID: <4B5D4B8C.30300@cn.fujitsu.com>
Date: Mon, 25 Jan 2010 15:43:08 +0800
From: Shi Weihua <shiwh@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] mail_tests.sh: fix a version problem of Heirloom Mail
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
To: ltp-list <ltp-list@lists.sourceforge.net>

In the previous mailx version, the command "echo "d" | mail -u root" will
output like the following.
-----------------------------
Mail version 8.1 6/6/93.  Type ? for help.
"/var/mail/root": 1 message 1 new
>N  1 MAILER-DAEMON@localh  Mon Jan 25 09:11  63/2367  "Returned mail: see tr"
-----------------------------

Buy in Heirloom Mail, the command will output.
-----------------------------
Heirloom Mail version 12.4 7/29/08.  Type ? for help.
"/var/mail/root": 1 message 1 new
>N  1 Mail Delivery Subsys  Mon Jan 25 14:16  67/2195  "Returned mail: see tr"
-----------------------------

"MAILER-DAEMON@localh" is been changed to "Mail Delivery Subsys".
We should make mail_tests.sh to supporting Heirloom Mail.

Signed-off-by: Shi Weihua <shiwh@cn.fujitsu.com>
---
--- ltp-full-20091231/testcases/commands/mail/mail_tests.sh	2009-11-16 21:25:48.000000000 +0800
+++ ltp-full-20100119/testcases/commands/mail/mail_tests.sh	2010-01-25 15:30:21.000000000 +0800
@@ -55,6 +55,25 @@ else
     LTPBIN=$LTPROOT/testcases/bin
 fi
 
+isHeirloomMail=0
+checkHeirloomMail()
+{
+    isHeirloomMail=0
+
+    if [ $# -ne 1 ]; then
+        return
+    fi
+
+    if [ ! -f $1 ]; then
+	return
+    fi
+
+    cat $1 | grep "Heirloom"
+    if [ $? -eq 0 ]; then
+	isHeirloomMail=1
+    fi
+}
+
 RC=0
 export TCID=SETUP
 export TST_COUNT=1
@@ -170,8 +189,14 @@ else
     # but wait for the mail to arrive first, sleep 5s.
     sleep 5s
     echo "d" | mail -u root > $LTPTMP/tst_mail.res 2>&1
-    RC1=$(awk '/^>N/ {IGNORECASE=1; print match($3, "Mailer-Daemon")}' \
-	$LTPTMP/tst_mail.res)
+    checkHeirloomMail $LTPTMP/tst_mail.res
+    if [ $isHeirloomMail -eq 0 ]; then
+	RC1=$(awk '/^>N/ {IGNORECASE=1; print match($3, "Mailer-Daemon")}' \
+		$LTPTMP/tst_mail.res)
+    else
+	RC1=$(awk '/^>N/ {IGNORECASE=1; print match($3 $4 $5, "MailDeliverySubsys")}' \
+		$LTPTMP/tst_mail.res)
+    fi
 ##################################################################
 # In this testcase, mail will get "Returnedmail:", while mailx will
 # get "UndeliveredMailReturned:".
@@ -181,10 +206,17 @@ else
 # or
 # /bin/mailx -> /bin/mail
 ##################################################################
-     RC2=$(awk '/^>N/ {print match($9 $10, "Returnedmail:")}' \
-             $LTPTMP/tst_mail.res)
-     RC3=$(awk '/^>N/ {print match($9 $10, "UndeliveredMail")}' \
-             $LTPTMP/tst_mail.res)
+     if [ $isHeirloomMail -eq 0 ]; then
+	RC2=$(awk '/^>N/ {print match($9 $10, "Returnedmail:")}' \
+		$LTPTMP/tst_mail.res)
+	RC3=$(awk '/^>N/ {print match($9 $10, "UndeliveredMail")}' \
+		$LTPTMP/tst_mail.res)
+     else
+	RC2=$(awk '/^>N/ {print match($11 $12, "Returnedmail:")}' \
+		$LTPTMP/tst_mail.res)
+	RC3=$(awk '/^>N/ {print match($11 $12, "UndeliveredMail")}' \
+		$LTPTMP/tst_mail.res)
+     fi
 fi 
     if [ -z "$RC1" -a -z "$RC2" -a -z "$RC3" ]
     then
@@ -238,8 +270,14 @@ else
     # but wait for the mail to arrive first, sleep 5s.
     sleep 5s
     echo "d" | mail -u root > $LTPTMP/tst_mail.res 2>&1
-    RC1=$(awk '/^>N/ {IGNORECASE=1; print match($3, "Mailer-Daemon")}' \
-	$LTPTMP/tst_mail.res)
+    checkHeirloomMail $LTPTMP/tst_mail.res
+    if [ $isHeirloomMail -eq 0 ]; then
+	RC1=$(awk '/^>N/ {IGNORECASE=1; print match($3, "Mailer-Daemon")}' \
+		$LTPTMP/tst_mail.res)
+    else
+	RC1=$(awk '/^>N/ {IGNORECASE=1; print match($3 $4 $5, "MailDeliverySubsys")}' \
+		$LTPTMP/tst_mail.res)
+    fi
 ##################################################################
 # In this testcase, mail will get "Returnedmail:", while mailx will
 # get "UndeliveredMailReturned:".
@@ -248,11 +286,18 @@ else
 # /bin/mail -> /bin/mailx
 # or
 # /bin/mailx -> /bin/mail
-##################################################################
-     RC2=$(awk '/^>N/ {print match($9 $10, "Returnedmail:")}' \
-             $LTPTMP/tst_mail.res)
-     RC3=$(awk '/^>N/ {print match($9 $10, "UndeliveredMail")}' \
-             $LTPTMP/tst_mail.res)
+#################################################################
+     if [ $isHeirloomMail -eq 0 ]; then
+	RC2=$(awk '/^>N/ {print match($9 $10, "Returnedmail:")}' \
+		$LTPTMP/tst_mail.res)
+	RC3=$(awk '/^>N/ {print match($9 $10, "UndeliveredMail")}' \
+		$LTPTMP/tst_mail.res)
+     else
+	RC2=$(awk '/^>N/ {print match($11 $12, "Returnedmail:")}' \
+		$LTPTMP/tst_mail.res)
+	RC3=$(awk '/^>N/ {print match($11 $12, "UndeliveredMail")}' \
+		$LTPTMP/tst_mail.res)
+     fi
 fi
     if [ -z "$RC1" -a -z "$RC2" -a -z "$RC3" ]
     then

------------------------------------------------------------------------------
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Conference
attendees to learn about information security's most important issues through
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
