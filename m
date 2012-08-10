Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <li.dan@cn.fujitsu.com>) id 1Szi0G-0004rD-Qz
	for ltp-list@lists.sourceforge.net; Fri, 10 Aug 2012 05:43:20 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Szi0E-0005oJ-SY
	for ltp-list@lists.sourceforge.net; Fri, 10 Aug 2012 05:43:20 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id q7A572u3024169
	for <ltp-list@lists.sourceforge.net>; Fri, 10 Aug 2012 13:07:04 +0800
Message-ID: <502496C6.3090906@cn.fujitsu.com>
Date: Fri, 10 Aug 2012 13:06:14 +0800
From: DAN LI <li.dan@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v4] pthread_cond_brodcast/1-2.c hung when mem left is
 not enough
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

pthread_cond_brodcast/1-2.c try to create as many childrens(thread or process) 
as possible,however,if current free memory is exhausted before all childrens are
started,the case will timeout and hung since it's stated with program "t0".
 
The patch adjust count of childrens according to judgement of size of current free
memory.

Signed-off-by: DAN LI <li.dan@cn.fujitsu.com>
---
 .../interfaces/pthread_cond_broadcast/1-2.c        |   47 ++++++++++++++++++--
 1 file changed, 43 insertions(+), 4 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_broadcast/1-2.c b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_broadcast/1-2.c
index f6ad9df..897448c 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_broadcast/1-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_broadcast/1-2.c
@@ -48,6 +48,7 @@
 #include <sys/mman.h>
 #include <sys/wait.h>
 #include <semaphore.h>
+#include <sys/sysinfo.h>
 
 #include "../testfrmw/testfrmw.h"
 #include "../testfrmw/testfrmw.c"
@@ -82,8 +83,8 @@
 #endif
 
 /* Do not create more than this amount of children: */
-#define MAX_PROCESS_CHILDREN  (200)
-#define MAX_THREAD_CHILDREN   (1000)
+static int max_process_children  = 200;
+static int max_thread_children = 1000;
 
 #define TIMEOUT  (180)
 
@@ -243,6 +244,42 @@ void *timer(void *arg)
 	return NULL; /* For compiler */
 }
 
+#ifdef __linux__
+static void children_number(void)
+{
+	struct sysinfo sysinformation;
+	int ret;
+	int avail_number;
+	unsigned long per_process;
+	unsigned long min_stack;
+
+	min_stack = sysconf(_SC_THREAD_STACK_MIN);
+
+	ret = sysinfo(&sysinformation);
+	if (ret != 0)
+		UNRESOLVED(ret, "Failed to get system information.");
+
+	per_process = min_stack * max_thread_children;
+	if (per_process > sysinformation.freeram)
+		UNTESTED("Not enough memory.");
+
+	avail_number = sysinformation.freeram / per_process;
+
+	if (avail_number < 10)
+		UNTESTED("Not enough memory.");
+
+	max_process_children = (avail_number < max_process_children ?
+					avail_number : max_process_children);
+
+	return;
+}
+#else 
+static void children_number(void)
+{
+	return;
+}
+#endif
+
 int main(int argc, char *argv[])
 {
 	int ret;
@@ -268,6 +305,8 @@ int main(int argc, char *argv[])
 
 	output_init();
 
+	children_number();
+
 	/* check the system abilities */
 	pshared = sysconf(_SC_THREAD_PROCESS_SHARED);
 	cs = sysconf(_SC_CLOCK_SELECTION);
@@ -476,7 +515,7 @@ int main(int argc, char *argv[])
 				} else {
 					ret = errno;
 				}
-			} while ((ret == 0) && (child_count < MAX_THREAD_CHILDREN));
+			} while ((ret == 0) && (child_count < max_thread_children));
 			#if VERBOSE > 2
 			output("[parent] Created %i children threads\n", child_count);
 			#endif
@@ -504,7 +543,7 @@ int main(int argc, char *argv[])
 				} else {
 					ret = errno;
 				}
-			} while ((ret == 0) && (child_count < MAX_PROCESS_CHILDREN));
+			} while ((ret == 0) && (child_count < max_process_children));
 			#if VERBOSE > 2
 			output("[parent] Created %i children processes\n", child_count);
 			#endif
-- 
1.7.10.2

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
