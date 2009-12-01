Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1NFb6q-0003Mx-Gc
	for ltp-list@lists.sourceforge.net; Tue, 01 Dec 2009 22:22:12 +0000
Received: from fmmailgate01.web.de ([217.72.192.221])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NFb6i-0005th-0d
	for ltp-list@lists.sourceforge.net; Tue, 01 Dec 2009 22:22:12 +0000
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate01.web.de (Postfix) with ESMTP id 9230913EF1C25
	for <ltp-list@lists.sourceforge.net>;
	Tue,  1 Dec 2009 23:21:54 +0100 (CET)
Received: from [90.180.172.144] (helo=debian)
	by smtp05.web.de with asmtp (WEB.DE 4.110 #314) id 1NFb6Y-0002WU-00
	for ltp-list@lists.sourceforge.net; Tue, 01 Dec 2009 23:21:54 +0100
Date: Tue, 01 Dec 2009 23:16:45 +0100
From: "Jiri Palecek" <jpalecek@web.de>
MIME-Version: 1.0
Resent-To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>
Resent-Message-ID: <op.u395q0uhcfnueu@debian>
Subject: [LTP] [PATCH] Fix a wrong (reversed) success condition in echo01
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
Message-ID: <20091201221645.M1H1HV_T2WjoaeqGROmdil02LKo1dekB-MPAGcVCbhA@z>

Hello,

this is the first of another series of small ltp fixes. I'm sorry I wasn't able to send them earlier.

This patch reverses the success check in echo01, obviously the checksums being equal is the right outcome.

Regards
    Jiri Palecek

Signed-off-by: Jiri Palecek <jpalecek@web.de>
---
 testcases/network/tcp_cmds/echo/echo01 |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/testcases/network/tcp_cmds/echo/echo01 b/testcases/network/tcp_cmds/echo/echo01
index eb798ae..2bc4621 100755
--- a/testcases/network/tcp_cmds/echo/echo01
+++ b/testcases/network/tcp_cmds/echo/echo01
@@ -95,7 +95,7 @@ do_test()
         while [ $NUM -lt $NUMPROCESSES ]
         do
             csum2=$(sum "$TCtmp/${ECHOFILE}${NUM}" | awk '{print $1}')
-            if [ "$csum1" = "$csum2" ]; then
+            if ! [ "$csum1" = "$csum2" ]; then
                 end_testcase "Checksums differ in loop $TST_COUNT"
             fi
             NUM=$(( $NUM + 1 ))
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
