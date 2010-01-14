Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <miaox@cn.fujitsu.com>) id 1NVKXi-0006SP-Fi
	for ltp-list@lists.sourceforge.net; Thu, 14 Jan 2010 07:54:58 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NVKXh-0000P6-2e
	for ltp-list@lists.sourceforge.net; Thu, 14 Jan 2010 07:54:58 +0000
Message-ID: <4B4ECD70.8000102@cn.fujitsu.com>
Date: Thu, 14 Jan 2010 15:53:20 +0800
From: Miao Xie <miaox@cn.fujitsu.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH] fix the bug of sched_getaffinity in
	cpuset_syscall_test
Reply-To: miaox@cn.fujitsu.com
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
To: Subrata Modak <subrata@linux.vnet.ibm.com>
Cc: LTP-ML <ltp-list@lists.sourceforge.net>

The 5th and 6th testcases of cpuset05 test failed because the len of cpu_set_t in the glibc is
smaller than the length of the cpumask in the kernel. So we must use the dynamically sized CPU
sets instead of the standard cpu_set_t.

This patch fix this problem.
Before using this patch, the test result is following:
cpuset05    5  TFAIL  :  Test task exited abnormally.(expect return value is 0)
cpuset05    6  TFAIL  :  Test task exited abnormally.(expect return value is 0)

After using this patch, the test result is following:
cpuset05    5  TPASS  :  Cpuset vs systemcall test succeeded.
cpuset05    6  TPASS  :  Cpuset vs systemcall test succeeded.

Signed-off-by: Miao Xie <miaox@cn.fujitsu.com>
---
 .../cpuset_syscall_test/cpuset_syscall_test.c      |   58 ++++++++++++++++++--
 1 files changed, 52 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_test.c b/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_test.c
index 77bb7d7..c0aada7 100644
--- a/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_test.c
+++ b/testcases/kernel/controllers/cpuset/cpuset_syscall_test/cpuset_syscall_test.c
@@ -57,6 +57,10 @@ int test = -1;
 int flag_exit;
 int ret;
 
+#if !(__GLIBC_PREREQ(2, 7))
+#define CPU_FREE(ptr) free(ptr)
+#endif
+
 /* Policies for set_mempolicy() */
 #define MPOL_DEFAULT     0
 #define MPOL_PREFERRED   1
@@ -161,14 +165,56 @@ void test_setaffinity(void)
 
 void test_getaffinity(void)
 {
-	cpu_set_t tmask;
-	int i;
-	CPU_ZERO(&tmask);
-	ret = sched_getaffinity(0, sizeof(tmask), &tmask);
-	for (i = 0; i < 8 * sizeof(mask); i++) {
-		if (CPU_ISSET(i, &tmask))
+	cpu_set_t *tmask;
+	int i, nrcpus = 1024;
+	size_t size;
+
+#if __GLIBC_PREREQ(2, 7)
+realloc:
+	tmask = CPU_ALLOC(nrcpus);
+#else
+	tmask = malloc(sizeof(cpu_set_t));
+#endif
+	if (tmask == NULL) {
+		warn("CPU_ALLOC:errno:%d", errno);
+		ret = -1;
+		return;
+	}
+
+#if __GLIBC_PREREQ(2, 7)
+	size = CPU_ALLOC_SIZE(nrcpus);
+	CPU_ZERO_S(size, tmask);
+#else
+	size = sizeof(cpu_set_t);
+	CPU_ZERO(tmask);
+#endif
+
+	ret = sched_getaffinity(0, size, tmask);
+	if (ret < 0) {
+		CPU_FREE(tmask);
+#if __GLIBC_PREREQ(2, 7)
+		if (errno == EINVAL && nrcpus < (1024 << 8)) {
+			nrcpus = nrcpus << 2;
+			ret = 0;
+			goto realloc;
+		}
+#else
+		if (errno == EINVAL)
+			warn("NR_CPUS of the kernel is more than 1024, so we'd better use a newer glibc(>= 2.7)");
+		else
+#endif
+			warn("sched_getaffinity:errno:%d", errno);
+		return;
+	}
+	for (i = 0; i < 8 * size; i++) {
+#if __GLIBC_PREREQ(2, 7)
+		if (CPU_ISSET_S(i, size, tmask))
+#else
+		if (CPU_ISSET(i, tmask))
+#endif
 			printf("%d,", i);
 	}
+	CPU_FREE(tmask);
 }
 
 void test_mbind(void)
-- 
1.6.5.2



------------------------------------------------------------------------------
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Conference
attendees to learn about information security's most important issues through
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
