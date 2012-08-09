Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Kai.Kang@windriver.com>) id 1SzQ1N-0001kz-Ap
	for ltp-list@lists.sourceforge.net; Thu, 09 Aug 2012 10:31:17 +0000
Received: from mail.windriver.com ([147.11.1.11])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1SzQ1J-0004ot-G0
	for ltp-list@lists.sourceforge.net; Thu, 09 Aug 2012 10:31:17 +0000
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id q79AV72N017212
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>;
	Thu, 9 Aug 2012 03:31:07 -0700 (PDT)
From: Kang Kai <kai.kang@windriver.com>
Date: Thu, 9 Aug 2012 18:30:58 +0800
Message-ID: <1344508258-25054-4-git-send-email-kai.kang@windriver.com>
In-Reply-To: <1344508258-25054-1-git-send-email-kai.kang@windriver.com>
References: <1344508258-25054-1-git-send-email-kai.kang@windriver.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 3/3] timer_settime/5-3: fix test hung
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
Cc: Zhenfeng.Zhao@windriver.com

This case hangs on sugarbay(intel x86_64) platform.

The root cause is that the case calls timer_settime with time which
already took place and then calls sleep. When the timer expires and
sends signal the sleep will be break.

But on sugarbay the timer always expires before the case enters sleep,
then it always sleeps NUMTESTS * LONGSLEEPTIME seconds. So it exceeds
the time limit set by auto-run test shell script, and reports that it
hangs.

Decrease LONGSLEEPTIME value to avoid this issue.

Signed-off-by: Kang Kai <kai.kang@windriver.com>
---
 .../conformance/interfaces/timer_settime/5-3.c     |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/5-3.c b/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/5-3.c
index 0ad1957..4a47458 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/5-3.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/timer_settime/5-3.c
@@ -27,7 +27,7 @@
 
 #define SIGTOTEST SIGALRM
 
-#define LONGSLEEPTIME 10
+#define LONGSLEEPTIME 5
 
 #define NUMTESTS 30
 
@@ -105,4 +105,4 @@ int main(int argc, char *argv[])
 
 	printf("This code should not be executed.\n");
 	return PTS_UNRESOLVED;
-}
\ No newline at end of file
+}
-- 
1.7.5.4


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
