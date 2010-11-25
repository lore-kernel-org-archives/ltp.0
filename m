Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <biannm@cn.fujitsu.com>) id 1PLXWg-0002VW-Cj
	for ltp-list@lists.sourceforge.net; Thu, 25 Nov 2010 08:49:58 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PLXWe-0007W8-0q
	for ltp-list@lists.sourceforge.net; Thu, 25 Nov 2010 08:49:58 +0000
Message-ID: <4CEE2299.1080605@cn.fujitsu.com>
Date: Thu, 25 Nov 2010 16:47:21 +0800
From: Bian Naimeng <biannm@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [RFC][POSIX][PATCH]Get rid of the test of
	pthread_mutex_getprioceiling
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi,

  The 1-1 and 3-3 do the same test, but they expect different result.
I do not know why?

However, i think we should get rid of 3-3. Because it looks like not a POSIX
compliant case.

---------------------------------------------------------------

Get rid of the test pthread_mutex_getprioceiling 3-3.

Signed-off-by: Bian Naimeng <biannm@cn.fujitsu.com>

---
 .../interfaces/pthread_mutex_getprioceiling/3-3.c  |   88 --------------------
 1 files changed, 0 insertions(+), 88 deletions(-)
 delete mode 100644 testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_getprioceiling/3-3.c

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_getprioceiling/3-3.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_getprioceiling/3-3.c
deleted file mode 100644
index 4aa6b1c..0000000
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_mutex_getprioceiling/3-3.c
+++ /dev/null
@@ -1,88 +0,0 @@
-/*   
- * Copyright (c) 2010, Garrett Cooper.
- *
- * Test that pthread_mutex_getprioceiling() fails because:
- *
- * [EINVAL]
- *     The protocol attribute of mutex is PTHREAD_PRIO_NONE.
- *
- * by explicitly specifying the protocol as PTHREAD_PRIO_NONE.
- *
- * Steps:
- * 1.  Initialize a pthread_mutexattr_t object with pthread_mutexattr_init()
- * 2.  Explicitly set the protocol using PTHREAD_PRIO_NONE.
- * 3.  Call pthread_mutex_getprioceiling() to obtain the prioceiling.
- * 
- */
-
-#include <pthread.h>
-#include <errno.h>
-#include <pwd.h>
-#include <sched.h>
-#include <stdio.h>
-#include <string.h>
-#include <unistd.h>
-#include "posixtest.h"
-
-int
-main(void)
-{
-#if defined(_SC_PRIORITY_SCHEDULING)
-
-	if (sysconf(_SC_PRIORITY_SCHEDULING) == -1) {
-		printf("PRIORITY_SCHEDULING not supported\n");
-		return PTS_UNSUPPORTED;
-	}
-
-	pthread_mutexattr_t mutex_attr;
-	pthread_mutex_t mutex;
-	int error, prioceiling;
-
-	error = pthread_mutexattr_init(&mutex_attr);
-	if (error) {
-		printf("pthread_mutexattr_init failed: %s\n", strerror(error));
-		return PTS_UNRESOLVED;
-	}
-
-	/* 
-	 * The default protocol is PTHREAD_PRIO_NONE according to
-	 * pthread_mutexattr_getprotocol.
-	 */
-	error = pthread_mutexattr_setprotocol(&mutex_attr,
-		PTHREAD_PRIO_INHERIT);
-	if (error) {
-		printf("pthread_mutexattr_setprotocol failed: %s\n",
-			strerror(error));
-		return PTS_UNRESOLVED;
-	}
-
-	/* Initialize a mutex object */
-	error = pthread_mutex_init(&mutex, &mutex_attr);
-	if (error) {
-		printf("pthread_mutex_init failed: %s\n", strerror(error));
-		return PTS_UNRESOLVED;
-	}
-
-	/* Get the prioceiling of the mutex. */
-	error = pthread_mutex_getprioceiling(&mutex, &prioceiling);
-	if (error) {
-		if (error == EINVAL) {
-			printf("pthread_mutex_getprioceiling failed as "
-				"expected\n");
-		} else {
-			printf("pthread_mutex_getprioceiling did not fail as "
-				"expected: %s\n", strerror(error));
-		}
-	} else
-		printf("pthread_mutex_getprioceiling passed unexpectedly\n");
-
-	(void) pthread_mutexattr_destroy(&mutex_attr);
-	(void) pthread_mutex_destroy(&mutex);
-
-	return (error == EINVAL ? PTS_PASS : PTS_UNRESOLVED);
-#else
-	printf("pthread_mutex_getprioceiling not supported");
-	return PTS_UNSUPPORTED;
-#endif
-
-}
-- 
1.7.0.4




-- 
Regards
Bian Naimeng


------------------------------------------------------------------------------
Increase Visibility of Your 3D Game App & Earn a Chance To Win $500!
Tap into the largest installed PC base & get more eyes on your game by
optimizing for Intel(R) Graphics Technology. Get started today with the
Intel(R) Software Partner Program. Five $500 cash prizes are up for grabs.
http://p.sf.net/sfu/intelisp-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
