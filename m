Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Kai.Kang@windriver.com>) id 1RbOVu-0003Vv-0J
	for ltp-list@lists.sourceforge.net; Fri, 16 Dec 2011 03:31:14 +0000
Received: from mail.windriver.com ([147.11.1.11])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RbOVs-0001TC-St
	for ltp-list@lists.sourceforge.net; Fri, 16 Dec 2011 03:31:13 +0000
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id pBG3V6mg014842
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>;
	Thu, 15 Dec 2011 19:31:06 -0800 (PST)
From: Kang Kai <kai.kang@windriver.com>
Date: Fri, 16 Dec 2011 11:31:00 +0800
Message-ID: <1324006260-10122-2-git-send-email-kai.kang@windriver.com>
In-Reply-To: <1324006260-10122-1-git-send-email-kai.kang@windriver.com>
References: <1324006260-10122-1-git-send-email-kai.kang@windriver.com>
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

Import a new semphore semsync2 to sync thread parent and child thread
'th_work', so that signal handlers are installed before receive signal
USR1 and USR2.

Signed-off-by: Kang Kai <kai.kang@windriver.com>
---
 .../interfaces/pthread_mutex_lock/3-1.c            |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_lock/3-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_lock/3-1.c
index 771851d..a735f73 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_lock/3-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_lock/3-1.c
@@ -96,6 +96,7 @@ sem_t semsig2;
 unsigned long count_sig=0;
 #endif
 sem_t semsync;
+sem_t semsync2;
 
 typedef struct
 {
@@ -165,6 +166,9 @@ void * threaded(void * arg)
 	if ((ret = sigaction (SIGUSR2, &sa, NULL)))
 	{ UNRESOLVED(ret, "Unable to register signal handler2"); }
 
+	if ((sem_post(&semsync2)))
+	{ UNRESOLVED(errno, "could not post semsync2"); }
+
 	/* Initialize the different mutex */
 	pma[4]=NULL;
 
@@ -301,12 +305,19 @@ int main (int argc, char * argv[])
 	if ((sem_init(&semsync, 0, 0)))
 	{ UNRESOLVED(errno, "semsync init"); }
 
+	if ((sem_init(&semsync2, 0, 0)))
+	{ UNRESOLVED(errno, "semsync2 init"); }
+
 	#if VERBOSE >1
 	output("Starting the worker thread\n");
 	#endif
 	if ((ret = pthread_create(&th_work, NULL, threaded, NULL)))
 	{ UNRESOLVED(ret, "Worker thread creation failed"); }
 
+	do {
+		ret = sem_wait(&semsync2);
+	} while (ret && (errno ==  EINTR));
+
 	arg1.thr = &th_work;
 	arg2.thr = &th_work;
 	arg1.sig = SIGUSR1;
@@ -359,4 +370,4 @@ int main (int argc, char * argv[])
 	#endif
 	#endif
 	PASSED;
-}
\ No newline at end of file
+}
-- 
1.7.5.4


------------------------------------------------------------------------------
Learn Windows Azure Live!  Tuesday, Dec 13, 2011
Microsoft is holding a special Learn Windows Azure training event for 
developers. It will provide a great way to learn Windows Azure and what it 
provides. You can attend the event by watching it streamed LIVE online.  
Learn more at http://p.sf.net/sfu/ms-windowsazure
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
