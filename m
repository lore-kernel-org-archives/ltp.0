Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1N0dH1-0002fL-88
	for ltp-list@lists.sourceforge.net; Wed, 21 Oct 2009 15:38:51 +0000
Received: from fmmailgate02.web.de ([217.72.192.227])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N0dGz-0005dM-Kz
	for ltp-list@lists.sourceforge.net; Wed, 21 Oct 2009 15:38:51 +0000
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate02.web.de (Postfix) with ESMTP id 3B63A1360E776
	for <ltp-list@lists.sourceforge.net>;
	Wed, 21 Oct 2009 17:38:43 +0200 (CEST)
Received: from [83.208.36.163] (helo=debian)
	by smtp05.web.de with asmtp (WEB.DE 4.110 #314) id 1N0dFS-0004nG-00
	for ltp-list@lists.sourceforge.net; Wed, 21 Oct 2009 17:37:14 +0200
Date: Wed, 21 Oct 2009 13:14:29 +0200
From: "Jiri Palecek" <jpalecek@web.de>
MIME-Version: 1.0
Resent-To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>
Resent-Message-ID: <op.u15ppcjfcfnueu@debian>
Subject: [LTP] [PATCH] Some fixes of shell scripts of tests
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
Sender: ltp-list-bounces@lists.sourceforge.net
Errors-To: ltp-list-bounces@lists.sourceforge.net
Cc: ltp-list@lists.sourceforge.net
Message-ID: <20091021111429.czvYPytYWMpclg-JqSyAgQ13GMRne62372EDeZ5ipTw@z>

Hello,

this patch fixes some minor bugs in the code of LTP shell scripts.

 - quote arguments of test(1) in some places concerning redhat
   detection

 - don't execute the result of type(1), it makes no sense - even more when the output of it should be redirected

Regards
    Jiri Palecek

Signed-off-by: Jiri Palecek <jpalecek@web.de>
---
 testcases/commands/ade/file/file_test.sh  |    2 +-
 testcases/commands/cron/cron_allow01      |    2 +-
 testcases/commands/cron/cron_deny01       |    2 +-
 testcases/commands/cron/cron_pos_tests.sh |    2 +-
 testcases/commands/mail/mail_tests.sh     |    2 +-
 testcases/commands/su/su01                |    6 +++---
 testcases/network/tcp_cmds/rdist/rdist01  |    2 +-
 7 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/testcases/commands/ade/file/file_test.sh b/testcases/commands/ade/file/file_test.sh
index e5de1ed..652b441 100755
--- a/testcases/commands/ade/file/file_test.sh
+++ b/testcases/commands/ade/file/file_test.sh
@@ -474,7 +474,7 @@ export TCID=file09
 export TST_COUNT=9
 
 $LTPBIN/tst_resm TINFO "TEST #9: file command recognizes RPM files"
-`type rpm &> /dev/null`
+type rpm > /dev/null 2>&1
 if [ $? = 0 ]; then
 bDIR=$(rpm --eval "%{_topdir}")
 bCMD=rpmbuild
diff --git a/testcases/commands/cron/cron_allow01 b/testcases/commands/cron/cron_allow01
index 404ca28..9a941dd 100755
--- a/testcases/commands/cron/cron_allow01
+++ b/testcases/commands/cron/cron_allow01
@@ -29,7 +29,7 @@ iam=`whoami`
 tvar=${MACHTYPE%-*}
 tvar=${tvar#*-}
 
-if [ $tvar = "redhat" -o $tvar = "redhat-linux" ] 
+if [ "$tvar" = "redhat" -o "$tvar" = "redhat-linux" ] 
 then
 CRON_ALLOW="/etc/cron.allow"
 else
diff --git a/testcases/commands/cron/cron_deny01 b/testcases/commands/cron/cron_deny01
index 563f857..89ca66c 100755
--- a/testcases/commands/cron/cron_deny01
+++ b/testcases/commands/cron/cron_deny01
@@ -29,7 +29,7 @@ iam=`whoami`
 tvar=${MACHTYPE%-*}
 tvar=${tvar#*-}
 
-if [ $tvar = "redhat" -o $tvar = "redhat-linux" ] 
+if [ "$tvar" = "redhat" -o "$tvar" = "redhat-linux" ] 
 then
 CRON_DENY="/etc/cron.deny"
 CRON_ALLOW="/etc/cron.allow"
diff --git a/testcases/commands/cron/cron_pos_tests.sh b/testcases/commands/cron/cron_pos_tests.sh
index 9b5c9f7..acc08cb 100755
--- a/testcases/commands/cron/cron_pos_tests.sh
+++ b/testcases/commands/cron/cron_pos_tests.sh
@@ -7,7 +7,7 @@ iam=`whoami`
 tvar=${MACHTYPE%-*}
 tvar=${tvar#*-}
 
-if [ $tvar = "redhat" -o $tvar = "redhat-linux" ] 
+if [ "$tvar" = "redhat" -o "$tvar" = "redhat-linux" ] 
 then
 	CRON_ALLOW="/etc/cron.allow"
 else
diff --git a/testcases/commands/mail/mail_tests.sh b/testcases/commands/mail/mail_tests.sh
index 45bac93..cee08d6 100755
--- a/testcases/commands/mail/mail_tests.sh
+++ b/testcases/commands/mail/mail_tests.sh
@@ -60,7 +60,7 @@ export TCID=SETUP
 export TST_COUNT=1
 
 MAIL_NOT_INSTALLED=
-`type mail &> /dev/null`
+type mail > /dev/null 2>&1
 if [ $? != 0 ]; then
     MAIL_NOT_INSTALLED=1
 fi
diff --git a/testcases/commands/su/su01 b/testcases/commands/su/su01
index 91548c7..1228c01 100755
--- a/testcases/commands/su/su01
+++ b/testcases/commands/su/su01
@@ -43,7 +43,7 @@ tvar=${tvar#*-}
 export tvar
 printf "Machine type is: $tvar\n\n"
 
-if [ $tvar = "redhat" -o $tvar = "redhat-linux" ] 
+if [ "$tvar" = "redhat" -o "$tvar" = "redhat-linux" ] 
 # Need to also set group for TEST_USER2
 then
 export TEST_USER1_GROUP="wheel"
@@ -99,7 +99,7 @@ rm -f $TEST_ENV_FILE > /dev/null 2>&1
 
 	#create users home directory (SLES 8 does not do this, even when specified in adduser)
 # Only do this if not RH; RH creates the directory.
-	if [ $tvar != "redhat" -a $tvar != "redhat-linux" ]
+	if [ "$tvar" != "redhat" -a "$tvar" != "redhat-linux" ]
 	then {
           USER_UID=`id -u $TEST_USER1`
           USER_GID=`id -g $TEST_USER1`
@@ -135,7 +135,7 @@ rm -f $TEST_ENV_FILE > /dev/null 2>&1
 	
 	#create users home diretory (SLES 8 does not do this, even when specified in adduser)
 # Only do this if not RH; RH creates the directory.
-        if [ $tvar != "redhat" -a $tvar != "redhat-linux" ]
+        if [ "$tvar" != "redhat" -a "$tvar" != "redhat-linux" ]
         then {
           USER_UID=`id -u $TEST_USER2`
           USER_GID=`id -g $TEST_USER2`
diff --git a/testcases/network/tcp_cmds/rdist/rdist01 b/testcases/network/tcp_cmds/rdist/rdist01
index 624fd12..d03dd73 100755
--- a/testcases/network/tcp_cmds/rdist/rdist01
+++ b/testcases/network/tcp_cmds/rdist/rdist01
@@ -175,7 +175,7 @@ check_result()
                x=\$(( \$x + \$i ))
             done
             echo \$x`
-         if [ $TOTAL_SUM = $LSUM ]; then 
+         if [ "$TOTAL_SUM" = "$LSUM" ]; then 
             tst_resm TINFO "Success rdist in $c_ruser@$c_rhost "
   	    rsh -n -l $c_ruser $c_rhost "rm -rf $FILES $DIRECTORIES"
          else
-- 
1.6.4.3




------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
