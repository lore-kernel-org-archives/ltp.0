Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chris@mips.com>) id 1TO8GA-0008Io-Tf
	for ltp-list@lists.sourceforge.net; Tue, 16 Oct 2012 14:36:42 +0000
Received: from dns1.mips.com ([12.201.5.69])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1TO8G5-0007ZK-AV
	for ltp-list@lists.sourceforge.net; Tue, 16 Oct 2012 14:36:42 +0000
Received: from mailgate1.mips.com (mailgate1.mips.com [12.201.5.111])
	by dns1.mips.com (8.13.8/8.13.8) with ESMTP id q9GEHAH7028009
	for <ltp-list@lists.sourceforge.net>; Tue, 16 Oct 2012 07:17:11 -0700
Received: from exchdb01.mips.com (unknown [192.168.36.84])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mailgate1.mips.com (Postfix) with ESMTP id 20A4536465F
	for <ltp-list@lists.sourceforge.net>;
	Tue, 16 Oct 2012 07:17:07 -0700 (PDT)
Message-ID: <507D6C63.5040704@mips.com>
Date: Tue, 16 Oct 2012 07:17:07 -0700
From: Chris Dearman <chris@mips.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] Avoid compiler optimisation of malloc calls
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
Cc: Chris Dearman <chris@mips.com>

clang understands the malloc library call and can optimise calls to
it. In particular it will avoid calling malloc completely if it
detects that the result is not used.

Signed-off-by: Chris Dearman <chris@mips.com>
---
  .../conformance/interfaces/pthread_cond_init/4-1.c |   19 
++++++++++++-------
  1 files changed, 12 insertions(+), 7 deletions(-)

diff --git 
a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_init/4-1.c 
b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_init/4-1.c
index 287fda1..7932ec2 100644
--- 
a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_init/4-1.c
+++ 
b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_init/4-1.c
@@ -50,7 +50,7 @@
  #define ERR_MSG(f, rc) printf("Failed: func: %s rc: %s (%u)\n", \
  			f, strerror(rc), rc);
  -/* Max memory for child is 81B */
+/* Max memory for child is 1MB */
  #define MAX_MEM	((1<<20))
   /*
@@ -59,8 +59,8 @@
   */
  static void child(void)
  {
-	char *curr;
-	char *prev = NULL;
+	void *curr;
+	void *prev = NULL;
  	struct rlimit rl;
  	pthread_cond_t cond;
  	pthread_condattr_t attr;
@@ -76,10 +76,15 @@ static void child(void)
  		exit(PTS_UNRESOLVED);
  	}
  -	/* Consume all memory we can */
-	do {
-		curr = malloc(1);
-	} while (curr);
+	/*
+	 * Consume all memory we can
+	 * It's important to use the malloc() return value in a
+	 * meaningful way to bypass potential compiler optimisations.
+	 */
+	while ((curr = malloc(sizeof(void *)))) {
+		*(void **)curr = prev;
+		prev = curr;
+	}
  	if (errno != ENOMEM) {
  		ERR_MSG("malloc()", errno);
  		exit(PTS_UNRESOLVED);
-- 
1.7.1


------------------------------------------------------------------------------
Don't let slow site performance ruin your business. Deploy New Relic APM
Deploy New Relic app performance management and know exactly
what is happening inside your Ruby, Python, PHP, Java, and .NET app
Try New Relic at no cost today and get our sweet Data Nerd shirt too!
http://p.sf.net/sfu/newrelic-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
