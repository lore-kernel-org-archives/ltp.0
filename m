Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Wei.Yang@windriver.com>) id 1RcwOm-0007vj-4W
	for ltp-list@lists.sourceforge.net; Tue, 20 Dec 2011 09:54:16 +0000
Received: from mail.windriver.com ([147.11.1.11])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RcwOg-0002Jk-8C
	for ltp-list@lists.sourceforge.net; Tue, 20 Dec 2011 09:54:16 +0000
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id pBK9s4AJ000765
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>;
	Tue, 20 Dec 2011 01:54:04 -0800 (PST)
From: <Wei.Yang@windriver.com>
Date: Tue, 20 Dec 2011 17:53:55 +0800
Message-ID: <1324374835-22722-2-git-send-email-Wei.Yang@windriver.com>
In-Reply-To: <1324374835-22722-1-git-send-email-Wei.Yang@windriver.com>
References: <1324374835-22722-1-git-send-email-Wei.Yang@windriver.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH 1/1] using mutex to protect the global variable
	accessed by muti-threads
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
Cc: wei.yang@windriver.com

From: Wei Yang <Wei.Yang@windriver.com>


Signed-off-by: Wei Yang <Wei.Yang@windriver.com>
---
 .../interfaces/pthread_barrier_wait/2-1.c          |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrier_wait/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrier_wait/2-1.c
index ec6b7f0..5b9ceea 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrier_wait/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_barrier_wait/2-1.c
@@ -38,6 +38,7 @@
 static pthread_barrier_t barrier;
 static int serial;
 static int normal_rt;
+static pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
 
 static void* fn_chld(void *arg)
 {
@@ -59,7 +60,9 @@ static void* fn_chld(void *arg)
 	}
 	else
 	{
+		pthread_mutex_lock(&mutex);
 		normal_rt++;
+		pthread_mutex_unlock(&mutex);
 	}
 
 	pthread_exit(0);
@@ -122,4 +125,4 @@ int main()
 
 	printf("\nTest PASSED\n");
 	return PTS_PASS;
-}
\ No newline at end of file
+}
-- 
1.7.0.2


------------------------------------------------------------------------------
Write once. Port to many.
Get the SDK and tools to simplify cross-platform app development. Create 
new or port existing apps to sell to consumers worldwide. Explore the 
Intel AppUpSM program developer opportunity. appdeveloper.intel.com/join
http://p.sf.net/sfu/intel-appdev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
