Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Kai.Kang@windriver.com>) id 1RWIx7-0001A0-S6
	for ltp-list@lists.sourceforge.net; Fri, 02 Dec 2011 02:34:17 +0000
Received: from mail.windriver.com ([147.11.1.11])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RWIx2-0000U7-7D
	for ltp-list@lists.sourceforge.net; Fri, 02 Dec 2011 02:34:17 +0000
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id pB22Y64t028612
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>;
	Thu, 1 Dec 2011 18:34:06 -0800 (PST)
From: Kang Kai <kai.kang@windriver.com>
Date: Fri, 2 Dec 2011 10:34:05 +0800
Message-ID: <1322793245-10780-1-git-send-email-kai.kang@windriver.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] pthread_mutex_lock/3-1: make sure install signal
	hanldler first
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

Test case failed for linux in some platform. Make parent thread
sleep for a while to make sure that signal handlers are installed
before send signal USR1 and USR2.

Signed-off-by: Kang Kai <kai.kang@windriver.com>
---
 .../interfaces/pthread_mutex_lock/3-1.c            |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_lock/3-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_lock/3-1.c
index 771851d..a648c96 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_lock/3-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_lock/3-1.c
@@ -307,6 +307,8 @@ int main (int argc, char * argv[])
 	if ((ret = pthread_create(&th_work, NULL, threaded, NULL)))
 	{ UNRESOLVED(ret, "Worker thread creation failed"); }
 
+	sleep(1);
+
 	arg1.thr = &th_work;
 	arg2.thr = &th_work;
 	arg1.sig = SIGUSR1;
@@ -359,4 +361,4 @@ int main (int argc, char * argv[])
 	#endif
 	#endif
 	PASSED;
-}
\ No newline at end of file
+}
-- 
1.7.5.4


------------------------------------------------------------------------------
All the data continuously generated in your IT infrastructure 
contains a definitive record of customers, application performance, 
security threats, fraudulent activity, and more. Splunk takes this 
data and makes sense of it. IT sense. And common sense.
http://p.sf.net/sfu/splunk-novd2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
