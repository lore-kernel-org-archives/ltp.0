From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 20 Jul 2017 17:25:04 +0800
Subject: [LTP] [PATCH] syscalls/clone09.c: skip this test if net ns is not
	supported
Message-ID: <1500542704-4889-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

If net namespace is supported and disable, clone(CLONE_NEWNET) fails
and sets errno to EINVAL as expected.  However, If net namespace is
not supported(e.g. RHEL5.11GA), clone(CLONE_NEWNET) succeeds abnormally.
We add check if a new process has new network namespace to fix it.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/clone/clone09.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/testcases/kernel/syscalls/clone/clone09.c b/testcases/kernel/syscalls/clone/clone09.c
index 870c225..3456748 100644
--- a/testcases/kernel/syscalls/clone/clone09.c
+++ b/testcases/kernel/syscalls/clone/clone09.c
@@ -18,6 +18,9 @@
 #define _GNU_SOURCE
 #include <sched.h>
 #include <stdlib.h>
+#include <stdio.h>
+#include <sys/types.h>
+#include <unistd.h>
 #include <errno.h>
 
 #include "tst_test.h"
@@ -28,6 +31,7 @@
 static void *child_stack;
 static int sysctl_net = -1;
 static int sysctl_net_new = -1;
+static int ns_supported = 1;
 static const char sysctl_path[] = "/proc/sys/net/ipv4/conf/lo/tag";
 static const char sysctl_path_def[] = "/proc/sys/net/ipv4/conf/default/tag";
 static int flags = CLONE_NEWNET | CLONE_VM | SIGCHLD;
@@ -47,6 +51,12 @@ static void cleanup(void)
 
 static int newnet(void *arg LTP_ATTRIBUTE_UNUSED)
 {
+	char path[PATH_MAX];
+
+	sprintf(path, "/proc/%d/ns", getpid());
+	if (access(path, F_OK))
+		ns_supported = 0;
+
 	SAFE_FILE_SCANF(sysctl_path, "%d", &sysctl_net_new);
 	tst_syscall(__NR_exit, 0);
 	return 0;
@@ -77,6 +87,9 @@ static void do_test(void)
 	clone_child();
 	tst_reap_children();
 
+	if (!ns_supported)
+		tst_brk(TCONF, "Kernel does not support net ns");
+
 	if (sysctl_net_new == (sysctl_net + 1)) {
 		tst_res(TFAIL, "sysctl params equal: %s=%d",
 			sysctl_path, sysctl_net_new);
-- 
1.8.3.1



