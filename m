Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chris@mips.com>) id 1TOXWx-0003Zf-NH
	for ltp-list@lists.sourceforge.net; Wed, 17 Oct 2012 17:35:43 +0000
Received: from dns1.mips.com ([12.201.5.69])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1TOXWw-00077b-NG
	for ltp-list@lists.sourceforge.net; Wed, 17 Oct 2012 17:35:43 +0000
Received: from mailgate1.mips.com (mailgate1.mips.com [12.201.5.111])
	by dns1.mips.com (8.13.8/8.13.8) with ESMTP id q9HHZaie032390
	for <ltp-list@lists.sourceforge.net>; Wed, 17 Oct 2012 10:35:36 -0700
Received: from exchdb01.mips.com (unknown [192.168.36.84])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mailgate1.mips.com (Postfix) with ESMTP id 2097F364656
	for <ltp-list@lists.sourceforge.net>;
	Wed, 17 Oct 2012 10:35:36 -0700 (PDT)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MIMEBOUNDARY"
From: Chris Dearman <chris@mips.com>
Date: Wed, 17 Oct 2012 10:35:35 -0700
Message-ID: <20121017173535.11574.18883.stgit@localhost6.localdomain6>
In-Reply-To: <507D6C63.5040704@mips.com>
References: <507D6C63.5040704@mips.com>
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
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

--MIMEBOUNDARY
Content-Disposition: inline
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

clang understands the malloc library call and can optimise calls to
it. In particular it will avoid calling malloc completely if it
detects that the result is not used.

Signed-off-by: Chris Dearman <chris@mips.com>
---
 .../conformance/interfaces/pthread_cond_init/4-1.c |   19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

--MIMEBOUNDARY
Content-Disposition: attachment;
	filename="avoid-compiler-optimisation-of.patch"
MIME-Version: 1.0
Content-Type: text/plain; name="avoid-compiler-optimisation-of.patch";
	charset="utf-8"
Content-Transfer-Encoding: 7bit

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_init/4-1.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_init/4-1.c
index 287fda1..06accd6 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_init/4-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_init/4-1.c
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
+	 * It's importamt to use the malloc() return value in a
+	 * meaningful way to bypass potential compiler optimisations.
+	 */
+	while ((curr = malloc(sizeof(void *)))) {
+		*(void **)curr = prev;
+		prev = curr;
+	}
 	if (errno != ENOMEM) {
 		ERR_MSG("malloc()", errno);
 		exit(PTS_UNRESOLVED);

--MIMEBOUNDARY
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_sfd2d_oct
--MIMEBOUNDARY
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--MIMEBOUNDARY--

