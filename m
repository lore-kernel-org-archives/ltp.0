Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <liwang@redhat.com>) id 1Z4mce-0006cd-49
	for ltp-list@lists.sourceforge.net; Tue, 16 Jun 2015 08:53:32 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Z4mcc-0005Rc-Iu
	for ltp-list@lists.sourceforge.net; Tue, 16 Jun 2015 08:53:32 +0000
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (Postfix) with ESMTPS id 71929374A13
	for <ltp-list@lists.sourceforge.net>;
	Tue, 16 Jun 2015 08:53:24 +0000 (UTC)
Received: from dhcp-13-206.nay.redhat.com (dhcp-12-104.nay.redhat.com
	[10.66.12.104])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id t5G8rLn3013889
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <ltp-list@lists.sourceforge.net>; Tue, 16 Jun 2015 04:53:23 -0400
From: Li Wang <liwang@redhat.com>
Date: Tue, 16 Jun 2015 16:53:19 +0800
Message-Id: <1434444799-29951-1-git-send-email-liwang@redhat.com>
Subject: [LTP] [PATCH] futex: regression test for take hugepages into
	account when generating futex_key
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

This issue fixed by:
	commit 13d60f4b6ab5b702dc8d2ee20999f98a93728aec
	Author: Zhang Yi <wetpzy@gmail.com>
	Date:   Tue Jun 25 21:19:31 2013 +0800
	    futex: Take hugepages into account when generating futex_key

Signed-off-by: Li Wang <liwang@redhat.com>
---
 runtest/syscalls                               |   1 +
 testcases/kernel/syscalls/futex/Makefile       |   1 +
 testcases/kernel/syscalls/futex/futex_wake04.c | 182 +++++++++++++++++++++++++
 3 files changed, 184 insertions(+)
 create mode 100644 testcases/kernel/syscalls/futex/futex_wake04.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 07bfc1e..1308536 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -1382,5 +1382,6 @@ futex_wait05 futex_wait05
 futex_wake01 futex_wake01
 futex_wake02 futex_wake02
 futex_wake03 futex_wake03
+futex_wake04 futex_wake04
 futex_wait_bitset01 futex_wait_bitset01
 futex_wait_bitset02 futex_wait_bitset02
diff --git a/testcases/kernel/syscalls/futex/Makefile b/testcases/kernel/syscalls/futex/Makefile
index d888734..6e72daf 100644
--- a/testcases/kernel/syscalls/futex/Makefile
+++ b/testcases/kernel/syscalls/futex/Makefile
@@ -22,6 +22,7 @@ futex_wait02: LDLIBS+=-lrt
 futex_wake03: LDLIBS+=-lrt
 futex_wait03: CFLAGS+=-pthread
 futex_wake02: CFLAGS+=-pthread
+futex_wake04: CFLAGS+=-pthread
 futex_wait05: LDLIBS+=-lrt
 futex_wait_bitset01: LDLIBS+=-lrt
 futex_wait_bitset02: LDLIBS+=-lrt
diff --git a/testcases/kernel/syscalls/futex/futex_wake04.c b/testcases/kernel/syscalls/futex/futex_wake04.c
new file mode 100644
index 0000000..b5da4a8
--- /dev/null
+++ b/testcases/kernel/syscalls/futex/futex_wake04.c
@@ -0,0 +1,182 @@
+/*
+ * Copyright (C) 2015  Yi Zhang <wetpzy@gmail.com>
+ *                     Li Wang <liwang@redhat.com>
+ *
+ * Licensed under the GNU GPLv2 or later.
+ * This program is free software;  you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY;  without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
+ * the GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program;  if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
+ */
+ /* DESCRIPTION:
+ *
+ *   It is a regression test for commit:
+ *   http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/
+ *   commit/?id=13d60f4
+ *
+ *   The implementation of futex doesn't produce unique keys for futexes
+ *   in shared huge pages, so threads waiting on different futexes may
+ *   end up on the same wait list. This results in incorrect threads being
+ *   woken by FUTEX_WAKE.
+ *
+ *   Needs to be run as root unless there are already enough huge pages available.
+ *   In the fail case, which happens in the CentOS-6.6 kernel (2.6.32-504.8.1),
+ *   the tests hangs until it times out after a 30-second wait.
+ *
+ */
+
+#include <stdio.h>
+#include <sys/mman.h>
+#include <fcntl.h>
+#include <pthread.h>
+#include <errno.h>
+#include <sys/time.h>
+#include <string.h>
+
+#include "test.h"
+#include "safe_macros.h"
+#include "futextest.h"
+
+#if __i386__ || __x86_64__
+#define HUGE_SIZE (2 * 1024 * 1024)
+
+#elif __powerpc__ || __powerpc64__
+#define HUGE_SIZE (16 * 1024 * 1024)
+
+#elif __s390__ || __s390x__
+#define HUGE_SIZE (1 * 1024 * 1024)
+
+#else
+#define HUGE_SIZE (2 * 1024 * 1024)
+#endif
+
+#define PATH_NR_HUGEPAGES "/proc/sys/vm/nr_hugepages"
+
+const char *TCID = "futex_wake04";
+const int TST_TOTAL = 1;
+
+static futex_t *futex1, *futex2;
+
+static long th2_wait_time;
+static int th2_wait_done;
+
+static long orig_hugepages;
+
+static void setup(void)
+{
+	tst_require_root(NULL);
+	tst_tmpdir();
+
+	SAFE_FILE_SCANF(NULL, PATH_NR_HUGEPAGES, "%ld", &orig_hugepages);
+	SAFE_FILE_PRINTF(NULL, PATH_NR_HUGEPAGES, "%d", 1);
+
+	TEST_PAUSE;
+}
+
+static void cleanup(void)
+{
+	SAFE_FILE_PRINTF(NULL, PATH_NR_HUGEPAGES, "%ld", orig_hugepages);
+
+	tst_rmdir();
+}
+
+static void *wait_thread1(void *arg LTP_ATTRIBUTE_UNUSED)
+{
+	futex_wait(futex1, *futex1, NULL, 0);
+
+	return NULL;
+}
+
+static void *wait_thread2(void *arg LTP_ATTRIBUTE_UNUSED)
+{
+	struct timeval tv;
+
+	gettimeofday(&tv, NULL);
+	th2_wait_time = tv.tv_sec;
+	futex_wait(futex2, *futex2, NULL, 0);
+
+	th2_wait_done = 1;
+	tst_resm(TPASS, "Hi hydra, thread2 awake!");
+
+	return NULL;
+}
+
+static void wakeup_thread2(void)
+{
+	void *addr;
+	int pgsz, wait_max_time = 30;
+	pthread_t th1, th2;
+	struct timeval tv;
+
+	/*allocate some shared memory*/
+	addr = mmap(NULL,
+			HUGE_SIZE,
+			PROT_READ | PROT_WRITE,
+			MAP_SHARED | MAP_ANONYMOUS | MAP_HUGETLB,
+			-1,
+			0);
+	if (addr == MAP_FAILED) {
+		printf("errno=%d\n", errno);
+		perror("mmap");
+		if (errno == ENOMEM) {
+			tst_brkm(TBROK | TERRNO, NULL,
+				"Probably system didn't actually create any huge pages.");
+		}
+	}
+
+	pgsz = getpagesize();
+
+	/*apply the first subpage to futex1*/
+	futex1 = addr;
+	*futex1 = 0;
+	/*apply the second subpage to futex2*/
+	futex2 = (futex_t *)((char *)addr + pgsz);
+	*futex2 = 0;
+
+	/*thread1 block on futex1 first,then thread2 block on futex2*/
+	pthread_create(&th1, NULL, wait_thread1, NULL);
+	sleep(2);
+	pthread_create(&th2, NULL, wait_thread2, NULL);
+	sleep(2);
+
+	/*try to wake up thread2*/
+	futex_wake(futex2, 1, 0);
+
+	/*see if thread2 can be woke up*/
+	while (!th2_wait_done) {
+		gettimeofday(&tv, NULL);
+		/*thread2 block over 30 secs, test fail*/
+		if (tv.tv_sec > (th2_wait_time + wait_max_time)) {
+			tst_resm(TFAIL,
+				"Bug: wait_thread2 did not wake after %ld secs.",
+				tv.tv_sec - th2_wait_time);
+			break;
+		}
+	}
+
+	munmap(addr, HUGE_SIZE);
+}
+
+int main(int argc, char *argv[])
+{
+	int lc;
+
+	tst_parse_opts(argc, argv, NULL, NULL);
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++)
+		wakeup_thread2();
+
+	cleanup();
+	tst_exit();
+}
-- 
1.8.3.1


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
