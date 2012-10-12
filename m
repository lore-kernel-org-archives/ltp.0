Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <li.dan@cn.fujitsu.com>) id 1TMaO5-0006A1-V3
	for ltp-list@lists.sourceforge.net; Fri, 12 Oct 2012 08:14:29 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TMaNz-0006jF-N6
	for ltp-list@lists.sourceforge.net; Fri, 12 Oct 2012 08:14:29 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id q9C8EFpP012236
	for <ltp-list@lists.sourceforge.net>; Fri, 12 Oct 2012 16:14:15 +0800
Message-ID: <5077D10C.3040302@cn.fujitsu.com>
Date: Fri, 12 Oct 2012 16:13:00 +0800
From: DAN LI <li.dan@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v6] pthread_cond_brodcast/1-2.c hung when mem left is
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

pthread_cond_brodcast/1-2.c try to create as many childrens(thread or
process) as possible,however,if current free memory is exhausted before
all childrens are started,the case will timeout and hung since it's
stated with program "t0".

Signed-off-by: DAN LI <li.dan@cn.fujitsu.com>
---
 .../interfaces/pthread_cond_broadcast/1-2.c        | 16 +++------
 testcases/open_posix_testsuite/include/mem_info.h  | 40 ++++++++++++++++++++++
 2 files changed, 45 insertions(+), 11 deletions(-)
 create mode 100644 testcases/open_posix_testsuite/include/mem_info.h

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_broadcast/1-2.c
b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_broadcast/1-2.c
index b59bbfc..df93f4b 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_broadcast/1-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/pthread_cond_broadcast/1-2.c
@@ -50,6 +50,7 @@
 #include <semaphore.h>
 #include <sys/sysinfo.h>

+#include <mem_info.h>
 #include "../testfrmw/testfrmw.h"
 #include "../testfrmw/testfrmw.c"

@@ -244,20 +245,19 @@ void *timer(void *arg)
 	return NULL; /* For compiler */
 }

-#ifdef __linux__
 static void children_number(void)
 {
 	struct sysinfo sysinformation;
-	int ret;
 	int avail_number;
+	unsigned long freeram;
 	unsigned long per_process;
 	unsigned long min_stack;

 	min_stack = sysconf(_SC_THREAD_STACK_MIN);

-	ret = sysinfo(&sysinformation);
-	if (ret != 0)
-		UNRESOLVED(ret, "Failed to get system information.");
+	freeram = getfreeram();
+	if (freeram == 0)
+		return;

 	per_process = min_stack * max_thread_children;
 	if (per_process > sysinformation.freeram)
@@ -273,12 +273,6 @@ static void children_number(void)

 	return;
 }
-#else
-static void children_number(void)
-{
-	return;
-}
-#endif

 int main(int argc, char *argv[])
 {
diff --git a/testcases/open_posix_testsuite/include/mem_info.h b/testcases/open_posix_testsuite/include/mem_info.h
new file mode 100644
index 0000000..1669216
--- /dev/null
+++ b/testcases/open_posix_testsuite/include/mem_info.h
@@ -0,0 +1,40 @@
+/*
+ *
+ *   Copyright (c) 2012, DAN LI
+ *
+ *   This program is free software;  you can redistribute it and/or modify
+ *   it under the terms in version 2 of the GNU General Public License as
+ *   published by the Free Software Foundation.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ *   the GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program;  if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ *
+ *   Author:  DAN LI <li.dan AT cn fujitsu com>
+ *   Date:    10/12/2012
+ */
+
+#ifdef __linux__
+#include <sys/sysinfo.h>
+
+static int getfreeram(void)
+{
+	int ret;
+	struct sysinfo sysinformation;
+
+	ret = sysinfo(&sysinformation);
+	if (ret != 0)
+		return 0;
+	return sysinformation.freeram;
+}
+#else
+static int getfreeram(void)
+{
+	return 0;
+}
+#endif
-- 
1.7.12

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
