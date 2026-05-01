Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DB88CCFA13
	for <ltp@archiver.kernel.org>; Fri,  1 May 2026 13:51:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CF5523E49AC
	for <ltp@archiver.kernel.org>; Fri,  1 May 2026 15:51:45 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7C9E53E2109
 for <ltp@lists.linux.it>; Fri,  1 May 2026 15:51:32 +0200 (CEST)
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::ae])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9854F601B06
 for <ltp@lists.linux.it>; Fri,  1 May 2026 15:51:28 +0200 (CEST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1777643488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=4Db81s7sp1MB669wKUHREHNIp08X7GWFng7zQ3UkSlM=;
 b=A7XONnkhw+Mtbulmfle5F/OjMgF2T61w752haEr4ZQa3mEV2VPNarH4APTi1NWWE7+ijyq
 GMrtjzTx4s/uCoP78Di8ZmsHAyhC1Vw8ETX9hDn5Xy+mWfel9kzp3gIaSucnZXqKDfnrTb
 tSomCWAxXU/32hdZ4/s9+JucuW0fjAQ=
From: Li Wang <li.wang@linux.dev>
To: ltp@lists.linux.it
Date: Fri,  1 May 2026 21:51:00 +0800
Message-ID: <20260501135100.42278-1-li.wang@linux.dev>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] lib: Introduce tst_path.h to consolidate system paths
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Currently, definitions for various /proc and /sys paths are scattered
across multiple testcases and library files, often as hardcoded strings
or redundant macros.

This patch introduces a new common header, tst_path.h, to centralize
and standardize these path definitions. By unifying these macros, we
reduce code duplication, improve maintainability, and ensure consistent
path usage across the entire LTP codebase.

Signed-off-by: Li Wang <li.wang@linux.dev>
---
 include/tst_hugepage.h                        | 10 +----
 include/tst_path.h                            | 41 +++++++++++++++++++
 include/tst_test.h                            |  1 +
 lib/newlib_tests/test19.c                     |  6 +--
 lib/newlib_tests/test20.c                     |  4 +-
 lib/tst_hugepage.c                            |  4 +-
 testcases/cve/cve-2015-3290.c                 |  6 +--
 testcases/cve/cve-2017-16939.c                |  2 +-
 testcases/cve/cve-2022-4378.c                 | 16 ++++----
 testcases/cve/icmp_rate_limit01.c             |  2 +-
 testcases/cve/tcindex01.c                     |  2 +-
 testcases/kernel/containers/pidns/pidns05.c   |  2 +-
 testcases/kernel/containers/userns/userns01.c |  4 +-
 .../containers/userns/userns06_capcheck.c     |  2 +-
 testcases/kernel/containers/userns/userns07.c |  2 +-
 testcases/kernel/containers/userns/userns08.c |  8 ++--
 testcases/kernel/include/ksm_helper.h         |  2 +-
 testcases/kernel/logging/kmsg/kmsg01.c        |  4 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap05.c  |  8 +---
 .../kernel/mem/hugetlb/hugemmap/hugemmap32.c  | 11 +++--
 .../kernel/mem/hugetlb/hugemmap/hugemmap34.c  |  1 -
 .../mem/hugetlb/hugeshmat/hugeshmat04.c       |  2 +-
 .../mem/hugetlb/hugeshmget/hugeshmget03.c     |  2 +-
 testcases/kernel/mem/hugetlb/lib/hugetlb.h    |  2 +-
 testcases/kernel/mem/ksm/ksm01.c              | 10 ++---
 testcases/kernel/mem/ksm/ksm02.c              | 10 ++---
 testcases/kernel/mem/ksm/ksm03.c              | 10 ++---
 testcases/kernel/mem/ksm/ksm04.c              | 10 ++---
 testcases/kernel/mem/ksm/ksm05.c              |  4 +-
 testcases/kernel/mem/ksm/ksm06.c              | 10 ++---
 testcases/kernel/mem/ksm/ksm07.c              |  8 ++--
 testcases/kernel/mem/oom/oom.h                | 11 ++---
 testcases/kernel/mem/oom/oom01.c              |  2 -
 testcases/kernel/mem/oom/oom02.c              |  2 +-
 testcases/kernel/mem/oom/oom03.c              |  2 +-
 testcases/kernel/mem/oom/oom04.c              |  2 +-
 testcases/kernel/mem/oom/oom05.c              |  2 +-
 testcases/kernel/mem/thp/thp.h                |  2 +-
 .../kernel/sched/sysctl/proc_sched_rt01.c     |  6 +--
 .../kernel/syscalls/fanotify/fanotify10.c     |  9 ++--
 testcases/kernel/syscalls/fcntl/fcntl35.c     | 10 ++---
 testcases/kernel/syscalls/inotify/inotify07.c |  2 +-
 testcases/kernel/syscalls/inotify/inotify08.c |  2 +-
 .../kernel/syscalls/io_uring/io_uring01.c     |  2 +-
 .../kernel/syscalls/io_uring/io_uring02.c     |  2 +-
 .../kernel/syscalls/io_uring/io_uring03.c     |  2 +-
 .../kernel/syscalls/ipc/msgget/msgget03.c     |  2 +-
 .../kernel/syscalls/ipc/msgget/msgget04.c     |  2 +-
 .../kernel/syscalls/ipc/msgget/msgget05.c     |  2 +-
 .../kernel/syscalls/ipc/semget/semget05.c     |  4 +-
 .../kernel/syscalls/ipc/shmctl/shmctl03.c     |  6 +--
 .../kernel/syscalls/ipc/shmget/shmget02.c     |  2 +-
 .../kernel/syscalls/ipc/shmget/shmget03.c     |  2 +-
 .../kernel/syscalls/ipc/shmget/shmget05.c     |  2 +-
 .../kernel/syscalls/ipc/shmget/shmget06.c     |  2 +-
 testcases/kernel/syscalls/keyctl/keyctl02.c   |  2 +-
 testcases/kernel/syscalls/madvise/madvise01.c |  1 -
 testcases/kernel/syscalls/madvise/madvise02.c |  3 +-
 testcases/kernel/syscalls/madvise/madvise06.c |  2 +-
 testcases/kernel/syscalls/madvise/madvise08.c |  2 +-
 .../syscalls/migrate_pages/migrate_pages02.c  |  2 +-
 testcases/kernel/syscalls/mmap/mmap10.c       |  2 +-
 .../kernel/syscalls/move_pages/move_pages12.c | 10 ++---
 .../kernel/syscalls/newuname/newuname01.c     |  8 ++--
 .../perf_event_open/perf_event_open02.c       |  2 +-
 testcases/kernel/syscalls/pkeys/pkey01.c      |  1 -
 testcases/kernel/syscalls/preadv2/preadv203.c |  2 +-
 .../kernel/syscalls/readahead/readahead02.c   |  5 +--
 .../sched_rr_get_interval01.c                 |  2 +-
 testcases/kernel/syscalls/sendmsg/sendmsg03.c |  2 +-
 testcases/kernel/syscalls/sendto/sendto03.c   |  2 +-
 testcases/kernel/syscalls/setpgid/setpgid02.c |  2 +-
 .../kernel/syscalls/setsockopt/setsockopt05.c |  2 +-
 .../kernel/syscalls/setsockopt/setsockopt06.c |  2 +-
 .../kernel/syscalls/setsockopt/setsockopt08.c |  2 +-
 .../kernel/syscalls/setsockopt/setsockopt09.c |  2 +-
 testcases/kernel/syscalls/splice/splice.h     |  8 ++--
 testcases/kernel/syscalls/splice/splice06.c   |  4 +-
 testcases/kernel/syscalls/syslog/syslog11.c   |  2 +-
 testcases/kernel/syscalls/wait4/wait402.c     |  2 +-
 testcases/kernel/syscalls/waitid/waitid10.c   |  2 +-
 testcases/network/iptables/nft02.c            |  2 +-
 testcases/network/packet/fanout01.c           |  2 +-
 83 files changed, 195 insertions(+), 173 deletions(-)
 create mode 100644 include/tst_path.h

diff --git a/include/tst_hugepage.h b/include/tst_hugepage.h
index 6b865b2f2..0fca9b91f 100644
--- a/include/tst_hugepage.h
+++ b/include/tst_hugepage.h
@@ -6,15 +6,7 @@
 #ifndef TST_HUGEPAGE__
 #define TST_HUGEPAGE__
 
-#define PATH_HUGEPAGES	"/sys/kernel/mm/hugepages/"
-#define PATH_NR_HPAGES	"/proc/sys/vm/nr_hugepages"
-#define PATH_OC_HPAGES "/proc/sys/vm/nr_overcommit_hugepages"
-
-#define MEMINFO_HPAGE_TOTAL  "HugePages_Total:"
-#define MEMINFO_HPAGE_FREE   "HugePages_Free:"
-#define MEMINFO_HPAGE_RSVD   "HugePages_Rsvd:"
-#define MEMINFO_HPAGE_SURP   "HugePages_Surp:"
-#define MEMINFO_HPAGE_SIZE   "Hugepagesize:"
+#include "tst_path.h"
 
 extern char *nr_opt; /* -s num   Set the number of the been allocated hugepages */
 extern char *Hopt;   /* -H /..   Location of hugetlbfs, i.e.  -H /var/hugetlbfs */
diff --git a/include/tst_path.h b/include/tst_path.h
new file mode 100644
index 000000000..cfe6b6227
--- /dev/null
+++ b/include/tst_path.h
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) Linux Test Project, 2026
+ * Copyright (c) 2026 Li Wang <li.wang@linux.dev>
+ */
+
+#ifndef TST_PATH__
+#define TST_PATH__
+
+/* PROC */
+#define PROC_SYS_VM	"/proc/sys/vm/"
+#define PROC_SYS_FS	"/proc/sys/fs/"
+#define PROC_SYS_NET	"/proc/sys/net/"
+#define PROC_SYS_USER	"/proc/sys/user/"
+#define PROC_SYS_KERNEL	"/proc/sys/kernel/"
+
+/* SYS */
+#define SYS_KERNEL_MM	"/sys/kernel/mm/"
+#define PATH_HUGEPAGES	SYS_KERNEL_MM "hugepages/"
+
+/* VM */
+#define PATH_NR_HPAGES       PROC_SYS_VM "nr_hugepages"
+#define PATH_OC_HPAGES       PROC_SYS_VM "nr_overcommit_hugepages"
+#define PATH_DROP_CACHES     PROC_SYS_VM "drop_caches"
+#define PATH_COMPACT_MEMORY  PROC_SYS_VM "compact_memory"
+
+/* THP */
+#define PATH_THP	SYS_KERNEL_MM "transparent_hugepage/"
+
+/* MEMINFO */
+#define MEMINFO_HPAGE_TOTAL  "HugePages_Total:"
+#define MEMINFO_HPAGE_FREE   "HugePages_Free:"
+#define MEMINFO_HPAGE_RSVD   "HugePages_Rsvd:"
+#define MEMINFO_HPAGE_SURP   "HugePages_Surp:"
+#define MEMINFO_HPAGE_SIZE   "Hugepagesize:"
+
+/* KSM */
+#define PATH_KSM	SYS_KERNEL_MM "ksm/"
+#define KSM_FP(s)	(PATH_KSM s)
+
+#endif /* TST_PATH_H */
diff --git a/include/tst_test.h b/include/tst_test.h
index f12c59f39..4898cfe4c 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -26,6 +26,7 @@
 #include "tst_mkfs.h"
 #include "tst_fs.h"
 #include "tst_pid.h"
+#include "tst_path.h"
 #include "tst_cmd.h"
 #include "tst_cpu.h"
 #include "tst_process_state.h"
diff --git a/lib/newlib_tests/test19.c b/lib/newlib_tests/test19.c
index a5683eaa4..0a7766192 100644
--- a/lib/newlib_tests/test19.c
+++ b/lib/newlib_tests/test19.c
@@ -10,7 +10,7 @@
 
 static void setup(void)
 {
-	SAFE_FILE_PRINTF("/proc/sys/kernel/core_pattern", "changed");
+	SAFE_FILE_PRINTF(PROC_SYS_KERNEL "core_pattern", "changed");
 	tst_sys_conf_dump();
 }
 
@@ -25,8 +25,8 @@ static struct tst_test test = {
 	.setup = setup,
 	.save_restore = (const struct tst_path_val[]) {
 		{"/proc/nonexistent", NULL, TST_SR_SKIP},
-		{"/proc/sys/kernel/numa_balancing", NULL, TST_SR_TBROK},
-		{"/proc/sys/kernel/core_pattern", NULL, TST_SR_TCONF},
+		{PROC_SYS_KERNEL "numa_balancing", NULL, TST_SR_TBROK},
+		{PROC_SYS_KERNEL "core_pattern", NULL, TST_SR_TCONF},
 		{}
 	},
 };
diff --git a/lib/newlib_tests/test20.c b/lib/newlib_tests/test20.c
index 3726cea0e..31b3ccf92 100644
--- a/lib/newlib_tests/test20.c
+++ b/lib/newlib_tests/test20.c
@@ -16,7 +16,7 @@ static void do_test(void) {
 	unsigned long val, hpages;
 
 	tst_res(TINFO, "tst_hugepages = %lu", tst_hugepages);
-	SAFE_FILE_PRINTF("/proc/sys/kernel/numa_balancing", "1");
+	SAFE_FILE_PRINTF(PROC_SYS_KERNEL "numa_balancing", "1");
 
 	hpages = test.hugepages.number;
 	SAFE_FILE_SCANF(PATH_NR_HPAGES, "%lu", &val);
@@ -39,7 +39,7 @@ static struct tst_test test = {
 	.test_all = do_test,
 	.hugepages = {2, TST_NEEDS},
 	.save_restore = (const struct tst_path_val[]) {
-		{"/proc/sys/kernel/numa_balancing", "0", TST_SR_TBROK},
+		{PROC_SYS_KERNEL "numa_balancing", "0", TST_SR_TBROK},
 		{}
 	},
 };
diff --git a/lib/tst_hugepage.c b/lib/tst_hugepage.c
index d2e70a955..27c07f04b 100644
--- a/lib/tst_hugepage.c
+++ b/lib/tst_hugepage.c
@@ -46,8 +46,8 @@ unsigned long tst_reserve_hugepages(struct tst_hugepage *hp)
 		goto set_hugepages;
 	}
 
-	SAFE_FILE_PRINTF("/proc/sys/vm/drop_caches", "3");
-	SAFE_FILE_PRINTF("/proc/sys/vm/compact_memory", "1");
+	SAFE_FILE_PRINTF(PATH_DROP_CACHES, "3");
+	SAFE_FILE_PRINTF(PATH_COMPACT_MEMORY, "1");
 	if (hp->policy == TST_NEEDS) {
 		tst_hugepages += SAFE_READ_MEMINFO("HugePages_Total:");
 		goto set_hugepages;
diff --git a/testcases/cve/cve-2015-3290.c b/testcases/cve/cve-2015-3290.c
index cb60582b4..7a2f8ab38 100644
--- a/testcases/cve/cve-2015-3290.c
+++ b/testcases/cve/cve-2015-3290.c
@@ -466,12 +466,12 @@ static void setup(void)
          * knowing if perf_event_open() support is enabled is checking for
          * the existence of the file /proc/sys/kernel/perf_event_paranoid.
          */
-	if (access("/proc/sys/kernel/perf_event_paranoid", F_OK) == -1)
+	if (access(PROC_SYS_KERNEL "perf_event_paranoid", F_OK) == -1)
 		tst_brk(TCONF, "Kernel doesn't have perf_event support");
 
-	SAFE_FILE_SCANF("/proc/sys/kernel/perf_event_mlock_kb",
+	SAFE_FILE_SCANF(PROC_SYS_KERNEL "perf_event_mlock_kb",
 			"%d", &event_mlock_kb);
-	SAFE_FILE_SCANF("/proc/sys/kernel/perf_event_max_sample_rate",
+	SAFE_FILE_SCANF(PROC_SYS_KERNEL "perf_event_max_sample_rate",
 			"%d", &max_sample_rate);
 }
 
diff --git a/testcases/cve/cve-2017-16939.c b/testcases/cve/cve-2017-16939.c
index 098a86841..175aed8f3 100644
--- a/testcases/cve/cve-2017-16939.c
+++ b/testcases/cve/cve-2017-16939.c
@@ -91,7 +91,7 @@ static struct tst_test test = {
 		NULL
 	},
 	.save_restore = (const struct tst_path_val[]) {
-		{"/proc/sys/user/max_user_namespaces", "1024", TST_SR_SKIP},
+		{PROC_SYS_USER "max_user_namespaces", "1024", TST_SR_SKIP},
 		{}
 	},
 	.tags = (const struct tst_tag[]) {
diff --git a/testcases/cve/cve-2022-4378.c b/testcases/cve/cve-2022-4378.c
index e7e2b9af3..124e60a2e 100644
--- a/testcases/cve/cve-2022-4378.c
+++ b/testcases/cve/cve-2022-4378.c
@@ -22,13 +22,13 @@ static struct testcase {
 	const char *path;
 	int err;
 } testcase_list[] = {
-	{"/proc/sys/net/ipv4/icmp_ratelimit", EINVAL},
-	{"/proc/sys/net/ipv4/icmp_ratemask", EINVAL},
-	{"/proc/sys/net/ipv4/icmp_echo_ignore_all", EINVAL},
-	{"/proc/sys/net/ipv4/tcp_probe_interval", EINVAL},
-	{"/proc/sys/net/ipv4/tcp_keepalive_time", EINVAL},
-	{"/proc/sys/net/ipv4/tcp_notsent_lowat", EINVAL},
-	{"/proc/sys/net/ipv4/ip_local_reserved_ports", 0}
+	{PROC_SYS_NET "ipv4/icmp_ratelimit", EINVAL},
+	{PROC_SYS_NET "ipv4/icmp_ratemask", EINVAL},
+	{PROC_SYS_NET "ipv4/icmp_echo_ignore_all", EINVAL},
+	{PROC_SYS_NET "ipv4/tcp_probe_interval", EINVAL},
+	{PROC_SYS_NET "ipv4/tcp_keepalive_time", EINVAL},
+	{PROC_SYS_NET "ipv4/tcp_notsent_lowat", EINVAL},
+	{PROC_SYS_NET "ipv4/ip_local_reserved_ports", 0}
 };
 
 static void setup(void)
@@ -93,7 +93,7 @@ static struct tst_test test = {
 		NULL
 	},
 	.save_restore = (const struct tst_path_val[]) {
-		{"/proc/sys/user/max_user_namespaces", "1024", TST_SR_SKIP},
+		{PROC_SYS_USER "max_user_namespaces", "1024", TST_SR_SKIP},
 		{}
 	},
 	.tags = (const struct tst_tag[]) {
diff --git a/testcases/cve/icmp_rate_limit01.c b/testcases/cve/icmp_rate_limit01.c
index 5193c5dfd..cf47e112b 100644
--- a/testcases/cve/icmp_rate_limit01.c
+++ b/testcases/cve/icmp_rate_limit01.c
@@ -256,7 +256,7 @@ static struct tst_test test = {
 		NULL
 	},
 	.save_restore = (const struct tst_path_val[]) {
-		{"/proc/sys/user/max_user_namespaces", "1024", TST_SR_SKIP},
+		{PROC_SYS_USER "max_user_namespaces", "1024", TST_SR_SKIP},
 		{}
 	},
 	.tags = (const struct tst_tag[]) {
diff --git a/testcases/cve/tcindex01.c b/testcases/cve/tcindex01.c
index 478d75055..7eb5bec8f 100644
--- a/testcases/cve/tcindex01.c
+++ b/testcases/cve/tcindex01.c
@@ -149,7 +149,7 @@ static struct tst_test test = {
 		NULL
 	},
 	.save_restore = (const struct tst_path_val[]) {
-		{"/proc/sys/user/max_user_namespaces", "1024", TST_SR_SKIP},
+		{PROC_SYS_USER "max_user_namespaces", "1024", TST_SR_SKIP},
 		{}
 	},
 	.tags = (const struct tst_tag[]) {
diff --git a/testcases/kernel/containers/pidns/pidns05.c b/testcases/kernel/containers/pidns/pidns05.c
index 4b0478c84..b50f7ad33 100644
--- a/testcases/kernel/containers/pidns/pidns05.c
+++ b/testcases/kernel/containers/pidns/pidns05.c
@@ -71,7 +71,7 @@ static int find_cinit_pids(pid_t *pids)
 
 static void setup(void)
 {
-	SAFE_FILE_SCANF("/proc/sys/kernel/pid_max", "%d\n", &pid_max);
+	SAFE_FILE_SCANF(PROC_SYS_KERNEL	"pid_max", "%d\n", &pid_max);
 }
 
 static void run(void)
diff --git a/testcases/kernel/containers/userns/userns01.c b/testcases/kernel/containers/userns/userns01.c
index 6ee9fa7d0..5242bf7de 100644
--- a/testcases/kernel/containers/userns/userns01.c
+++ b/testcases/kernel/containers/userns/userns01.c
@@ -22,8 +22,8 @@
 #include <sys/capability.h>
 #include "lapi/sched.h"
 
-#define OVERFLOWUIDPATH "/proc/sys/kernel/overflowuid"
-#define OVERFLOWGIDPATH "/proc/sys/kernel/overflowgid"
+#define OVERFLOWUIDPATH PROC_SYS_KERNEL	"overflowuid"
+#define OVERFLOWGIDPATH PROC_SYS_KERNEL	"overflowgid"
 
 static long overflowuid;
 static long overflowgid;
diff --git a/testcases/kernel/containers/userns/userns06_capcheck.c b/testcases/kernel/containers/userns/userns06_capcheck.c
index 8669657b9..e623fffbb 100644
--- a/testcases/kernel/containers/userns/userns06_capcheck.c
+++ b/testcases/kernel/containers/userns/userns06_capcheck.c
@@ -32,7 +32,7 @@ int main(int argc, char *argv[])
 	if (argc < 2)
 		tst_brk(TBROK, "userns06_capcheck <privileged|unprivileged>");
 
-	SAFE_FILE_SCANF("/proc/sys/kernel/cap_last_cap", "%d", &last_cap);
+	SAFE_FILE_SCANF(PROC_SYS_KERNEL	"cap_last_cap", "%d", &last_cap);
 
 	if (strcmp("privileged", argv[1]))
 		expected_cap_flag = 0;
diff --git a/testcases/kernel/containers/userns/userns07.c b/testcases/kernel/containers/userns/userns07.c
index 9e34a3d9b..de41c77b1 100644
--- a/testcases/kernel/containers/userns/userns07.c
+++ b/testcases/kernel/containers/userns/userns07.c
@@ -93,7 +93,7 @@ static struct tst_test test = {
 		NULL,
 	},
 	.save_restore = (const struct tst_path_val[]) {
-		{"/proc/sys/kernel/unprivileged_userns_clone", "1", TST_SR_SKIP},
+		{PROC_SYS_KERNEL "unprivileged_userns_clone", "1", TST_SR_SKIP},
 		{}
 	},
 };
diff --git a/testcases/kernel/containers/userns/userns08.c b/testcases/kernel/containers/userns/userns08.c
index fbe51c8a5..61cc22842 100644
--- a/testcases/kernel/containers/userns/userns08.c
+++ b/testcases/kernel/containers/userns/userns08.c
@@ -26,6 +26,8 @@
 #include "lapi/sched.h"
 #include "tst_safe_file_at.h"
 
+#define PROC_SYS_USER	"/proc/sys/user/"
+
 static pid_t clone_newuser(void)
 {
 	const struct tst_clone_args cargs = {
@@ -119,7 +121,7 @@ static void setup(void)
 	SAFE_WRITE(SAFE_WRITE_ALL, fd, "\n", 1);
 	SAFE_CLOSE(fd);
 
-	SAFE_TRY_FILE_PRINTF("/proc/sys/user/max_user_namespaces", "%d", 10);
+	SAFE_TRY_FILE_PRINTF(PROC_SYS_USER "max_user_namespaces", "%d", 10);
 }
 
 static struct tst_test test = {
@@ -133,8 +135,8 @@ static struct tst_test test = {
 		NULL
 	},
 	.save_restore = (const struct tst_path_val[]) {
-		{"/proc/sys/user/max_user_namespaces", NULL, TST_SR_SKIP},
-		{"/proc/sys/kernel/unprivileged_userns_clone", "1", TST_SR_SKIP},
+		{PROC_SYS_USER "max_user_namespaces", NULL, TST_SR_SKIP},
+		{PROC_SYS_KERNEL "unprivileged_userns_clone", "1", TST_SR_SKIP},
 		{}
 	},
 	.tags = (const struct tst_tag[]) {
diff --git a/testcases/kernel/include/ksm_helper.h b/testcases/kernel/include/ksm_helper.h
index d4a6d5c7d..2b523b108 100644
--- a/testcases/kernel/include/ksm_helper.h
+++ b/testcases/kernel/include/ksm_helper.h
@@ -7,7 +7,7 @@
 #ifndef KSM_HELPER_H
 #define KSM_HELPER_H
 
-#define PATH_KSM	"/sys/kernel/mm/ksm/"
+#include "tst_path.h"
 
 void wait_ksmd_full_scan(void);
 
diff --git a/testcases/kernel/logging/kmsg/kmsg01.c b/testcases/kernel/logging/kmsg/kmsg01.c
index ba8179d5a..32225a059 100644
--- a/testcases/kernel/logging/kmsg/kmsg01.c
+++ b/testcases/kernel/logging/kmsg/kmsg01.c
@@ -32,8 +32,8 @@
 #define NUM_READ_MSGS 3
 #define NUM_READ_RETRY 10
 #define NUM_OVERWRITE_MSGS 1024
-#define PRINTK "/proc/sys/kernel/printk"
-#define CONSOLE_LOGLEVEL_QUIET   4
+#define PRINTK PROC_SYS_KERNEL "printk"
+#define CONSOLE_LOGLEVEL_QUIET  4
 
 static int console_loglevel = -1;
 
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
index 75f28102d..dff48da59 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
@@ -31,10 +31,6 @@ static char path_sys_sz_resv[BUFSIZ];
 static char path_sys_sz_surp[BUFSIZ];
 static char path_sys_sz_huge[BUFSIZ];
 
-#define PATH_PROC_VM		"/proc/sys/vm/"
-#define PATH_PROC_OVER		PATH_PROC_VM "nr_overcommit_hugepages"
-#define PATH_PROC_HUGE		PATH_PROC_VM "nr_hugepages"
-
 /* Only ia64 requires this */
 #ifdef __ia64__
 #define ADDR (void *)(0x8000000000000000UL)
@@ -191,8 +187,8 @@ static void setup(void)
 		path = path_sys_sz_huge;
 		pathover = path_sys_sz_over;
 	} else {
-		path = PATH_PROC_HUGE;
-		pathover = PATH_PROC_OVER;
+		path = PATH_NR_HPAGES;
+		pathover = PATH_OC_HPAGES;
 	}
 
 	if (opt_alloc) {
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap32.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap32.c
index 188ee2176..62a019619 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap32.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap32.c
@@ -21,7 +21,6 @@
 
 #include "hugetlb.h"
 
-#define PATH_HUGEPAGE "/sys/kernel/mm/hugepages"
 #define GIGANTIC_MIN_ORDER 10
 
 static int org_g_hpages;
@@ -45,14 +44,14 @@ static void setup(void)
 	struct dirent *ent;
 	unsigned long hpage_size;
 
-	if (access(PATH_HUGEPAGE, F_OK))
+	if (access(PATH_HUGEPAGES, F_OK))
 		tst_brk(TCONF, "hugetlbfs is not supported");
 
-	dir = SAFE_OPENDIR(PATH_HUGEPAGE);
+	dir = SAFE_OPENDIR(PATH_HUGEPAGES);
 	while ((ent = SAFE_READDIR(dir))) {
 		if ((sscanf(ent->d_name, "hugepages-%lukB", &hpage_size) == 1) &&
 			is_hugetlb_gigantic(hpage_size * 1024)) {
-			sprintf(g_hpage_path, "%s/%s/%s", PATH_HUGEPAGE,
+			sprintf(g_hpage_path, "%s/%s/%s", PATH_HUGEPAGES,
 					ent->d_name, "nr_hugepages");
 			break;
 		}
@@ -62,8 +61,8 @@ static void setup(void)
 
 	SAFE_CLOSEDIR(dir);
 
-	SAFE_FILE_PRINTF("/proc/sys/vm/drop_caches", "3");
-	SAFE_FILE_PRINTF("/proc/sys/vm/compact_memory", "1");
+	SAFE_FILE_PRINTF(PATH_DROP_CACHES, "3");
+	SAFE_FILE_PRINTF(PATH_COMPACT_MEMORY, "1");
 
 	if (tst_available_mem() < (long long)hpage_size) {
 		g_hpage_path[0] = '\0';
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap34.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap34.c
index ab7469cd7..52d6f43f8 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap34.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap34.c
@@ -32,7 +32,6 @@
 #define STACK_ALLOCATION_SIZE	(16*1024*1024)
 #endif
 #define MNTPOINT "hugetlbfs/"
-#define PATH_HUGEPAGE "/sys/kernel/mm/hugepages"
 
 #define STACKS_MAX 64
 
diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
index 9f877fd07..c3c07e923 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
@@ -82,7 +82,7 @@ static void setup(void)
 	long hpage_size, orig_hugepages;
 	unsigned long new_shmmax;
 
-	orig_hugepages = TST_SYS_CONF_LONG_GET("/proc/sys/vm/nr_hugepages");
+	orig_hugepages = TST_SYS_CONF_LONG_GET(PATH_NR_HPAGES);
 	SAFE_FILE_SCANF(PATH_SHMMAX, "%lu", &new_shmmax);
 
 	if (new_shmmax < SIZE)
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
index 625761f6e..150c9b61e 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
@@ -19,7 +19,7 @@
  * depending on the system being tested.
  */
 #define MAXIDS	8192
-#define PATH_SHMMNI	"/proc/sys/kernel/shmmni"
+#define PATH_SHMMNI	PROC_SYS_KERNEL	"shmmni"
 
 static size_t shm_size;
 static int shm_id_1 = -1;
diff --git a/testcases/kernel/mem/hugetlb/lib/hugetlb.h b/testcases/kernel/mem/hugetlb/lib/hugetlb.h
index fa742eb8d..ae23261d4 100644
--- a/testcases/kernel/mem/hugetlb/lib/hugetlb.h
+++ b/testcases/kernel/mem/hugetlb/lib/hugetlb.h
@@ -29,7 +29,7 @@
 #define SHM_HUGETLB	04000	/* segment is mapped via hugetlb */
 #endif
 
-#define PATH_SHMMAX "/proc/sys/kernel/shmmax"
+#define PATH_SHMMAX PROC_SYS_KERNEL "shmmax"
 
 #ifndef barrier
 # ifdef mb
diff --git a/testcases/kernel/mem/ksm/ksm01.c b/testcases/kernel/mem/ksm/ksm01.c
index be03f943f..444737c9f 100644
--- a/testcases/kernel/mem/ksm/ksm01.c
+++ b/testcases/kernel/mem/ksm/ksm01.c
@@ -74,13 +74,13 @@ static struct tst_test test = {
 	},
 	.setup = setup,
 	.save_restore = (const struct tst_path_val[]) {
-		{"/sys/kernel/mm/ksm/run", NULL, TST_SR_TBROK},
-		{"/sys/kernel/mm/ksm/sleep_millisecs", NULL, TST_SR_TBROK},
-		{"/sys/kernel/mm/ksm/max_page_sharing", NULL,
+		{KSM_FP("run"), NULL, TST_SR_TBROK},
+		{KSM_FP("sleep_millisecs"), NULL, TST_SR_TBROK},
+		{KSM_FP("max_page_sharing"), NULL,
 			TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},
-		{"/sys/kernel/mm/ksm/merge_across_nodes", "1",
+		{KSM_FP("merge_across_nodes"), "1",
 			TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},
-		{"/sys/kernel/mm/ksm/smart_scan", "0",
+		{KSM_FP("smart_scan"), "0",
 			TST_SR_SKIP_MISSING | TST_SR_TBROK_RO},
 		{}
 	},
diff --git a/testcases/kernel/mem/ksm/ksm02.c b/testcases/kernel/mem/ksm/ksm02.c
index 147e7e834..c0f25faa5 100644
--- a/testcases/kernel/mem/ksm/ksm02.c
+++ b/testcases/kernel/mem/ksm/ksm02.c
@@ -97,13 +97,13 @@ static struct tst_test test = {
 	},
 	.setup = setup,
 	.save_restore = (const struct tst_path_val[]) {
-		{"/sys/kernel/mm/ksm/run", NULL, TST_SR_TBROK},
-		{"/sys/kernel/mm/ksm/sleep_millisecs", NULL, TST_SR_TBROK},
-		{"/sys/kernel/mm/ksm/max_page_sharing", NULL,
+		{KSM_FP("run"), NULL, TST_SR_TBROK},
+		{KSM_FP("sleep_millisecs"), NULL, TST_SR_TBROK},
+		{KSM_FP("max_page_sharing"), NULL,
 			TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},
-		{"/sys/kernel/mm/ksm/merge_across_nodes", "1",
+		{KSM_FP("merge_across_nodes"), "1",
 			TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},
-		{"/sys/kernel/mm/ksm/smart_scan", "0",
+		{KSM_FP("smart_scan"), "0",
 			TST_SR_SKIP_MISSING | TST_SR_TBROK_RO},
 		{}
 	},
diff --git a/testcases/kernel/mem/ksm/ksm03.c b/testcases/kernel/mem/ksm/ksm03.c
index 34a086ae7..c82881f3f 100644
--- a/testcases/kernel/mem/ksm/ksm03.c
+++ b/testcases/kernel/mem/ksm/ksm03.c
@@ -79,13 +79,13 @@ static struct tst_test test = {
 	},
 	.setup = setup,
 	.save_restore = (const struct tst_path_val[]) {
-		{"/sys/kernel/mm/ksm/run", NULL, TST_SR_TBROK},
-		{"/sys/kernel/mm/ksm/sleep_millisecs", NULL, TST_SR_TBROK},
-		{"/sys/kernel/mm/ksm/max_page_sharing", NULL,
+		{KSM_FP("run"), NULL, TST_SR_TBROK},
+		{KSM_FP("sleep_millisecs"), NULL, TST_SR_TBROK},
+		{KSM_FP("max_page_sharing"), NULL,
 			TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},
-		{"/sys/kernel/mm/ksm/merge_across_nodes", "1",
+		{KSM_FP("merge_across_nodes"), "1",
 			TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},
-		{"/sys/kernel/mm/ksm/smart_scan", "0",
+		{KSM_FP("smart_scan"), "0",
 			TST_SR_SKIP_MISSING | TST_SR_TBROK_RO},
 		{}
 	},
diff --git a/testcases/kernel/mem/ksm/ksm04.c b/testcases/kernel/mem/ksm/ksm04.c
index a9a06be40..455daec2a 100644
--- a/testcases/kernel/mem/ksm/ksm04.c
+++ b/testcases/kernel/mem/ksm/ksm04.c
@@ -86,13 +86,13 @@ static struct tst_test test = {
 	},
 	.setup = setup,
 	.save_restore = (const struct tst_path_val[]) {
-		{"/sys/kernel/mm/ksm/run", NULL, TST_SR_TBROK},
-		{"/sys/kernel/mm/ksm/sleep_millisecs", NULL, TST_SR_TBROK},
-		{"/sys/kernel/mm/ksm/max_page_sharing", NULL,
+		{KSM_FP("run"), NULL, TST_SR_TBROK},
+		{KSM_FP("sleep_millisecs"), NULL, TST_SR_TBROK},
+		{KSM_FP("max_page_sharing"), NULL,
 			TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},
-		{"/sys/kernel/mm/ksm/merge_across_nodes", "1",
+		{KSM_FP("merge_across_nodes"), "1",
 			TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},
-		{"/sys/kernel/mm/ksm/smart_scan", "0",
+		{KSM_FP("smart_scan"), "0",
 			TST_SR_SKIP_MISSING | TST_SR_TBROK_RO},
 		{}
 	},
diff --git a/testcases/kernel/mem/ksm/ksm05.c b/testcases/kernel/mem/ksm/ksm05.c
index 96ffad511..cb182fef4 100644
--- a/testcases/kernel/mem/ksm/ksm05.c
+++ b/testcases/kernel/mem/ksm/ksm05.c
@@ -93,8 +93,8 @@ static struct tst_test test = {
 	.forks_child = 1,
 	.test_all = test_ksm,
 	.save_restore = (const struct tst_path_val[]) {
-		{"/sys/kernel/mm/ksm/run", "1", TST_SR_TBROK},
-		{"/sys/kernel/mm/ksm/smart_scan", "0",
+		{KSM_FP("run"), "1", TST_SR_TBROK},
+		{KSM_FP("smart_scan"), "0",
 			TST_SR_SKIP_MISSING | TST_SR_TBROK_RO},
 		{}
 	},
diff --git a/testcases/kernel/mem/ksm/ksm06.c b/testcases/kernel/mem/ksm/ksm06.c
index 22371ea53..73f5c7931 100644
--- a/testcases/kernel/mem/ksm/ksm06.c
+++ b/testcases/kernel/mem/ksm/ksm06.c
@@ -132,12 +132,12 @@ static struct tst_test test = {
 	},
 	.setup = setup,
 	.save_restore = (const struct tst_path_val[]) {
-		{"/sys/kernel/mm/ksm/max_page_sharing", NULL,
+		{KSM_FP("max_page_sharing"), NULL,
 			TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},
-		{"/sys/kernel/mm/ksm/run", NULL, TST_SR_TBROK},
-		{"/sys/kernel/mm/ksm/sleep_millisecs", NULL, TST_SR_TBROK},
-		{"/sys/kernel/mm/ksm/merge_across_nodes", NULL, TST_SR_TCONF},
-		{"/sys/kernel/mm/ksm/smart_scan", "0",
+		{KSM_FP("run"), NULL, TST_SR_TBROK},
+		{KSM_FP("sleep_millisecs"), NULL, TST_SR_TBROK},
+		{KSM_FP("merge_across_nodes"), NULL, TST_SR_TCONF},
+		{KSM_FP("smart_scan"), "0",
 			TST_SR_SKIP_MISSING | TST_SR_TBROK_RO},
 		{}
 	},
diff --git a/testcases/kernel/mem/ksm/ksm07.c b/testcases/kernel/mem/ksm/ksm07.c
index 6b97b4591..d7efd5654 100644
--- a/testcases/kernel/mem/ksm/ksm07.c
+++ b/testcases/kernel/mem/ksm/ksm07.c
@@ -98,10 +98,10 @@ static struct tst_test test = {
 		{}
 	},
 	.save_restore = (const struct tst_path_val[]) {
-		{PATH_KSM "pages_skipped", NULL, TST_SR_TCONF},
-		{PATH_KSM "run", NULL, TST_SR_TCONF},
-		{PATH_KSM "sleep_millisecs", NULL, TST_SR_TCONF},
-		{PATH_KSM "smart_scan", "1",
+		{KSM_FP("pages_skipped"), NULL, TST_SR_TCONF},
+		{KSM_FP("run"), NULL, TST_SR_TCONF},
+		{KSM_FP("sleep_millisecs"), NULL, TST_SR_TCONF},
+		{KSM_FP("smart_scan"), "1",
 			TST_SR_SKIP_MISSING | TST_SR_TCONF},
 		{}
 	},
diff --git a/testcases/kernel/mem/oom/oom.h b/testcases/kernel/mem/oom/oom.h
index 42ed181b0..643bd382a 100644
--- a/testcases/kernel/mem/oom/oom.h
+++ b/testcases/kernel/mem/oom/oom.h
@@ -7,16 +7,17 @@
 #define OOM_H_
 
 #include <pthread.h>
+#include "tst_path.h"
 #include "config.h"
 #include "numa_helper.h"
 
-#define PATH_KSM        "/sys/kernel/mm/ksm/"
-
 #define LENGTH			(3UL<<30)
 #define NORMAL			1
 #define MLOCK			2
 #define KSM			3
 
+#define OVERCOMMIT_MEMORY	PROC_SYS_VM "overcommit_memory"
+
 #ifdef HAVE_NUMA_V2
 static inline void set_global_mempolicy(int mempolicy)
 {
@@ -222,10 +223,10 @@ static inline void testoom(int mempolicy, int lite, int retcode, int allow_sigki
 			 "skip OOM test for KSM pags");
 	} else {
 		tst_res(TINFO, "start OOM testing for KSM pages.");
-		SAFE_FILE_SCANF(PATH_KSM "run", "%d", &ksm_run_orig);
-		SAFE_FILE_PRINTF(PATH_KSM "run", "1");
+		SAFE_FILE_SCANF(KSM_FP("run"), "%d", &ksm_run_orig);
+		SAFE_FILE_PRINTF(KSM_FP("run"), "1");
 		oom(KSM, lite, retcode, allow_sigkill);
-		SAFE_FILE_PRINTF(PATH_KSM "run", "%d", ksm_run_orig);
+		SAFE_FILE_PRINTF(KSM_FP("run"), "%d", ksm_run_orig);
 	}
 }
 
diff --git a/testcases/kernel/mem/oom/oom01.c b/testcases/kernel/mem/oom/oom01.c
index 48fe85849..46ea0c562 100644
--- a/testcases/kernel/mem/oom/oom01.c
+++ b/testcases/kernel/mem/oom/oom01.c
@@ -17,8 +17,6 @@
 #include "tst_test.h"
 #include "oom.h"
 
-#define OVERCOMMIT_MEMORY "/proc/sys/vm/overcommit_memory"
-
 static void verify_oom(void)
 {
 	/* we expect mmap to fail before OOM is hit */
diff --git a/testcases/kernel/mem/oom/oom02.c b/testcases/kernel/mem/oom/oom02.c
index 01a405ec1..d0c19051a 100644
--- a/testcases/kernel/mem/oom/oom02.c
+++ b/testcases/kernel/mem/oom/oom02.c
@@ -49,7 +49,7 @@ static struct tst_test test = {
 	.test_all = verify_oom,
 	.skip_in_compat = 1,
 	.save_restore = (const struct tst_path_val[]) {
-		{"/proc/sys/vm/overcommit_memory", "1", TST_SR_TBROK},
+		{OVERCOMMIT_MEMORY, "1", TST_SR_TBROK},
 		{}
 	},
 };
diff --git a/testcases/kernel/mem/oom/oom03.c b/testcases/kernel/mem/oom/oom03.c
index f218b8130..03dca168b 100644
--- a/testcases/kernel/mem/oom/oom03.c
+++ b/testcases/kernel/mem/oom/oom03.c
@@ -76,7 +76,7 @@ static struct tst_test test = {
 	.needs_cgroup_ctrls = (const char *const []){ "memory", NULL },
 	.skip_in_compat = 1,
 	.save_restore = (const struct tst_path_val[]) {
-		{"/proc/sys/vm/overcommit_memory", "1", TST_SR_TBROK},
+		{OVERCOMMIT_MEMORY, "1", TST_SR_TBROK},
 		{}
 	},
 };
diff --git a/testcases/kernel/mem/oom/oom04.c b/testcases/kernel/mem/oom/oom04.c
index d4beb12c7..ea632acab 100644
--- a/testcases/kernel/mem/oom/oom04.c
+++ b/testcases/kernel/mem/oom/oom04.c
@@ -72,7 +72,7 @@ static struct tst_test test = {
 	.needs_cgroup_ctrls = (const char *const []){ "cpuset", NULL },
 	.skip_in_compat = 1,
 	.save_restore = (const struct tst_path_val[]) {
-		{"/proc/sys/vm/overcommit_memory", "1", TST_SR_TBROK},
+		{OVERCOMMIT_MEMORY, "1", TST_SR_TBROK},
 		{}
 	},
 };
diff --git a/testcases/kernel/mem/oom/oom05.c b/testcases/kernel/mem/oom/oom05.c
index 6b8d436d1..edb690676 100644
--- a/testcases/kernel/mem/oom/oom05.c
+++ b/testcases/kernel/mem/oom/oom05.c
@@ -95,7 +95,7 @@ static struct tst_test test = {
 	},
 	.skip_in_compat = 1,
 	.save_restore = (const struct tst_path_val[]) {
-		{"/proc/sys/vm/overcommit_memory", "1", TST_SR_TBROK},
+		{OVERCOMMIT_MEMORY, "1", TST_SR_TBROK},
 		{}
 	},
 };
diff --git a/testcases/kernel/mem/thp/thp.h b/testcases/kernel/mem/thp/thp.h
index 7723bedc2..ef84bbb42 100644
--- a/testcases/kernel/mem/thp/thp.h
+++ b/testcases/kernel/mem/thp/thp.h
@@ -6,7 +6,7 @@
 #ifndef THP_H
 #define THP_H
 
-#define PATH_THP "/sys/kernel/mm/transparent_hugepage/"
+#include "tst_path.h"
 
 static inline void check_hugepage(void)
 {
diff --git a/testcases/kernel/sched/sysctl/proc_sched_rt01.c b/testcases/kernel/sched/sysctl/proc_sched_rt01.c
index df57ebcde..2a72bf40d 100644
--- a/testcases/kernel/sched/sysctl/proc_sched_rt01.c
+++ b/testcases/kernel/sched/sysctl/proc_sched_rt01.c
@@ -26,9 +26,9 @@
 #include <stdio.h>
 #include "tst_test.h"
 
-#define RT_PERIOD_US "/proc/sys/kernel/sched_rt_period_us"
-#define RT_RUNTIME_US "/proc/sys/kernel/sched_rt_runtime_us"
-#define RR_TIMESLICE_MS "/proc/sys/kernel/sched_rr_timeslice_ms"
+#define RT_PERIOD_US	PROC_SYS_KERNEL "sched_rt_period_us"
+#define RT_RUNTIME_US	PROC_SYS_KERNEL "sched_rt_runtime_us"
+#define RR_TIMESLICE_MS	PROC_SYS_KERNEL "sched_rr_timeslice_ms"
 
 static int period_fd;
 static int runtime_fd;
diff --git a/testcases/kernel/syscalls/fanotify/fanotify10.c b/testcases/kernel/syscalls/fanotify/fanotify10.c
index 41f13408a..257b72ddb 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify10.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify10.c
@@ -99,8 +99,7 @@ static int ignore_mark_unsupported;
 #define FILE_EXEC_PATH2 MNT2_PATH"/"TEST_APP
 #define FILE2_EXEC_PATH2 MNT2_PATH"/"TEST_APP2
 
-#define DROP_CACHES_FILE "/proc/sys/vm/drop_caches"
-#define CACHE_PRESSURE_FILE "/proc/sys/vm/vfs_cache_pressure"
+#define CACHE_PRESSURE_FILE PROC_SYS_VM "vfs_cache_pressure"
 
 static pid_t child_pid;
 static int bind_mount_created;
@@ -517,9 +516,9 @@ static void drop_caches(void)
 	 * In order to ensure that the inode can be released in the two-tier
 	 * directory structure, drop_cache is required three times.
 	 */
-	SAFE_FILE_PRINTF(DROP_CACHES_FILE, "3");
-	SAFE_FILE_PRINTF(DROP_CACHES_FILE, "3");
-	SAFE_FILE_PRINTF(DROP_CACHES_FILE, "3");
+	SAFE_FILE_PRINTF(PATH_DROP_CACHES, "3");
+	SAFE_FILE_PRINTF(PATH_DROP_CACHES, "3");
+	SAFE_FILE_PRINTF(PATH_DROP_CACHES, "3");
 }
 
 static int create_fanotify_groups(unsigned int n)
diff --git a/testcases/kernel/syscalls/fcntl/fcntl35.c b/testcases/kernel/syscalls/fcntl/fcntl35.c
index 2d730377b..69ed8b149 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl35.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl35.c
@@ -49,13 +49,13 @@ static void setup(void)
 	test_max_unpriv = getpagesize();
 	test_max_priv = test_max_unpriv * 16;
 
-	if (!access("/proc/sys/fs/pipe-max-size", F_OK)) {
-		SAFE_FILE_SCANF("/proc/sys/fs/pipe-max-size", "%d",
+	if (!access(PROC_SYS_FS "pipe-max-size", F_OK)) {
+		SAFE_FILE_SCANF(PROC_SYS_FS "pipe-max-size", "%d",
 				&pipe_max_unpriv);
-		SAFE_FILE_PRINTF("/proc/sys/fs/pipe-max-size", "%d",
+		SAFE_FILE_PRINTF(PROC_SYS_FS "pipe-max-size", "%d",
 				test_max_unpriv);
 	} else {
-		tst_brk(TCONF, "/proc/sys/fs/pipe-max-size doesn't exist");
+		tst_brk(TCONF, PROC_SYS_FS "pipe-max-size doesn't exist");
 	}
 
 	pw = SAFE_GETPWNAM("nobody");
@@ -63,7 +63,7 @@ static void setup(void)
 
 static void cleanup(void)
 {
-	SAFE_FILE_PRINTF("/proc/sys/fs/pipe-max-size", "%d", pipe_max_unpriv);
+	SAFE_FILE_PRINTF(PROC_SYS_FS "pipe-max-size", "%d", pipe_max_unpriv);
 }
 
 static int verify_pipe_size(int exp_pip_sz, char *desp)
diff --git a/testcases/kernel/syscalls/inotify/inotify07.c b/testcases/kernel/syscalls/inotify/inotify07.c
index b4000f353..920ad0de2 100644
--- a/testcases/kernel/syscalls/inotify/inotify07.c
+++ b/testcases/kernel/syscalls/inotify/inotify07.c
@@ -153,7 +153,7 @@ static void setup(void)
 	tst_res(TINFO, DIR_PATH " ino=%lu", buf.st_ino);
 
 	/* Drop dentry caches, so overlayfs will allocate a new dentry */
-	SAFE_FILE_PRINTF("/proc/sys/vm/drop_caches", "2");
+	SAFE_FILE_PRINTF(PATH_DROP_CACHES, "2");
 
 	/* Copy up directory to make it a merge directory */
 	SAFE_CHMOD(DIR_PATH, 0700);
diff --git a/testcases/kernel/syscalls/inotify/inotify08.c b/testcases/kernel/syscalls/inotify/inotify08.c
index e0837cac3..afb6eae60 100644
--- a/testcases/kernel/syscalls/inotify/inotify08.c
+++ b/testcases/kernel/syscalls/inotify/inotify08.c
@@ -146,7 +146,7 @@ static void setup(void)
 			major(buf.st_dev), minor(buf.st_dev));
 
 	/* Drop dentry caches, so overlayfs will allocate a new dentry */
-	SAFE_FILE_PRINTF("/proc/sys/vm/drop_caches", "2");
+	SAFE_FILE_PRINTF(PATH_DROP_CACHES, "2");
 
 	/* Copy up file */
 	SAFE_CHMOD(FILE_PATH, 0600);
diff --git a/testcases/kernel/syscalls/io_uring/io_uring01.c b/testcases/kernel/syscalls/io_uring/io_uring01.c
index 4c64e562b..1f562cc2f 100644
--- a/testcases/kernel/syscalls/io_uring/io_uring01.c
+++ b/testcases/kernel/syscalls/io_uring/io_uring01.c
@@ -165,7 +165,7 @@ static struct tst_test test = {
 		{}
 	},
 	.save_restore = (const struct tst_path_val[]) {
-		{"/proc/sys/kernel/io_uring_disabled", "0",
+		{PROC_SYS_KERNEL "io_uring_disabled", "0",
 			TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},
 		{}
 	}
diff --git a/testcases/kernel/syscalls/io_uring/io_uring02.c b/testcases/kernel/syscalls/io_uring/io_uring02.c
index 50206cf1f..7052a1c62 100644
--- a/testcases/kernel/syscalls/io_uring/io_uring02.c
+++ b/testcases/kernel/syscalls/io_uring/io_uring02.c
@@ -255,7 +255,7 @@ static struct tst_test test = {
 		{}
 	},
 	.save_restore = (const struct tst_path_val[]) {
-		{"/proc/sys/kernel/io_uring_disabled", "0",
+		{PROC_SYS_KERNEL "io_uring_disabled", "0",
 			TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},
 		{}
 	},
diff --git a/testcases/kernel/syscalls/io_uring/io_uring03.c b/testcases/kernel/syscalls/io_uring/io_uring03.c
index 645c96b02..e5c804831 100644
--- a/testcases/kernel/syscalls/io_uring/io_uring03.c
+++ b/testcases/kernel/syscalls/io_uring/io_uring03.c
@@ -133,7 +133,7 @@ static struct tst_test test = {
 		{}
 	},
 	.save_restore = (const struct tst_path_val[]) {
-		{"/proc/sys/kernel/io_uring_disabled", "0",
+		{PROC_SYS_KERNEL "io_uring_disabled", "0",
 			TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},
 		{}
 	}
diff --git a/testcases/kernel/syscalls/ipc/msgget/msgget03.c b/testcases/kernel/syscalls/ipc/msgget/msgget03.c
index f3d7579a3..4c9409c0c 100644
--- a/testcases/kernel/syscalls/ipc/msgget/msgget03.c
+++ b/testcases/kernel/syscalls/ipc/msgget/msgget03.c
@@ -74,7 +74,7 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.test_all = verify_msgget,
 	.save_restore = (const struct tst_path_val[]){
-		{"/proc/sys/kernel/msgmni", NULL, TST_SR_TCONF},
+		{PROC_SYS_KERNEL "msgmni", NULL, TST_SR_TCONF},
 		{}
 	}
 };
diff --git a/testcases/kernel/syscalls/ipc/msgget/msgget04.c b/testcases/kernel/syscalls/ipc/msgget/msgget04.c
index 7f8f2ed9e..af7e3f8a4 100644
--- a/testcases/kernel/syscalls/ipc/msgget/msgget04.c
+++ b/testcases/kernel/syscalls/ipc/msgget/msgget04.c
@@ -22,7 +22,7 @@
 #include "tst_safe_sysv_ipc.h"
 #include "tse_newipc.h"
 
-#define NEXT_ID_PATH "/proc/sys/kernel/msg_next_id"
+#define NEXT_ID_PATH PROC_SYS_KERNEL "msg_next_id"
 static int queue_id, pid;
 static key_t msgkey;
 
diff --git a/testcases/kernel/syscalls/ipc/msgget/msgget05.c b/testcases/kernel/syscalls/ipc/msgget/msgget05.c
index c683142f5..e362f7fb0 100644
--- a/testcases/kernel/syscalls/ipc/msgget/msgget05.c
+++ b/testcases/kernel/syscalls/ipc/msgget/msgget05.c
@@ -20,7 +20,7 @@
 #include "tst_safe_sysv_ipc.h"
 #include "tse_newipc.h"
 
-#define NEXT_ID_PATH "/proc/sys/kernel/msg_next_id"
+#define NEXT_ID_PATH PROC_SYS_KERNEL "msg_next_id"
 
 static int queue_id[2], pid;
 static key_t msgkey[2];
diff --git a/testcases/kernel/syscalls/ipc/semget/semget05.c b/testcases/kernel/syscalls/ipc/semget/semget05.c
index 57a65dbdd..5ef242d8e 100644
--- a/testcases/kernel/syscalls/ipc/semget/semget05.c
+++ b/testcases/kernel/syscalls/ipc/semget/semget05.c
@@ -38,7 +38,7 @@ static void setup(void)
 	used_cnt = GET_USED_ARRAYS();
 	tst_res(TINFO, "Current environment %d semaphore arrays are already in use",
 		used_cnt);
-	SAFE_FILE_SCANF("/proc/sys/kernel/sem", "%*d %*d %*d %d", &maxsems);
+	SAFE_FILE_SCANF(PROC_SYS_KERNEL "sem", "%*d %*d %*d %d", &maxsems);
 
 	/* Prevent timeout due to high semaphore array limit */
 	tst_set_runtime(maxsems / 200);
@@ -74,7 +74,7 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.test_all = verify_semget,
 	.save_restore = (const struct tst_path_val[]){
-		{"/proc/sys/kernel/sem", NULL,
+		{PROC_SYS_KERNEL "sem", NULL,
 			TST_SR_TCONF_MISSING | TST_SR_SKIP_RO},
 		{}
 	}
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl03.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl03.c
index a1f53e7c1..4e45af4af 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl03.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl03.c
@@ -30,9 +30,9 @@ static void verify_ipcinfo(void)
 	else
 		tst_res(TPASS, "shmmin = 1");
 
-	TST_ASSERT_ULONG("/proc/sys/kernel/shmmax", info.shmmax);
-	TST_ASSERT_ULONG("/proc/sys/kernel/shmmni", info.shmmni);
-	TST_ASSERT_ULONG("/proc/sys/kernel/shmall", info.shmall);
+	TST_ASSERT_ULONG(PROC_SYS_KERNEL "shmmax", info.shmmax);
+	TST_ASSERT_ULONG(PROC_SYS_KERNEL "shmmni", info.shmmni);
+	TST_ASSERT_ULONG(PROC_SYS_KERNEL "shmall", info.shmall);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/ipc/shmget/shmget02.c b/testcases/kernel/syscalls/ipc/shmget/shmget02.c
index 5c77d47d8..99f7a5f92 100644
--- a/testcases/kernel/syscalls/ipc/shmget/shmget02.c
+++ b/testcases/kernel/syscalls/ipc/shmget/shmget02.c
@@ -143,7 +143,7 @@ static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(tcases),
 	.hugepages = {TST_NO_HUGEPAGES},
 	.save_restore = (const struct tst_path_val[]) {
-		{"/proc/sys/kernel/shmmax", "8192", TST_SR_TCONF_MISSING | TST_SR_TBROK_RO},
+		{PROC_SYS_KERNEL "shmmax", "8192", TST_SR_TCONF_MISSING | TST_SR_TBROK_RO},
 		{}
 	},
 };
diff --git a/testcases/kernel/syscalls/ipc/shmget/shmget03.c b/testcases/kernel/syscalls/ipc/shmget/shmget03.c
index a54540d58..17fce4c70 100644
--- a/testcases/kernel/syscalls/ipc/shmget/shmget03.c
+++ b/testcases/kernel/syscalls/ipc/shmget/shmget03.c
@@ -37,7 +37,7 @@ static void setup(void)
 	used_cnt = GET_USED_SEGMENTS();
 	tst_res(TINFO, "Current environment %d shared memory segments are already in use",
 		used_cnt);
-	SAFE_FILE_SCANF("/proc/sys/kernel/shmmni", "%i", &maxshms);
+	SAFE_FILE_SCANF(PROC_SYS_KERNEL "shmmni", "%i", &maxshms);
 
 	queues = SAFE_MALLOC((maxshms - used_cnt) * sizeof(int));
 	for (num = 0; num < maxshms - used_cnt; num++) {
diff --git a/testcases/kernel/syscalls/ipc/shmget/shmget05.c b/testcases/kernel/syscalls/ipc/shmget/shmget05.c
index 246674938..eadf9992a 100644
--- a/testcases/kernel/syscalls/ipc/shmget/shmget05.c
+++ b/testcases/kernel/syscalls/ipc/shmget/shmget05.c
@@ -23,7 +23,7 @@
 #include "tst_safe_sysv_ipc.h"
 #include "tse_newipc.h"
 
-#define NEXT_ID_PATH "/proc/sys/kernel/shm_next_id"
+#define NEXT_ID_PATH PROC_SYS_KERNEL "shm_next_id"
 static int shm_id, pid;
 static key_t shmkey;
 
diff --git a/testcases/kernel/syscalls/ipc/shmget/shmget06.c b/testcases/kernel/syscalls/ipc/shmget/shmget06.c
index 420844f0a..e6d027809 100644
--- a/testcases/kernel/syscalls/ipc/shmget/shmget06.c
+++ b/testcases/kernel/syscalls/ipc/shmget/shmget06.c
@@ -21,7 +21,7 @@
 #include "tst_safe_sysv_ipc.h"
 #include "tse_newipc.h"
 
-#define NEXT_ID_PATH "/proc/sys/kernel/shm_next_id"
+#define NEXT_ID_PATH PROC_SYS_KERNEL "shm_next_id"
 
 static int shm_id[2], pid;
 static key_t shmkey[2];
diff --git a/testcases/kernel/syscalls/keyctl/keyctl02.c b/testcases/kernel/syscalls/keyctl/keyctl02.c
index 3c5a2501e..6241f4126 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl02.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl02.c
@@ -30,7 +30,7 @@
 
 #define LOOPS	20000
 #define MAX_WAIT_FOR_GC_MS 5000
-#define PATH_KEY_COUNT_QUOTA	"/proc/sys/kernel/keys/root_maxkeys"
+#define PATH_KEY_COUNT_QUOTA	PROC_SYS_KERNEL "keys/root_maxkeys"
 
 static int orig_maxkeys;
 static int realtime_kernel;
diff --git a/testcases/kernel/syscalls/madvise/madvise01.c b/testcases/kernel/syscalls/madvise/madvise01.c
index 884c59b0b..b9ba4bdbe 100644
--- a/testcases/kernel/syscalls/madvise/madvise01.c
+++ b/testcases/kernel/syscalls/madvise/madvise01.c
@@ -24,7 +24,6 @@
 
 #define TMP_DIR "tmp_madvise"
 #define TEST_FILE TMP_DIR"/testfile"
-#define KSM_SYS_DIR "/sys/kernel/mm/ksm"
 #define STR "abcdefghijklmnopqrstuvwxyz12345\n"
 
 static char *sfile;
diff --git a/testcases/kernel/syscalls/madvise/madvise02.c b/testcases/kernel/syscalls/madvise/madvise02.c
index cc3faf5cf..8817746d0 100644
--- a/testcases/kernel/syscalls/madvise/madvise02.c
+++ b/testcases/kernel/syscalls/madvise/madvise02.c
@@ -46,7 +46,6 @@
 #define MAP_SIZE (4 * 1024)
 #define TEST_FILE "testfile"
 #define STR "abcdefghijklmnopqrstuvwxyz12345\n"
-#define KSM_SYS_DIR	"/sys/kernel/mm/ksm"
 
 static struct stat st;
 static long pagesize;
@@ -98,7 +97,7 @@ static void tcases_filter(void)
 		case MADV_UNMERGEABLE:
 			/* kernel configured with CONFIG_KSM,
 			 * skip EINVAL test for MADV_MERGEABLE. */
-			if (access(KSM_SYS_DIR, F_OK) == 0)
+			if (access(PATH_KSM, F_OK) == 0)
 				tc->skip = 1;
 		break;
 		case MADV_WILLNEED:
diff --git a/testcases/kernel/syscalls/madvise/madvise06.c b/testcases/kernel/syscalls/madvise/madvise06.c
index a9df913fc..7e2af8950 100644
--- a/testcases/kernel/syscalls/madvise/madvise06.c
+++ b/testcases/kernel/syscalls/madvise/madvise06.c
@@ -48,7 +48,7 @@
 #define PASS_THRESHOLD (CHUNK_SZ / 4)
 #define PASS_THRESHOLD_KB (PASS_THRESHOLD / 1024)
 
-static const char drop_caches_fname[] = "/proc/sys/vm/drop_caches";
+static const char drop_caches_fname[] = PATH_DROP_CACHES;
 static int pg_sz, stat_refresh_sup;
 
 static long init_swap, init_swap_cached, init_cached;
diff --git a/testcases/kernel/syscalls/madvise/madvise08.c b/testcases/kernel/syscalls/madvise/madvise08.c
index 96bcaf159..03bc26acb 100644
--- a/testcases/kernel/syscalls/madvise/madvise08.c
+++ b/testcases/kernel/syscalls/madvise/madvise08.c
@@ -33,7 +33,7 @@
 #include "tst_test.h"
 #include "lapi/mmap.h"
 
-#define CORE_PATTERN "/proc/sys/kernel/core_pattern"
+#define CORE_PATTERN PROC_SYS_KERNEL "core_pattern"
 #define CORE_FILTER "/proc/self/coredump_filter"
 #define YCOUNT 0x500L
 #define FMEMSIZE (YCOUNT + 0x2L)
diff --git a/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c b/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
index 780aae1b5..e9b502fb8 100644
--- a/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
+++ b/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
@@ -324,7 +324,7 @@ static struct tst_test test = {
 	.test_all = run,
 	.setup = setup,
 	.save_restore = (const struct tst_path_val[]) {
-		{"/proc/sys/kernel/numa_balancing", "0",
+		{PROC_SYS_KERNEL "numa_balancing", "0",
 			TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},
 		{}
 	},
diff --git a/testcases/kernel/syscalls/mmap/mmap10.c b/testcases/kernel/syscalls/mmap/mmap10.c
index fb5543899..45be81dae 100644
--- a/testcases/kernel/syscalls/mmap/mmap10.c
+++ b/testcases/kernel/syscalls/mmap/mmap10.c
@@ -40,7 +40,7 @@
 #include "tst_test.h"
 
 #define SIZE (5 * TST_MB)
-#define PATH_KSM "/sys/kernel/mm/ksm/"
+#define PATH_KSM SYS_KERNEL_MM "ksm/"
 
 static size_t page_sz;
 static char *memory;
diff --git a/testcases/kernel/syscalls/move_pages/move_pages12.c b/testcases/kernel/syscalls/move_pages/move_pages12.c
index 440773a38..dc246d792 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages12.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages12.c
@@ -76,8 +76,6 @@
 
 #define LOOPS	10000
 #define PATH_MEMINFO	"/proc/meminfo"
-#define PATH_NR_HUGEPAGES	"/proc/sys/vm/nr_hugepages"
-#define PATH_HUGEPAGES	"/sys/kernel/mm/hugepages/"
 #define TEST_NODES	2
 
 static struct tcase {
@@ -269,7 +267,7 @@ static void setup(void)
 	pgsz = (int)get_page_size();
 	SAFE_FILE_LINES_SCANF(PATH_MEMINFO, "Hugepagesize: %d", &hpsz);
 
-	SAFE_FILE_PRINTF("/proc/sys/vm/drop_caches", "3");
+	SAFE_FILE_PRINTF(PATH_DROP_CACHES, "3");
 	SAFE_FILE_LINES_SCANF(PATH_MEMINFO, "MemFree: %ld", &memfree);
 	tst_res(TINFO, "Free RAM %ld kB", memfree);
 
@@ -307,10 +305,10 @@ static void setup(void)
 	hpsz *= 1024;
 
 	if (orig_hugepages_node1 == -1 || orig_hugepages_node2 == -1) {
-		SAFE_FILE_SCANF(PATH_NR_HUGEPAGES, "%ld", &orig_hugepages);
+		SAFE_FILE_SCANF(PATH_NR_HPAGES, "%ld", &orig_hugepages);
 		tst_res(TINFO, "Increasing global hugepages pool to %ld",
 			orig_hugepages + 8);
-		SAFE_FILE_PRINTF(PATH_NR_HUGEPAGES, "%ld", orig_hugepages + 8);
+		SAFE_FILE_PRINTF(PATH_NR_HPAGES, "%ld", orig_hugepages + 8);
 	}
 
 	alloc_free_huge_on_node(node1, 4L * hpsz);
@@ -320,7 +318,7 @@ static void setup(void)
 static void cleanup(void)
 {
 	if (orig_hugepages != -1)
-		SAFE_FILE_PRINTF(PATH_NR_HUGEPAGES, "%ld", orig_hugepages);
+		SAFE_FILE_PRINTF(PATH_NR_HPAGES, "%ld", orig_hugepages);
 
 	if (orig_hugepages_node1 != -1) {
 		SAFE_FILE_PRINTF(path_hugepages_node1,
diff --git a/testcases/kernel/syscalls/newuname/newuname01.c b/testcases/kernel/syscalls/newuname/newuname01.c
index 37058023a..4318b4fff 100644
--- a/testcases/kernel/syscalls/newuname/newuname01.c
+++ b/testcases/kernel/syscalls/newuname/newuname01.c
@@ -31,16 +31,16 @@ static void run(void)
 
 	TST_EXP_EQ_STR(name->sysname, "Linux");
 
-	SAFE_FILE_SCANF("/proc/sys/kernel/hostname", "%1023[^\n]", proc_val);
+	SAFE_FILE_SCANF(PROC_SYS_KERNEL "hostname", "%1023[^\n]", proc_val);
 	TST_EXP_EQ_STR(name->nodename, proc_val);
 
-	SAFE_FILE_SCANF("/proc/sys/kernel/osrelease", "%1023[^\n]", proc_val);
+	SAFE_FILE_SCANF(PROC_SYS_KERNEL "osrelease", "%1023[^\n]", proc_val);
 	TST_EXP_EQ_STR(name->release, proc_val);
 
-	SAFE_FILE_SCANF("/proc/sys/kernel/version", "%1023[^\n]", proc_val);
+	SAFE_FILE_SCANF(PROC_SYS_KERNEL "version", "%1023[^\n]", proc_val);
 	TST_EXP_EQ_STR(name->version, proc_val);
 
-	SAFE_FILE_SCANF("/proc/sys/kernel/domainname", "%1023[^\n]", proc_val);
+	SAFE_FILE_SCANF(PROC_SYS_KERNEL "domainname", "%1023[^\n]", proc_val);
 	TST_EXP_EQ_STR(name->domainname, proc_val);
 }
 
diff --git a/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c b/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c
index 7306ecf51..2614f62d6 100644
--- a/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c
+++ b/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c
@@ -211,7 +211,7 @@ static void setup(void)
 	 * knowing if perf_event_open() support is enabled is checking for
 	 * the existence of the file /proc/sys/kernel/perf_event_paranoid.
 	 */
-	if (access("/proc/sys/kernel/perf_event_paranoid", F_OK) == -1)
+	if (access(PROC_SYS_KERNEL "perf_event_paranoid", F_OK) == -1)
 		tst_brk(TCONF, "Kernel doesn't have perf_event support");
 
 	bind_to_current_cpu();
diff --git a/testcases/kernel/syscalls/pkeys/pkey01.c b/testcases/kernel/syscalls/pkeys/pkey01.c
index 8cbe2d6b5..6762d9912 100644
--- a/testcases/kernel/syscalls/pkeys/pkey01.c
+++ b/testcases/kernel/syscalls/pkeys/pkey01.c
@@ -36,7 +36,6 @@
 
 #define TEST_FILE "pkey_testfile"
 #define STR "abcdefghijklmnopqrstuvwxyz12345\n"
-#define PATH_VM_NRHPS "/proc/sys/vm/nr_hugepages"
 
 static int size;
 static int execute_supported = 1;
diff --git a/testcases/kernel/syscalls/preadv2/preadv203.c b/testcases/kernel/syscalls/preadv2/preadv203.c
index 472543e5c..905aa8af3 100644
--- a/testcases/kernel/syscalls/preadv2/preadv203.c
+++ b/testcases/kernel/syscalls/preadv2/preadv203.c
@@ -58,7 +58,7 @@ static volatile int stop;
 
 static void drop_caches(void)
 {
-	SAFE_FILE_PRINTF("/proc/sys/vm/drop_caches", "3");
+	SAFE_FILE_PRINTF(PATH_DROP_CACHES, "3");
 }
 
 /*
diff --git a/testcases/kernel/syscalls/readahead/readahead02.c b/testcases/kernel/syscalls/readahead/readahead02.c
index 5ebc43278..d50d833fc 100644
--- a/testcases/kernel/syscalls/readahead/readahead02.c
+++ b/testcases/kernel/syscalls/readahead/readahead02.c
@@ -35,7 +35,6 @@
 #include "lapi/syscalls.h"
 
 static char testfile[PATH_MAX] = "testfile";
-#define DROP_CACHES_FNAME "/proc/sys/vm/drop_caches"
 #define PROC_IO_FNAME "/proc/self/io"
 #define DEFAULT_FILESIZE (64 * 1024 * 1024)
 #define SHORT_SLEEP_US 5000
@@ -97,7 +96,7 @@ static int has_file(const char *fname, int required)
 
 static void drop_caches(void)
 {
-	SAFE_FILE_PRINTF(DROP_CACHES_FNAME, "1");
+	SAFE_FILE_PRINTF(PATH_DROP_CACHES, "1");
 }
 
 static unsigned long get_bytes_read(void)
@@ -430,7 +429,7 @@ static void setup(void)
 	if (access(PROC_IO_FNAME, F_OK))
 		tst_brk(TCONF, "Requires " PROC_IO_FNAME);
 
-	has_file(DROP_CACHES_FNAME, 1);
+	has_file(PATH_DROP_CACHES, 1);
 
 	/* check if readahead is supported */
 	tst_syscall(__NR_readahead, 0, 0, 0);
diff --git a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c
index 6dbf5af89..c12d987e8 100644
--- a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c
+++ b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c
@@ -17,7 +17,7 @@
 #include "tst_timer.h"
 #include "tst_sched.h"
 
-#define PROC_SCHED_RR_TIMESLICE_MS	"/proc/sys/kernel/sched_rr_timeslice_ms"
+#define PROC_SCHED_RR_TIMESLICE_MS	PROC_SYS_KERNEL "sched_rr_timeslice_ms"
 static int proc_flag;
 
 struct tst_ts tp;
diff --git a/testcases/kernel/syscalls/sendmsg/sendmsg03.c b/testcases/kernel/syscalls/sendmsg/sendmsg03.c
index 34ebc7e95..b7187fd8f 100644
--- a/testcases/kernel/syscalls/sendmsg/sendmsg03.c
+++ b/testcases/kernel/syscalls/sendmsg/sendmsg03.c
@@ -111,7 +111,7 @@ static struct tst_test test = {
 		NULL
 	},
 	.save_restore = (const struct tst_path_val[]) {
-		{"/proc/sys/user/max_user_namespaces", "1024", TST_SR_SKIP},
+		{PROC_SYS_USER "max_user_namespaces", "1024", TST_SR_SKIP},
 		{}
 	},
 	.tags = (const struct tst_tag[]) {
diff --git a/testcases/kernel/syscalls/sendto/sendto03.c b/testcases/kernel/syscalls/sendto/sendto03.c
index 622de6474..b35e51b96 100644
--- a/testcases/kernel/syscalls/sendto/sendto03.c
+++ b/testcases/kernel/syscalls/sendto/sendto03.c
@@ -205,7 +205,7 @@ static struct tst_test test = {
 		NULL
 	},
 	.save_restore = (const struct tst_path_val[]) {
-		{"/proc/sys/user/max_user_namespaces", "1024", TST_SR_SKIP},
+		{PROC_SYS_USER "max_user_namespaces", "1024", TST_SR_SKIP},
 		{}
 	},
 	.tags = (const struct tst_tag[]) {
diff --git a/testcases/kernel/syscalls/setpgid/setpgid02.c b/testcases/kernel/syscalls/setpgid/setpgid02.c
index 978d255e5..fd5823bd8 100644
--- a/testcases/kernel/syscalls/setpgid/setpgid02.c
+++ b/testcases/kernel/syscalls/setpgid/setpgid02.c
@@ -42,7 +42,7 @@ static void setup(void)
 	 * pid_max would not be in use by another process and guarantees that
 	 * it corresponds to an invalid PGID, generating EPERM.
 	 */
-	SAFE_FILE_SCANF("/proc/sys/kernel/pid_max", "%d\n", &inval_pgid);
+	SAFE_FILE_SCANF(PROC_SYS_KERNEL "pid_max", "%d\n", &inval_pgid);
 }
 
 static void run(unsigned int n)
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt05.c b/testcases/kernel/syscalls/setsockopt/setsockopt05.c
index 35a3d1bd3..d09a3b527 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt05.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt05.c
@@ -88,7 +88,7 @@ static struct tst_test test = {
 		NULL
 	},
 	.save_restore = (const struct tst_path_val[]) {
-		{"/proc/sys/user/max_user_namespaces", "1024", TST_SR_SKIP},
+		{PROC_SYS_USER "max_user_namespaces", "1024", TST_SR_SKIP},
 		{}
 	},
 	.tags = (const struct tst_tag[]) {
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt06.c b/testcases/kernel/syscalls/setsockopt/setsockopt06.c
index 2160b29e7..840155b8d 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt06.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt06.c
@@ -116,7 +116,7 @@ static struct tst_test test = {
 		NULL
 	},
 	.save_restore = (const struct tst_path_val[]) {
-		{"/proc/sys/user/max_user_namespaces", "1024", TST_SR_SKIP},
+		{PROC_SYS_USER "max_user_namespaces", "1024", TST_SR_SKIP},
 		{}
 	},
 	.tags = (const struct tst_tag[]) {
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt08.c b/testcases/kernel/syscalls/setsockopt/setsockopt08.c
index 76ec1054e..70985571b 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt08.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt08.c
@@ -158,7 +158,7 @@ static struct tst_test test = {
 		NULL
 	},
 	.save_restore = (const struct tst_path_val[]) {
-		{"/proc/sys/user/max_user_namespaces", "1024", TST_SR_SKIP},
+		{PROC_SYS_USER "max_user_namespaces", "1024", TST_SR_SKIP},
 		{}
 	},
 	.tags = (const struct tst_tag[]) {
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt09.c b/testcases/kernel/syscalls/setsockopt/setsockopt09.c
index a4b6b9315..c3f46443a 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt09.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt09.c
@@ -111,7 +111,7 @@ static struct tst_test test = {
 		NULL
 	},
 	.save_restore = (const struct tst_path_val[]) {
-		{"/proc/sys/user/max_user_namespaces", "1024", TST_SR_SKIP},
+		{PROC_SYS_USER "max_user_namespaces", "1024", TST_SR_SKIP},
 		{}
 	},
 	.tags = (const struct tst_tag[]) {
diff --git a/testcases/kernel/syscalls/splice/splice.h b/testcases/kernel/syscalls/splice/splice.h
index 16e4c98ed..a5313e0a3 100644
--- a/testcases/kernel/syscalls/splice/splice.h
+++ b/testcases/kernel/syscalls/splice/splice.h
@@ -26,13 +26,13 @@ static inline int get_max_limit(int default_len_data)
 {
 	int pipe_max_unpriv;
 
-	if (!access("/proc/sys/fs/pipe-max-size", F_OK)) {
-		SAFE_FILE_SCANF("/proc/sys/fs/pipe-max-size", "%d", &pipe_max_unpriv);
+	if (!access(PROC_SYS_FS "pipe-max-size", F_OK)) {
+		SAFE_FILE_SCANF(PROC_SYS_FS "pipe-max-size", "%d", &pipe_max_unpriv);
 		return MIN(pipe_max_unpriv, default_len_data);
 	}
 
-	if (!access("/proc/sys/fs/pipe-max-pages", F_OK)) {
-		SAFE_FILE_SCANF("/proc/sys/fs/pipe-max-pages", "%d", &pipe_max_unpriv);
+	if (!access(PROC_SYS_FS "pipe-max-pages", F_OK)) {
+		SAFE_FILE_SCANF(PROC_SYS_FS "pipe-max-pages", "%d", &pipe_max_unpriv);
 		return MIN(pipe_max_unpriv * getpagesize(), default_len_data);
 	}
 
diff --git a/testcases/kernel/syscalls/splice/splice06.c b/testcases/kernel/syscalls/splice/splice06.c
index e64d32ded..860960640 100644
--- a/testcases/kernel/syscalls/splice/splice06.c
+++ b/testcases/kernel/syscalls/splice/splice06.c
@@ -25,8 +25,8 @@
 #define PIPE_MAX_INIT_SIZE 65536
 #define DOMAIN_INIT_NAME "LTP_INIT"
 #define DOMAIN_TEST_NAME "LTP_TEST"
-#define INTEGER_PROCFILE "/proc/sys/fs/pipe-max-size"
-#define STRING_PROCFILE "/proc/sys/kernel/domainname"
+#define INTEGER_PROCFILE PROC_SYS_FS "pipe-max-size"
+#define STRING_PROCFILE PROC_SYS_KERNEL "domainname"
 static int pipe_max_test_size;
 
 static void format_str(char *str)
diff --git a/testcases/kernel/syscalls/syslog/syslog11.c b/testcases/kernel/syscalls/syslog/syslog11.c
index 28a6fdf49..f657fef28 100644
--- a/testcases/kernel/syscalls/syslog/syslog11.c
+++ b/testcases/kernel/syscalls/syslog/syslog11.c
@@ -56,7 +56,7 @@ static void run(unsigned int n)
 static struct tst_test test = {
 	.test = run,
 	.save_restore = (const struct tst_path_val[]) {
-		{"/proc/sys/kernel/printk", NULL, TST_SR_TBROK},
+		{PROC_SYS_KERNEL "printk", NULL, TST_SR_TBROK},
 		{}
 	},
 	.needs_root = 1,
diff --git a/testcases/kernel/syscalls/wait4/wait402.c b/testcases/kernel/syscalls/wait4/wait402.c
index 18ed0814f..12e8b68fa 100644
--- a/testcases/kernel/syscalls/wait4/wait402.c
+++ b/testcases/kernel/syscalls/wait4/wait402.c
@@ -25,7 +25,7 @@ static void run(void)
 
 static void setup(void)
 {
-	SAFE_FILE_SCANF("/proc/sys/kernel/pid_max", "%d\n", &pid_max);
+	SAFE_FILE_SCANF(PROC_SYS_KERNEL "pid_max", "%d\n", &pid_max);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/waitid/waitid10.c b/testcases/kernel/syscalls/waitid/waitid10.c
index 14d4ba76b..ef701e8ef 100644
--- a/testcases/kernel/syscalls/waitid/waitid10.c
+++ b/testcases/kernel/syscalls/waitid/waitid10.c
@@ -48,7 +48,7 @@ static void setup(void)
 	char c;
 
 	SAFE_GETRLIMIT(RLIMIT_CORE, &rlim);
-	SAFE_FILE_SCANF("/proc/sys/kernel/core_pattern", "%c", &c);
+	SAFE_FILE_SCANF(PROC_SYS_KERNEL	"core_pattern", "%c", &c);
 
 	if (rlim.rlim_cur)
 		return;
diff --git a/testcases/network/iptables/nft02.c b/testcases/network/iptables/nft02.c
index 5f0671c5d..fb06cfa3d 100644
--- a/testcases/network/iptables/nft02.c
+++ b/testcases/network/iptables/nft02.c
@@ -203,7 +203,7 @@ static struct tst_test test = {
 		NULL
 	},
 	.save_restore = (const struct tst_path_val[]) {
-		{"/proc/sys/user/max_user_namespaces", "1024", TST_SR_SKIP},
+		{PROC_SYS_USER "max_user_namespaces", "1024", TST_SR_SKIP},
 		{}
 	},
 	.tags = (const struct tst_tag[]) {
diff --git a/testcases/network/packet/fanout01.c b/testcases/network/packet/fanout01.c
index dc1ff6ce5..18e766d45 100644
--- a/testcases/network/packet/fanout01.c
+++ b/testcases/network/packet/fanout01.c
@@ -96,7 +96,7 @@ static struct tst_test test = {
 		NULL
 	},
 	.save_restore = (const struct tst_path_val[]) {
-		{"/proc/sys/user/max_user_namespaces", "1024", TST_SR_SKIP},
+		{PROC_SYS_USER "max_user_namespaces", "1024", TST_SR_SKIP},
 		{}
 	},
 	.tags = (const struct tst_tag[]) {
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
