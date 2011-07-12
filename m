Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <carmelo.amoroso@st.com>) id 1QgdVY-0006IT-IZ
	for ltp-list@lists.sourceforge.net; Tue, 12 Jul 2011 14:00:16 +0000
Received: from eu1sys200aog119.obsmtp.com ([207.126.144.147])
	by sog-mx-2.v43.ch3.sourceforge.com with smtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1QgdVX-0005kd-35
	for ltp-list@lists.sourceforge.net; Tue, 12 Jul 2011 14:00:16 +0000
Received: from zeta.dmz-eu.st.com (ns2.st.com [164.129.230.9])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3A820D3
	for <ltp-list@lists.sourceforge.net>;
	Tue, 12 Jul 2011 14:00:02 +0000 (GMT)
Received: from mail7.sgp.st.com (unknown [164.129.223.81])
	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D2FD61D4F
	for <ltp-list@lists.sourceforge.net>;
	Tue, 12 Jul 2011 14:00:02 +0000 (GMT)
From: Carmelo AMOROSO <carmelo.amoroso@st.com>
Date: Tue, 12 Jul 2011 15:58:34 +0200
Message-Id: <1310479114-19326-1-git-send-email-carmelo.amoroso@st.com>
Subject: [LTP] [PATCH] shmctl01: fix misaligned access
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
To: ltp-list@lists.sourceforge.net

On architecture that are not able to handle in hardware
misaligned access, it could cause the application to be killed by a SIGBUS

So, the following simple assignment

void *test;
*(int *)test = stat_i;

causes on SH4 the following error:

Unaligned userspace access in "shmctl01" pid=8547 pc=0x0040221a ins=0x400b
Sending SIGBUS to "shmctl01" due to unaligned access (PC 40221a PR 40221e)

Using a 'memcpy' is safe.

Signed-off-by: Carmelo Amoroso <carmelo.amoroso@st.com>
---
 testcases/kernel/syscalls/ipc/shmctl/shmctl01.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c
index a37599a..38dcc12 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl01.c
@@ -325,7 +325,7 @@ void do_child()
 		tst_brkm(TBROK, cleanup, "sync_pipe_close failed");
 
 	/* do an assignement for fun */
-	*(int *)test = stat_i;
+	memcpy(test, &stat_i, sizeof(stat_i));
 
 	/* pause until we get a signal from stat_cleanup() */
 	rval = pause();
-- 
1.7.4.4


------------------------------------------------------------------------------
All of the data generated in your IT infrastructure is seriously valuable.
Why? It contains a definitive record of application performance, security 
threats, fraudulent activity, and more. Splunk takes this data and makes 
sense of it. IT sense. And common sense.
http://p.sf.net/sfu/splunk-d2d-c2
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
