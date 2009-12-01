Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1NFbIl-0000t0-3i
	for ltp-list@lists.sourceforge.net; Tue, 01 Dec 2009 22:34:31 +0000
Received: from fmmailgate03.web.de ([217.72.192.234])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NFbId-0007ct-GA
	for ltp-list@lists.sourceforge.net; Tue, 01 Dec 2009 22:34:31 +0000
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate03.web.de (Postfix) with ESMTP id 35311136ABE96
	for <ltp-list@lists.sourceforge.net>;
	Tue,  1 Dec 2009 23:34:17 +0100 (CET)
Received: from [90.180.172.144] (helo=debian)
	by smtp05.web.de with asmtp (WEB.DE 4.110 #314) id 1NFbIW-0004t0-00
	for ltp-list@lists.sourceforge.net; Tue, 01 Dec 2009 23:34:17 +0100
Date: Tue, 01 Dec 2009 23:32:22 +0100
From: "Jiri Palecek" <jpalecek@web.de>
MIME-Version: 1.0
Resent-To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>
Resent-Message-ID: <op.u396bnsucfnueu@debian>
Subject: [LTP] [PATCH] Fix a bug in awk code in rsh01
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
Message-ID: <20091201223222.vhSQTwM0QZuo2HAVP0y9qcjxdCEJg6eFPncVuopqlIw@z>

Hello,

this patch fixes the following problem with awk code in rsh01. It caused the test to fail.

 The END label is executed always, even in the event of
 exit. Therefore, the "exit 1" statement was executed even when the
 line matched (as a consequence of "exit 0") and awk always returned
 1 (ie. failure).

Regards
    Jiri Palecek

Signed-off-by: Jiri Palecek <jpalecek@web.de>
---
 testcases/network/tcp_cmds/rsh/rsh01 |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/network/tcp_cmds/rsh/rsh01 b/testcases/network/tcp_cmds/rsh/rsh01
index e87a6a0..0a2b58f 100755
--- a/testcases/network/tcp_cmds/rsh/rsh01
+++ b/testcases/network/tcp_cmds/rsh/rsh01
@@ -72,9 +72,9 @@ do_test()
             # gcooper@orangebox ~ $ ls -l /etc/hosts         
             # -rw-r--r-- 1 root root 463 Jul  5 09:26 /etc/hosts
             #
-            echo "$OUT" | \
-                awk 'NF == 9 && $NF == "/etc/hosts" { exit 0 } END { exit 1 }' \
-                >& /dev/null
+            echo "$OUT" |
+                awk 'BEGIN { RET=1 } NF == 9 && $NF == "/etc/hosts" { RET=0 } END { exit RET }' \
+                > /dev/null 2>&1
 
             if [ $? -eq 0 ] ; then
                 tst_resm TPASS "rsh to $RHOST test succeeded"
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
