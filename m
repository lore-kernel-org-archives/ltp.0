Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1NFbAG-00034Q-Oe
	for ltp-list@lists.sourceforge.net; Tue, 01 Dec 2009 22:25:44 +0000
Received: from fmmailgate02.web.de ([217.72.192.227])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NFbAA-0005zN-0R
	for ltp-list@lists.sourceforge.net; Tue, 01 Dec 2009 22:25:44 +0000
Received: from smtp06.web.de (fmsmtp06.dlan.cinetic.de [172.20.5.172])
	by fmmailgate02.web.de (Postfix) with ESMTP id 92D9A1460599B
	for <ltp-list@lists.sourceforge.net>;
	Tue,  1 Dec 2009 23:25:31 +0100 (CET)
Received: from [90.180.172.144] (helo=debian)
	by smtp06.web.de with asmtp (WEB.DE 4.110 #314) id 1NFbA3-0005sj-00
	for ltp-list@lists.sourceforge.net; Tue, 01 Dec 2009 23:25:31 +0100
Date: Tue, 01 Dec 2009 23:22:08 +0100
From: "Jiri Palecek" <jpalecek@web.de>
MIME-Version: 1.0
Resent-To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>
Resent-Message-ID: <op.u395w1xxcfnueu@debian>
Subject: [LTP] [PATCH] Don't fail the ssh tests if the home directory we are
 creating already exists (eg. when it was created by adduser)
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
Message-ID: <20091201222208.dIQQNufxr9SmtH0nf2hjkf84t4OrrZe7OeO5WokQSKY@z>

Hello,

this patch silences the error message "mkdir: directory already exists" in ssh tests, caused by the code that handles home directory creation in case adduser didn't do it. Unfortunately, the same code failed when adduser did create the directory.

Regards
    Jiri Palecek

Signed-off-by: Jiri Palecek <jpalecek@web.de>
---
 testcases/network/tcp_cmds/ssh/ssh01 |    2 +-
 testcases/network/tcp_cmds/ssh/ssh02 |    2 +-
 testcases/network/tcp_cmds/ssh/ssh03 |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/network/tcp_cmds/ssh/ssh01 b/testcases/network/tcp_cmds/ssh/ssh01
index 657449a..718f198 100755
--- a/testcases/network/tcp_cmds/ssh/ssh01
+++ b/testcases/network/tcp_cmds/ssh/ssh01
@@ -57,7 +57,7 @@ do_setup()
     # in adduser)
     USER_UID=$(id -u $TEST_USER)
     USER_GID=$(id -g $TEST_USER)
-    if ! mkdir "$TEST_USER_HOMEDIR"; then
+    if ! mkdir -p "$TEST_USER_HOMEDIR"; then
         end_testcase "Failed to create $TEST_USER_HOMEDIR"
     fi
     chown -Rf $USER_UID.$USER_GID "$TEST_USER_HOMEDIR"
diff --git a/testcases/network/tcp_cmds/ssh/ssh02 b/testcases/network/tcp_cmds/ssh/ssh02
index 84c3637..a9974a0 100755
--- a/testcases/network/tcp_cmds/ssh/ssh02
+++ b/testcases/network/tcp_cmds/ssh/ssh02
@@ -59,7 +59,7 @@ do_setup()
     # in adduser)
     USER_UID=$(id -u $TEST_USER)
     USER_GID=$(id -g $TEST_USER)
-    if ! mkdir "$TEST_USER_HOMEDIR"; then
+    if ! mkdir -p "$TEST_USER_HOMEDIR"; then
         end_testcase "Failed to create $TEST_USER_HOMEDIR"
     fi
     chown -R $USER_UID.$USER_GID "$TEST_USER_HOMEDIR"
diff --git a/testcases/network/tcp_cmds/ssh/ssh03 b/testcases/network/tcp_cmds/ssh/ssh03
index 5c7305e..927db76 100755
--- a/testcases/network/tcp_cmds/ssh/ssh03
+++ b/testcases/network/tcp_cmds/ssh/ssh03
@@ -58,7 +58,7 @@ do_setup()
     # in adduser)
     USER_UID=$(id -u $TEST_USER)
     USER_GID=$(id -g $TEST_USER)
-    if ! mkdir "$TEST_USER_HOMEDIR"; then
+    if ! mkdir -p "$TEST_USER_HOMEDIR"; then
         end_testcase "Failed to create $TEST_USER_HOMEDIR"
     fi
     chown -R $USER_UID.$USER_GID "$TEST_USER_HOMEDIR"
-- 
1.6.4.3




------------------------------------------------------------------------------
Join us December 9, 2009 for the Red Hat Virtual Experience,
a free event focused on virtualization and cloud computing. 
Attend in-depth sessions from your desk. Your couch. Anywhere.
http://p.sf.net/sfu/redhat-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
