Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <carmelo.amoroso@st.com>) id 1Qe6Yg-0005Lj-0M
	for ltp-list@lists.sourceforge.net; Tue, 05 Jul 2011 14:25:02 +0000
Received: from eu1sys200aog111.obsmtp.com ([207.126.144.131])
	by sog-mx-3.v43.ch3.sourceforge.com with smtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Qe6Ye-0003Ks-9b
	for ltp-list@lists.sourceforge.net; Tue, 05 Jul 2011 14:25:01 +0000
Received: from zeta.dmz-eu.st.com (ns2.st.com [164.129.230.9])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8B63F1DC
	for <ltp-list@lists.sourceforge.net>;
	Tue,  5 Jul 2011 14:24:25 +0000 (GMT)
Received: from mail7.sgp.st.com (mail7.sgp.st.com [164.129.223.81])
	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A5FB523B1
	for <ltp-list@lists.sourceforge.net>;
	Tue,  5 Jul 2011 14:24:25 +0000 (GMT)
From: Carmelo AMOROSO <carmelo.amoroso@st.com>
Date: Tue,  5 Jul 2011 16:24:12 +0200
Message-Id: <1309875852-3514-1-git-send-email-carmelo.amoroso@st.com>
Subject: [LTP] [PATCH] mq_timedsend01: do not write out of the array
	boundaries.
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

When preparing the message to be sent, limit the number of written bytes
to the array's size, otherwise it will be detected as a stack smashing attack
and the test case will be killed, as from the output below:

<<<test_start>>>
tag=mq_timedsend01 stime=948808768
cmdline="mq_timedsend01"
contacts=""
analysis=exit
<<<test_output>>>
incrementing stop

... [SNIP] ...

mq_timedsend01    0  TINFO  :  (case04) START
EXPECT: return value(ret)=-1 errno=90 (Message too long)
RESULT: return value(ret)=-1 errno=90 (Message too long)
stack smashing detected: mq_timedsend01 terminated()
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=signaled termination_id=6 corefile=no
cutime=0 cstime=2
<<<test_end>>>

Signed-off-by: Carmelo Amoroso <carmelo.amoroso@st.com>
---
 .../kernel/syscalls/mq_timedsend/mq_timedsend01.c  |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/syscalls/mq_timedsend/mq_timedsend01.c b/testcases/kernel/syscalls/mq_timedsend/mq_timedsend01.c
index 63add02..db2b272 100644
--- a/testcases/kernel/syscalls/mq_timedsend/mq_timedsend01.c
+++ b/testcases/kernel/syscalls/mq_timedsend/mq_timedsend01.c
@@ -367,7 +367,7 @@ static int do_test(struct test_case *tc)
 	/*
 	 * Prepare send message
 	 */
-	for (i = 0; i < tc->len; i++)
+	for (i = 0; i < tc->len && i < sizeof(smsg); i++)
 		smsg[i] = i;
 
 	/*
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
