Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <li.dan@cn.fujitsu.com>) id 1U7H4n-0007IL-0h
	for ltp-list@lists.sourceforge.net; Mon, 18 Feb 2013 03:07:33 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1U7H4l-0002dW-CZ
	for ltp-list@lists.sourceforge.net; Mon, 18 Feb 2013 03:07:32 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id r1I37O3U008269
	for <ltp-list@lists.sourceforge.net>; Mon, 18 Feb 2013 11:07:24 +0800
Message-ID: <51219A7B.2020909@cn.fujitsu.com>
Date: Mon, 18 Feb 2013 11:05:31 +0800
From: DAN LI <li.dan@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP]  [PATCH] kill/1-2.c: fix potential bug
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
To: LTP list <ltp-list@lists.sourceforge.net>


If fork() fails,this case will cause unexpected problem when kill(-1,...) called by root.

Signed-off-by: DAN LI <li.dan@cn.fujitsu.com>
---
 .../conformance/interfaces/kill/1-2.c              | 35 ++++++++++++++--------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/kill/1-2.c
b/testcases/open_posix_testsuite/conformance/interfaces/kill/1-2.c
index 26580ec..18aad8a 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/kill/1-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/kill/1-2.c
@@ -1,10 +1,3 @@
-#include <signal.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <sys/wait.h>
-#include "posixtest.h"
-
 /*
  * Copyright (c) 2002-2003, Intel Corporation. All rights reserved.
  * Created by:  julie.n.fleischer REMOVE-THIS AT intel DOT com
@@ -31,6 +24,13 @@
  *  the parent's signal.  If that is not the case, this test will fail.
  */

+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <sys/wait.h>
+#include "posixtest.h"
+
 #define SIGTOTEST SIGUSR1

 void myhandler(int signo)
@@ -44,16 +44,19 @@ int main()

 	int sig;
 	sigset_t set;
+
 	if (sigemptyset(&set) == -1) {
 		perror("Error calling sigemptyset\n");
 		return PTS_UNRESOLVED;
 	}
+
 	if (sigaddset(&set, SIGTOTEST) == -1) {
 		perror("Error calling sigaddset\n");
 		return PTS_UNRESOLVED;
 	}

-	if ((pid = fork()) == 0) {
+	pid = fork();
+	if (pid == 0) {
 		/* child here */
 		struct sigaction act;
 		act.sa_handler = myhandler;
@@ -62,16 +65,18 @@ int main()
 		sigaction(SIGTOTEST, &act, 0);

 		if (0 != sigwait(&set, &sig)) {
-			printf
-			    ("Sigwait did not return 0. Possible problem with sigwait function\n");
-			return 0;	/* FAIL */
+			printf("Sigwait did not return 0."
+				"Possible problem with sigwait function\n");
+			/* FAIL */
+			return 0;
 		}

 		if (sig != SIGTOTEST)
-			return 0;	/* FAIL */
+			/* FAIL */
+			return 0;

 		return 1;
-	} else {
+	} else if (pid > 0) {
 		/* parent here */
 		int i;

@@ -95,6 +100,10 @@ int main()
 			printf("Test FAILED\n");
 			return PTS_FAIL;
 		}
+
+	} else {
+		printf("Error fork() a child\n");
+		return PTS_UNRESOLVED;
 	}

 	printf("Should have exited from parent\n");
-- 
1.7.12

------------------------------------------------------------------------------
The Go Parallel Website, sponsored by Intel - in partnership with Geeknet, 
is your hub for all things parallel software development, from weekly thought 
leadership blogs to news, videos, case studies, tutorials, tech docs, 
whitepapers, evaluation guides, and opinion stories. Check out the most 
recent posts - join the conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
