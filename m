Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50480CD6E57
	for <ltp@archiver.kernel.org>; Thu,  4 Jun 2026 09:43:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EA40D3E71BE
	for <ltp@archiver.kernel.org>; Thu,  4 Jun 2026 11:43:04 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AA7023E5494
 for <ltp@lists.linux.it>; Thu,  4 Jun 2026 11:42:50 +0200 (CEST)
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com
 [IPv6:2001:41d0:203:375::b6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D47B46002C7
 for <ltp@lists.linux.it>; Thu,  4 Jun 2026 11:42:48 +0200 (CEST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1780566167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=mOeO1KUW1ZhYzAjindCrNk9s5G/x3brLADLHnfMtwjA=;
 b=q8Kw/7+iQSfr6J9rjIE6L851RRiBLFRHExKts9d1YmWZMGe3Ba1S1YLZRRVU1Q4SvpDJIT
 DFwsrGqCZmru2rjocrKz6CeUtMHbdpK/+6jz0cOtvrFhP2usiccTlcTP+7RWIvYdsa8gZg
 WV9Ops+kUazxraR8mUKhfHm/nzrc8i8=
From: Li Wang <li.wang@linux.dev>
To: ltp@lists.linux.it
Date: Thu,  4 Jun 2026 17:41:59 +0800
Message-ID: <20260604094200.21643-1-li.wang@linux.dev>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 1/2] lib: Introduce tst_path_defs.h to consolidate
 system paths
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

We have a lot of hardcoded strings and duplicated macros for /proc
and /sys paths scattered throughout the testcases.

This patch introduces a new common header, tst_path_defs.h, to centralize
and standardize these path definitions. By unifying these macros, we
reduce code duplication, improve maintainability, and ensure consistent
path usage across the entire LTP codebase.

Signed-off-by: Li Wang <li.wang@linux.dev>
Acked-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 include/tst_hugepage.h                        | 10 +-
 include/tst_path_defs.h                       | 95 +++++++++++++++++++
 include/tst_test.h                            |  1 +
 lib/newlib_tests/test19.c                     |  6 +-
 lib/newlib_tests/test20.c                     |  8 +-
 lib/newlib_tests/test_zero_hugepage.c         |  4 +-
 lib/tst_hugepage.c                            | 14 +--
 lib/tst_net.c                                 |  4 +-
 lib/tst_test.c                                |  2 +-
 libs/ipc/tse_ipc.c                            |  3 +-
 testcases/cve/cve-2015-3290.c                 |  8 +-
 testcases/cve/cve-2017-16939.c                |  2 +-
 testcases/cve/cve-2022-4378.c                 | 16 ++--
 testcases/cve/icmp_rate_limit01.c             |  8 +-
 testcases/cve/tcindex01.c                     |  2 +-
 testcases/kernel/containers/pidns/pidns05.c   |  2 +-
 testcases/kernel/containers/userns/userns01.c |  9 +-
 .../containers/userns/userns06_capcheck.c     |  2 +-
 testcases/kernel/containers/userns/userns07.c |  2 +-
 testcases/kernel/containers/userns/userns08.c |  6 +-
 testcases/kernel/include/ksm_helper.h         |  2 +-
 testcases/kernel/io/ltp-aiodio/aio-stress.c   |  2 +-
 .../kernel/io/ltp-aiodio/aiodio_append.c      |  2 +-
 testcases/kernel/lib/ksm_helper.c             |  4 +-
 testcases/kernel/logging/kmsg/kmsg01.c        | 11 +--
 .../kernel/mem/hugetlb/hugemmap/hugemmap05.c  | 14 +--
 .../kernel/mem/hugetlb/hugemmap/hugemmap08.c  |  6 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap10.c  |  8 +-
 .../kernel/mem/hugetlb/hugemmap/hugemmap32.c  | 11 +--
 .../kernel/mem/hugetlb/hugemmap/hugemmap34.c  |  1 -
 .../mem/hugetlb/hugeshmat/hugeshmat04.c       |  6 +-
 .../mem/hugetlb/hugeshmget/hugeshmget03.c     |  7 +-
 testcases/kernel/mem/hugetlb/lib/hugetlb.c    |  2 +-
 testcases/kernel/mem/hugetlb/lib/hugetlb.h    |  2 -
 testcases/kernel/mem/ksm/ksm01.c              | 10 +-
 testcases/kernel/mem/ksm/ksm02.c              | 10 +-
 testcases/kernel/mem/ksm/ksm03.c              | 10 +-
 testcases/kernel/mem/ksm/ksm04.c              | 10 +-
 testcases/kernel/mem/ksm/ksm05.c              |  4 +-
 testcases/kernel/mem/ksm/ksm06.c              | 32 +++----
 testcases/kernel/mem/ksm/ksm07.c              | 28 +++---
 testcases/kernel/mem/ksm/ksm_test.h           | 24 ++---
 testcases/kernel/mem/oom/oom.h                | 11 +--
 testcases/kernel/mem/oom/oom01.c              | 10 +-
 testcases/kernel/mem/oom/oom02.c              |  2 +-
 testcases/kernel/mem/oom/oom03.c              |  2 +-
 testcases/kernel/mem/oom/oom04.c              |  2 +-
 testcases/kernel/mem/oom/oom05.c              |  2 +-
 testcases/kernel/mem/thp/thp.h                |  4 +-
 testcases/kernel/mem/thp/thp02.c              |  2 +-
 testcases/kernel/mem/thp/thp03.c              |  2 +-
 .../kernel/mem/tunable/min_free_kbytes.c      | 22 ++---
 .../kernel/mem/tunable/overcommit_memory.c    | 17 ++--
 .../kernel/sched/sysctl/proc_sched_rt01.c     | 22 ++---
 testcases/kernel/syscalls/bind/bind06.c       |  2 +-
 .../kernel/syscalls/fanotify/fanotify10.c     | 13 +--
 .../kernel/syscalls/fanotify/fanotify17.c     | 17 ++--
 testcases/kernel/syscalls/fcntl/fcntl30.c     |  2 +-
 testcases/kernel/syscalls/fcntl/fcntl35.c     | 12 +--
 testcases/kernel/syscalls/fcntl/fcntl37.c     |  2 +-
 testcases/kernel/syscalls/fork/fork13.c       |  2 +-
 testcases/kernel/syscalls/getpid/getpid01.c   |  2 +-
 testcases/kernel/syscalls/getppid/getppid01.c |  2 +-
 .../kernel/syscalls/getxattr/getxattr05.c     |  9 +-
 testcases/kernel/syscalls/inotify/inotify07.c |  2 +-
 testcases/kernel/syscalls/inotify/inotify08.c |  2 +-
 .../kernel/syscalls/io_setup/io_setup01.c     |  6 +-
 .../kernel/syscalls/io_setup/io_setup02.c     |  4 +-
 .../kernel/syscalls/io_uring/io_uring01.c     |  2 +-
 .../kernel/syscalls/io_uring/io_uring02.c     |  2 +-
 .../kernel/syscalls/io_uring/io_uring03.c     |  2 +-
 .../kernel/syscalls/ipc/msgget/msgget03.c     |  4 +-
 .../kernel/syscalls/ipc/msgget/msgget04.c     |  2 +-
 .../kernel/syscalls/ipc/msgget/msgget05.c     |  2 +-
 .../syscalls/ipc/msgstress/msgstress01.c      |  2 +-
 .../kernel/syscalls/ipc/semget/semget05.c     |  4 +-
 .../kernel/syscalls/ipc/shmctl/shmctl03.c     |  6 +-
 .../kernel/syscalls/ipc/shmget/shmget02.c     |  2 +-
 .../kernel/syscalls/ipc/shmget/shmget03.c     |  2 +-
 .../kernel/syscalls/ipc/shmget/shmget05.c     |  5 +-
 .../kernel/syscalls/ipc/shmget/shmget06.c     |  6 +-
 testcases/kernel/syscalls/madvise/madvise01.c |  1 -
 testcases/kernel/syscalls/madvise/madvise02.c |  3 +-
 testcases/kernel/syscalls/madvise/madvise06.c |  2 +-
 testcases/kernel/syscalls/madvise/madvise08.c |  5 +-
 .../syscalls/memfd_create/memfd_create04.c    |  4 +-
 .../syscalls/migrate_pages/migrate_pages02.c  |  2 +-
 .../syscalls/migrate_pages/migrate_pages03.c  |  8 +-
 testcases/kernel/syscalls/mmap/mmap10.c       |  3 +-
 .../kernel/syscalls/move_pages/move_pages12.c | 12 +--
 .../kernel/syscalls/newuname/newuname01.c     |  8 +-
 .../perf_event_open/perf_event_open02.c       |  2 +-
 testcases/kernel/syscalls/pkeys/pkey01.c      |  1 -
 testcases/kernel/syscalls/preadv2/preadv203.c |  2 +-
 .../kernel/syscalls/readahead/readahead02.c   |  5 +-
 .../sched_rr_get_interval01.c                 |  6 +-
 testcases/kernel/syscalls/sendmsg/sendmsg03.c |  2 +-
 testcases/kernel/syscalls/sendto/sendto03.c   |  2 +-
 testcases/kernel/syscalls/setpgid/setpgid02.c |  2 +-
 .../kernel/syscalls/setrlimit/setrlimit03.c   |  6 +-
 .../kernel/syscalls/setsockopt/setsockopt05.c |  2 +-
 .../kernel/syscalls/setsockopt/setsockopt06.c |  2 +-
 .../kernel/syscalls/setsockopt/setsockopt07.c |  2 +-
 .../kernel/syscalls/setsockopt/setsockopt08.c |  2 +-
 .../kernel/syscalls/setsockopt/setsockopt09.c |  2 +-
 testcases/kernel/syscalls/splice/splice.h     |  8 +-
 testcases/kernel/syscalls/splice/splice06.c   | 24 +++--
 testcases/kernel/syscalls/syslog/syslog11.c   |  2 +-
 testcases/kernel/syscalls/unshare/unshare03.c |  6 +-
 testcases/kernel/syscalls/wait4/wait402.c     |  2 +-
 testcases/kernel/syscalls/waitid/waitid10.c   |  2 +-
 testcases/network/iptables/nft02.c            |  2 +-
 testcases/network/packet/fanout01.c           |  2 +-
 113 files changed, 396 insertions(+), 364 deletions(-)
 create mode 100644 include/tst_path_defs.h

diff --git a/include/tst_hugepage.h b/include/tst_hugepage.h
index 6b865b2f2..f3f1ec032 100644
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
+#include "tst_path_defs.h"
 
 extern char *nr_opt; /* -s num   Set the number of the been allocated hugepages */
 extern char *Hopt;   /* -H /..   Location of hugetlbfs, i.e.  -H /var/hugetlbfs */
diff --git a/include/tst_path_defs.h b/include/tst_path_defs.h
new file mode 100644
index 000000000..bc52cb78a
--- /dev/null
+++ b/include/tst_path_defs.h
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) Linux Test Project, 2026
+ * Copyright (c) 2026 Li Wang <li.wang@linux.dev>
+ */
+
+#ifndef TST_PATH_DEFS__
+#define TST_PATH_DEFS__
+
+/* KERNEL */
+#define PATH_KERN_HOSTNAME			"/proc/sys/kernel/hostname"
+#define PATH_KERN_OSRELEASE			"/proc/sys/kernel/osrelease"
+#define PATH_KERN_VERSION			"/proc/sys/kernel/version"
+#define PATH_KERN_DOMAINNAME			"/proc/sys/kernel/domainname"
+#define PATH_KERN_PRINTK			"/proc/sys/kernel/printk"
+#define PATH_KERN_PID_MAX			"/proc/sys/kernel/pid_max"
+#define PATH_KERN_SHMMAX			"/proc/sys/kernel/shmmax"
+#define PATH_KERN_SHMMNI			"/proc/sys/kernel/shmmni"
+#define PATH_KERN_SHMALL			"/proc/sys/kernel/shmall"
+#define PATH_KERN_SHM_NEXT_ID			"/proc/sys/kernel/shm_next_id"
+#define PATH_KERN_MSGMNI			"/proc/sys/kernel/msgmni"
+#define PATH_KERN_MSG_NEXT_ID			"/proc/sys/kernel/msg_next_id"
+#define PATH_KERN_SEM				"/proc/sys/kernel/sem"
+#define PATH_KERN_CORE_PATTERN			"/proc/sys/kernel/core_pattern"
+#define PATH_KERN_CAP_LAST_CAP			"/proc/sys/kernel/cap_last_cap"
+#define PATH_KERN_NUMA_BALANCING		"/proc/sys/kernel/numa_balancing"
+#define PATH_KERN_IO_URING_DISABLED		"/proc/sys/kernel/io_uring_disabled"
+#define PATH_KERN_OVERFLOWUID			"/proc/sys/kernel/overflowuid"
+#define PATH_KERN_OVERFLOWGID			"/proc/sys/kernel/overflowgid"
+#define PATH_KERN_PERF_EVENT_PARANOID		"/proc/sys/kernel/perf_event_paranoid"
+#define PATH_KERN_PERF_EVENT_MLOCK_KB		"/proc/sys/kernel/perf_event_mlock_kb"
+#define PATH_KERN_PERF_EVENT_MAX_SAMPLE_RATE	"/proc/sys/kernel/perf_event_max_sample_rate"
+#define PATH_KERN_SCHED_RT_PERIOD_US		"/proc/sys/kernel/sched_rt_period_us"
+#define PATH_KERN_SCHED_RT_RUNTIME_US		"/proc/sys/kernel/sched_rt_runtime_us"
+#define PATH_KERN_SCHED_RR_TIMESLICE_MS		"/proc/sys/kernel/sched_rr_timeslice_ms"
+#define PATH_KERN_UNPRIVILEGED_USERNS_CLONE	"/proc/sys/kernel/unprivileged_userns_clone"
+
+/* USER */
+#define PATH_USER_MAX_USER_NAMESPACES		"/proc/sys/user/max_user_namespaces"
+#define PATH_USER_MAX_FANOTIFY_GROUPS		"/proc/sys/user/max_fanotify_groups"
+#define PATH_USER_MAX_FANOTIFY_MARKS		"/proc/sys/user/max_fanotify_marks"
+
+/* FS */
+#define PATH_FS_NR_OPEN				"/proc/sys/fs/nr_open"
+#define PATH_FS_NR_AIO_MAX_NR			"/proc/sys/fs/aio-max-nr"
+#define PATH_FS_PIPE_MAX_SIZE			"/proc/sys/fs/pipe-max-size"
+#define PATH_FS_PIPE_MAX_PAGES			"/proc/sys/fs/pipe-max-pages"
+#define PATH_FS_MAX_USER_GROUPS			"/proc/sys/fs/fanotify/max_user_groups"
+#define PATH_FS_MAX_USER_MARKS			"/proc/sys/fs/fanotify/max_user_marks"
+
+/* VM */
+#define PATH_VM_DROP_CACHES			"/proc/sys/vm/drop_caches"
+#define PATH_VM_COMPACT_MEMORY			"/proc/sys/vm/compact_memory"
+#define PATH_VM_PANIC_ON_OOM			"/proc/sys/vm/panic_on_oom"
+#define PATH_VM_OVERCOMMIT_MEMORY		"/proc/sys/vm/overcommit_memory"
+#define PATH_VM_OVERCOMMIT_RATIO		"/proc/sys/vm/overcommit_ratio"
+#define PATH_VM_MIN_FREE_KBYTES			"/proc/sys/vm/min_free_kbytes"
+#define PATH_VM_VFS_CACHE_PRESSURE		"/proc/sys/vm/vfs_cache_pressure"
+
+/* HUGETLB */
+#define PATH_MM_HUGEPAGES			"/sys/kernel/mm/hugepages/"
+#define PATH_MM_THP				"/sys/kernel/mm/transparent_hugepage/"
+#define PATH_VM_NR_HPAGES			"/proc/sys/vm/nr_hugepages"
+#define PATH_VM_OVERCOMMIT_HPAGES		"/proc/sys/vm/nr_overcommit_hugepages"
+
+/* KSM */
+#define PATH_MM_KSM				"/sys/kernel/mm/ksm/"
+#define PATH_MM_KSM_RUN				"/sys/kernel/mm/ksm/run"
+#define PATH_MM_KSM_FULL_SCANS			"/sys/kernel/mm/ksm/full_scans"
+#define PATH_MM_KSM_SLEEP_MILLISECS		"/sys/kernel/mm/ksm/sleep_millisecs"
+#define PATH_MM_KSM_MAX_PAGE_SHARING		"/sys/kernel/mm/ksm/max_page_sharing"
+#define PATH_MM_KSM_MERGE_ACROSS_NODES		"/sys/kernel/mm/ksm/merge_across_nodes"
+#define PATH_MM_KSM_SMART_SCAN			"/sys/kernel/mm/ksm/smart_scan"
+#define PATH_MM_KSM_PAGES_TO_SCAN		"/sys/kernel/mm/ksm/pages_to_scan"
+#define PATH_MM_KSM_PAGES_SKIPPED		"/sys/kernel/mm/ksm/pages_skipped"
+
+/* NETWORK */
+#define PATH_NET_IPV4				"/proc/sys/net/ipv4/"
+#define PATH_NET_IPV4_ICMP_RATELIMIT		"/proc/sys/net/ipv4/icmp_ratelimit"
+#define PATH_NET_IPV4_ICMP_RATEMASK		"/proc/sys/net/ipv4/icmp_ratemask"
+#define PATH_NET_IPV4_ICMP_ECHO_IGNORE_ALL	"/proc/sys/net/ipv4/icmp_echo_ignore_all"
+#define PATH_NET_IPV4_ICMP_MSGS_BURST		"/proc/sys/net/ipv4/icmp_msgs_burst"
+#define PATH_NET_IPV4_TCP_PROBE_INTERVAL	"/proc/sys/net/ipv4/tcp_probe_interval"
+#define PATH_NET_IPV4_TCP_KEEPALIVE_TIME	"/proc/sys/net/ipv4/tcp_keepalive_time"
+#define PATH_NET_IPV4_TCP_NOTSENT_LOWAT		"/proc/sys/net/ipv4/tcp_notsent_lowat"
+#define PATH_NET_IPV4_IP_LOCAL_RESERVED_PORTS	"/proc/sys/net/ipv4/ip_local_reserved_ports"
+
+/* MEMINFO */
+#define MEMINFO_HPAGE_TOTAL	"HugePages_Total:"
+#define MEMINFO_HPAGE_FREE	"HugePages_Free:"
+#define MEMINFO_HPAGE_RSVD	"HugePages_Rsvd:"
+#define MEMINFO_HPAGE_SURP	"HugePages_Surp:"
+#define MEMINFO_HPAGE_SIZE	"Hugepagesize:"
+
+#endif /* TST_PATH_DEFS__ */
diff --git a/include/tst_test.h b/include/tst_test.h
index 16387d21b..9bc67cf6a 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -21,6 +21,7 @@
 #include "tst_res_flags.h"
 #include "tst_parse.h"
 #include "tst_test_macros.h"
+#include "tst_path_defs.h"
 #include "tst_checkpoint.h"
 #include "tst_device.h"
 #include "tst_mkfs.h"
diff --git a/lib/newlib_tests/test19.c b/lib/newlib_tests/test19.c
index a5683eaa4..1a3ee4523 100644
--- a/lib/newlib_tests/test19.c
+++ b/lib/newlib_tests/test19.c
@@ -10,7 +10,7 @@
 
 static void setup(void)
 {
-	SAFE_FILE_PRINTF("/proc/sys/kernel/core_pattern", "changed");
+	SAFE_FILE_PRINTF(PATH_KERN_CORE_PATTERN, "changed");
 	tst_sys_conf_dump();
 }
 
@@ -25,8 +25,8 @@ static struct tst_test test = {
 	.setup = setup,
 	.save_restore = (const struct tst_path_val[]) {
 		{"/proc/nonexistent", NULL, TST_SR_SKIP},
-		{"/proc/sys/kernel/numa_balancing", NULL, TST_SR_TBROK},
-		{"/proc/sys/kernel/core_pattern", NULL, TST_SR_TCONF},
+		{PATH_KERN_NUMA_BALANCING, NULL, TST_SR_TBROK},
+		{PATH_KERN_CORE_PATTERN, NULL, TST_SR_TCONF},
 		{}
 	},
 };
diff --git a/lib/newlib_tests/test20.c b/lib/newlib_tests/test20.c
index 3726cea0e..079a49c99 100644
--- a/lib/newlib_tests/test20.c
+++ b/lib/newlib_tests/test20.c
@@ -16,10 +16,10 @@ static void do_test(void) {
 	unsigned long val, hpages;
 
 	tst_res(TINFO, "tst_hugepages = %lu", tst_hugepages);
-	SAFE_FILE_PRINTF("/proc/sys/kernel/numa_balancing", "1");
+	SAFE_FILE_PRINTF(PATH_KERN_NUMA_BALANCING, "1");
 
 	hpages = test.hugepages.number;
-	SAFE_FILE_SCANF(PATH_NR_HPAGES, "%lu", &val);
+	SAFE_FILE_SCANF(PATH_VM_NR_HPAGES, "%lu", &val);
 	if (val != hpages)
 		tst_brk(TBROK, "nr_hugepages = %lu, but expect %lu", val, hpages);
 	else
@@ -28,7 +28,7 @@ static void do_test(void) {
 	struct tst_hugepage hp = { 1000000000000, TST_REQUEST };
 	hpages = tst_reserve_hugepages(&hp);
 
-	SAFE_FILE_SCANF(PATH_NR_HPAGES, "%lu", &val);
+	SAFE_FILE_SCANF(PATH_VM_NR_HPAGES, "%lu", &val);
 	if (val != hpages)
 		tst_brk(TBROK, "nr_hugepages = %lu, but expect %lu", val, hpages);
 	else
@@ -39,7 +39,7 @@ static struct tst_test test = {
 	.test_all = do_test,
 	.hugepages = {2, TST_NEEDS},
 	.save_restore = (const struct tst_path_val[]) {
-		{"/proc/sys/kernel/numa_balancing", "0", TST_SR_TBROK},
+		{PATH_KERN_NUMA_BALANCING, "0", TST_SR_TBROK},
 		{}
 	},
 };
diff --git a/lib/newlib_tests/test_zero_hugepage.c b/lib/newlib_tests/test_zero_hugepage.c
index eec48ffb4..a0bcdd0de 100644
--- a/lib/newlib_tests/test_zero_hugepage.c
+++ b/lib/newlib_tests/test_zero_hugepage.c
@@ -15,7 +15,7 @@ static void do_test(void)
 {
 	unsigned long val, hpages;
 
-	SAFE_FILE_SCANF(PATH_NR_HPAGES, "%lu", &val);
+	SAFE_FILE_SCANF(PATH_VM_NR_HPAGES, "%lu", &val);
 	if (val != 0)
 		tst_brk(TBROK, "nr_hugepages = %lu, but expect 0", val);
 	else
@@ -23,7 +23,7 @@ static void do_test(void)
 
 	struct tst_hugepage hp = { 3, TST_REQUEST };
 	hpages = tst_reserve_hugepages(&hp);
-	SAFE_FILE_SCANF(PATH_NR_HPAGES, "%lu", &val);
+	SAFE_FILE_SCANF(PATH_VM_NR_HPAGES, "%lu", &val);
 	if (val != hpages)
 		tst_brk(TBROK, "nr_hugepages = %lu, but expect %lu", val, hpages);
 	else
diff --git a/lib/tst_hugepage.c b/lib/tst_hugepage.c
index d2e70a955..40ecfa162 100644
--- a/lib/tst_hugepage.c
+++ b/lib/tst_hugepage.c
@@ -14,7 +14,7 @@ char *Hopt;
 
 size_t tst_get_hugepage_size(void)
 {
-	if (access(PATH_HUGEPAGES, F_OK))
+	if (access(PATH_MM_HUGEPAGES, F_OK))
 		return 0;
 
 	return SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
@@ -24,12 +24,12 @@ unsigned long tst_reserve_hugepages(struct tst_hugepage *hp)
 {
 	unsigned long val, max_hpages;
 	struct tst_path_val pvl = {
-		.path = PATH_NR_HPAGES,
+		.path = PATH_VM_NR_HPAGES,
 		.val = NULL,
 		.flags = TST_SR_SKIP_MISSING | TST_SR_TCONF_RO
 	};
 
-	if (access(PATH_HUGEPAGES, F_OK)) {
+	if (access(PATH_MM_HUGEPAGES, F_OK)) {
 		if (hp->policy == TST_NEEDS)
 			tst_brk(TCONF, "hugetlbfs is not supported");
 		tst_hugepages = 0;
@@ -46,8 +46,8 @@ unsigned long tst_reserve_hugepages(struct tst_hugepage *hp)
 		goto set_hugepages;
 	}
 
-	SAFE_FILE_PRINTF("/proc/sys/vm/drop_caches", "3");
-	SAFE_FILE_PRINTF("/proc/sys/vm/compact_memory", "1");
+	SAFE_FILE_PRINTF(PATH_VM_DROP_CACHES, "3");
+	SAFE_FILE_PRINTF(PATH_VM_COMPACT_MEMORY, "1");
 	if (hp->policy == TST_NEEDS) {
 		tst_hugepages += SAFE_READ_MEMINFO("HugePages_Total:");
 		goto set_hugepages;
@@ -66,8 +66,8 @@ unsigned long tst_reserve_hugepages(struct tst_hugepage *hp)
 
 set_hugepages:
 	tst_sys_conf_save(&pvl);
-	SAFE_FILE_PRINTF(PATH_NR_HPAGES, "%lu", tst_hugepages);
-	SAFE_FILE_SCANF(PATH_NR_HPAGES, "%lu", &val);
+	SAFE_FILE_PRINTF(PATH_VM_NR_HPAGES, "%lu", tst_hugepages);
+	SAFE_FILE_SCANF(PATH_VM_NR_HPAGES, "%lu", &val);
 	if (val != tst_hugepages)
 		tst_brk(TCONF, "nr_hugepages = %lu, but expect %lu. "
 				"Not enough hugepages for testing.",
diff --git a/lib/tst_net.c b/lib/tst_net.c
index a97e25b11..bd235f470 100644
--- a/lib/tst_net.c
+++ b/lib/tst_net.c
@@ -229,8 +229,8 @@ void tst_setup_netns(void)
 	int real_gid = getgid();
 	int nscount = 1;
 
-	if (!access("/proc/sys/user/max_user_namespaces", F_OK)) {
-		SAFE_FILE_SCANF("/proc/sys/user/max_user_namespaces", "%d",
+	if (!access(PATH_USER_MAX_USER_NAMESPACES, F_OK)) {
+		SAFE_FILE_SCANF(PATH_USER_MAX_USER_NAMESPACES, "%d",
 			&nscount);
 	}
 
diff --git a/lib/tst_test.c b/lib/tst_test.c
index b525a01ad..0bebb0a3e 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1212,7 +1212,7 @@ static void prepare_and_mount_dev_fs(const char *mntpoint)
 
 static void prepare_and_mount_hugetlb_fs(void)
 {
-	if (access(PATH_HUGEPAGES, F_OK))
+	if (access(PATH_MM_HUGEPAGES, F_OK))
 		tst_brk(TCONF, "hugetlbfs is not supported");
 
 	SAFE_MOUNT("none", tst_test->mntpoint, "hugetlbfs", 0, NULL);
diff --git a/libs/ipc/tse_ipc.c b/libs/ipc/tse_ipc.c
index 4fe4843d2..3d8a6d5f9 100644
--- a/libs/ipc/tse_ipc.c
+++ b/libs/ipc/tse_ipc.c
@@ -22,6 +22,7 @@
  */
 
 #define LIBIPC
+#include "tst_path_defs.h"
 #include "tse_ipcmsg.h"
 #include "tse_ipcsem.h"
 
@@ -190,7 +191,7 @@ int get_max_msgqueues(void)
 	char buff[BUFSIZE];
 
 	/* Get the max number of message queues allowed on system */
-	f = fopen("/proc/sys/kernel/msgmni", "r");
+	f = fopen(PATH_KERN_MSGMNI, "r");
 	if (!f) {
 		tst_resm(TBROK, "Could not open /proc/sys/kernel/msgmni");
 		return -1;
diff --git a/testcases/cve/cve-2015-3290.c b/testcases/cve/cve-2015-3290.c
index cb60582b4..a6826bda2 100644
--- a/testcases/cve/cve-2015-3290.c
+++ b/testcases/cve/cve-2015-3290.c
@@ -466,13 +466,11 @@ static void setup(void)
          * knowing if perf_event_open() support is enabled is checking for
          * the existence of the file /proc/sys/kernel/perf_event_paranoid.
          */
-	if (access("/proc/sys/kernel/perf_event_paranoid", F_OK) == -1)
+	if (access(PATH_KERN_PERF_EVENT_PARANOID, F_OK) == -1)
 		tst_brk(TCONF, "Kernel doesn't have perf_event support");
 
-	SAFE_FILE_SCANF("/proc/sys/kernel/perf_event_mlock_kb",
-			"%d", &event_mlock_kb);
-	SAFE_FILE_SCANF("/proc/sys/kernel/perf_event_max_sample_rate",
-			"%d", &max_sample_rate);
+	SAFE_FILE_SCANF(PATH_KERN_PERF_EVENT_MLOCK_KB, "%d", &event_mlock_kb);
+	SAFE_FILE_SCANF(PATH_KERN_PERF_EVENT_MAX_SAMPLE_RATE, "%d", &max_sample_rate);
 }
 
 static void run(void)
diff --git a/testcases/cve/cve-2017-16939.c b/testcases/cve/cve-2017-16939.c
index 098a86841..915e3f816 100644
--- a/testcases/cve/cve-2017-16939.c
+++ b/testcases/cve/cve-2017-16939.c
@@ -91,7 +91,7 @@ static struct tst_test test = {
 		NULL
 	},
 	.save_restore = (const struct tst_path_val[]) {
-		{"/proc/sys/user/max_user_namespaces", "1024", TST_SR_SKIP},
+		{PATH_USER_MAX_USER_NAMESPACES, "1024", TST_SR_SKIP},
 		{}
 	},
 	.tags = (const struct tst_tag[]) {
diff --git a/testcases/cve/cve-2022-4378.c b/testcases/cve/cve-2022-4378.c
index e7e2b9af3..361d46f40 100644
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
+	{PATH_NET_IPV4_ICMP_RATELIMIT, EINVAL},
+	{PATH_NET_IPV4_ICMP_RATEMASK, EINVAL},
+	{PATH_NET_IPV4_ICMP_ECHO_IGNORE_ALL, EINVAL},
+	{PATH_NET_IPV4_TCP_PROBE_INTERVAL, EINVAL},
+	{PATH_NET_IPV4_TCP_KEEPALIVE_TIME, EINVAL},
+	{PATH_NET_IPV4_TCP_NOTSENT_LOWAT, EINVAL},
+	{PATH_NET_IPV4_IP_LOCAL_RESERVED_PORTS, 0}
 };
 
 static void setup(void)
@@ -93,7 +93,7 @@ static struct tst_test test = {
 		NULL
 	},
 	.save_restore = (const struct tst_path_val[]) {
-		{"/proc/sys/user/max_user_namespaces", "1024", TST_SR_SKIP},
+		{PATH_USER_MAX_USER_NAMESPACES, "1024", TST_SR_SKIP},
 		{}
 	},
 	.tags = (const struct tst_tag[]) {
diff --git a/testcases/cve/icmp_rate_limit01.c b/testcases/cve/icmp_rate_limit01.c
index 5bc6efb46..3e0be6ff7 100644
--- a/testcases/cve/icmp_rate_limit01.c
+++ b/testcases/cve/icmp_rate_limit01.c
@@ -66,8 +66,8 @@ static void setup(void)
 	 * Set namespace local rate limit if needed. The global limit might
 	 * be ignored otherwise.
 	 */
-	if (!access("/proc/sys/net/ipv4/icmp_msgs_burst", F_OK))
-		SAFE_FILE_PRINTF("/proc/sys/net/ipv4/icmp_msgs_burst", "50");
+	if (!access(PATH_NET_IPV4_ICMP_MSGS_BURST, F_OK))
+		SAFE_FILE_PRINTF(PATH_NET_IPV4_ICMP_MSGS_BURST, "50");
 
 	/* Configure child namespace */
 	CREATE_VETH_PAIR("ltp_veth1", "ltp_veth2");
@@ -262,8 +262,8 @@ static struct tst_test test = {
 		NULL
 	},
 	.save_restore = (const struct tst_path_val[]) {
-		{"/proc/sys/user/max_user_namespaces", "1024", TST_SR_SKIP},
-		{"/proc/sys/net/ipv4/icmp_msgs_burst", "50", TST_SR_TBROK},
+		{PATH_NET_IPV4_ICMP_MSGS_BURST, "50", TST_SR_TBROK},
+		{PATH_USER_MAX_USER_NAMESPACES, "1024", TST_SR_SKIP},
 		{}
 	},
 	.tags = (const struct tst_tag[]) {
diff --git a/testcases/cve/tcindex01.c b/testcases/cve/tcindex01.c
index 478d75055..7aa0fc60a 100644
--- a/testcases/cve/tcindex01.c
+++ b/testcases/cve/tcindex01.c
@@ -149,7 +149,7 @@ static struct tst_test test = {
 		NULL
 	},
 	.save_restore = (const struct tst_path_val[]) {
-		{"/proc/sys/user/max_user_namespaces", "1024", TST_SR_SKIP},
+		{PATH_USER_MAX_USER_NAMESPACES, "1024", TST_SR_SKIP},
 		{}
 	},
 	.tags = (const struct tst_tag[]) {
diff --git a/testcases/kernel/containers/pidns/pidns05.c b/testcases/kernel/containers/pidns/pidns05.c
index 4b0478c84..3e7c755bc 100644
--- a/testcases/kernel/containers/pidns/pidns05.c
+++ b/testcases/kernel/containers/pidns/pidns05.c
@@ -71,7 +71,7 @@ static int find_cinit_pids(pid_t *pids)
 
 static void setup(void)
 {
-	SAFE_FILE_SCANF("/proc/sys/kernel/pid_max", "%d\n", &pid_max);
+	SAFE_FILE_SCANF(PATH_KERN_PID_MAX, "%d\n", &pid_max);
 }
 
 static void run(void)
diff --git a/testcases/kernel/containers/userns/userns01.c b/testcases/kernel/containers/userns/userns01.c
index 6ee9fa7d0..e607398b3 100644
--- a/testcases/kernel/containers/userns/userns01.c
+++ b/testcases/kernel/containers/userns/userns01.c
@@ -22,9 +22,6 @@
 #include <sys/capability.h>
 #include "lapi/sched.h"
 
-#define OVERFLOWUIDPATH "/proc/sys/kernel/overflowuid"
-#define OVERFLOWGIDPATH "/proc/sys/kernel/overflowgid"
-
 static long overflowuid;
 static long overflowgid;
 
@@ -45,7 +42,7 @@ static void child_fn1(void)
 
 	caps = cap_get_proc();
 
-	SAFE_FILE_SCANF("/proc/sys/kernel/cap_last_cap", "%d", &last_cap);
+	SAFE_FILE_SCANF(PATH_KERN_CAP_LAST_CAP, "%d", &last_cap);
 
 	for (i = 0; i <= last_cap; i++) {
 		cap_get_flag(caps, i, CAP_EFFECTIVE, &flag_val);
@@ -65,8 +62,8 @@ static void child_fn1(void)
 
 static void setup(void)
 {
-	SAFE_FILE_SCANF(OVERFLOWUIDPATH, "%ld", &overflowuid);
-	SAFE_FILE_SCANF(OVERFLOWGIDPATH, "%ld", &overflowgid);
+	SAFE_FILE_SCANF(PATH_KERN_OVERFLOWUID, "%ld", &overflowuid);
+	SAFE_FILE_SCANF(PATH_KERN_OVERFLOWGID, "%ld", &overflowgid);
 }
 
 static void run(void)
diff --git a/testcases/kernel/containers/userns/userns06_capcheck.c b/testcases/kernel/containers/userns/userns06_capcheck.c
index 8669657b9..401182625 100644
--- a/testcases/kernel/containers/userns/userns06_capcheck.c
+++ b/testcases/kernel/containers/userns/userns06_capcheck.c
@@ -32,7 +32,7 @@ int main(int argc, char *argv[])
 	if (argc < 2)
 		tst_brk(TBROK, "userns06_capcheck <privileged|unprivileged>");
 
-	SAFE_FILE_SCANF("/proc/sys/kernel/cap_last_cap", "%d", &last_cap);
+	SAFE_FILE_SCANF(PATH_KERN_CAP_LAST_CAP, "%d", &last_cap);
 
 	if (strcmp("privileged", argv[1]))
 		expected_cap_flag = 0;
diff --git a/testcases/kernel/containers/userns/userns07.c b/testcases/kernel/containers/userns/userns07.c
index 9e34a3d9b..aaf3d1ae2 100644
--- a/testcases/kernel/containers/userns/userns07.c
+++ b/testcases/kernel/containers/userns/userns07.c
@@ -93,7 +93,7 @@ static struct tst_test test = {
 		NULL,
 	},
 	.save_restore = (const struct tst_path_val[]) {
-		{"/proc/sys/kernel/unprivileged_userns_clone", "1", TST_SR_SKIP},
+		{PATH_KERN_UNPRIVILEGED_USERNS_CLONE, "1", TST_SR_SKIP},
 		{}
 	},
 };
diff --git a/testcases/kernel/containers/userns/userns08.c b/testcases/kernel/containers/userns/userns08.c
index fbe51c8a5..2ee4da558 100644
--- a/testcases/kernel/containers/userns/userns08.c
+++ b/testcases/kernel/containers/userns/userns08.c
@@ -119,7 +119,7 @@ static void setup(void)
 	SAFE_WRITE(SAFE_WRITE_ALL, fd, "\n", 1);
 	SAFE_CLOSE(fd);
 
-	SAFE_TRY_FILE_PRINTF("/proc/sys/user/max_user_namespaces", "%d", 10);
+	SAFE_TRY_FILE_PRINTF(PATH_USER_MAX_USER_NAMESPACES, "%d", 10);
 }
 
 static struct tst_test test = {
@@ -133,8 +133,8 @@ static struct tst_test test = {
 		NULL
 	},
 	.save_restore = (const struct tst_path_val[]) {
-		{"/proc/sys/user/max_user_namespaces", NULL, TST_SR_SKIP},
-		{"/proc/sys/kernel/unprivileged_userns_clone", "1", TST_SR_SKIP},
+		{PATH_USER_MAX_USER_NAMESPACES, NULL, TST_SR_SKIP},
+		{PATH_KERN_UNPRIVILEGED_USERNS_CLONE, "1", TST_SR_SKIP},
 		{}
 	},
 	.tags = (const struct tst_tag[]) {
diff --git a/testcases/kernel/include/ksm_helper.h b/testcases/kernel/include/ksm_helper.h
index d4a6d5c7d..5f473dd6c 100644
--- a/testcases/kernel/include/ksm_helper.h
+++ b/testcases/kernel/include/ksm_helper.h
@@ -7,7 +7,7 @@
 #ifndef KSM_HELPER_H
 #define KSM_HELPER_H
 
-#define PATH_KSM	"/sys/kernel/mm/ksm/"
+#include "tst_path_defs.h"
 
 void wait_ksmd_full_scan(void);
 
diff --git a/testcases/kernel/io/ltp-aiodio/aio-stress.c b/testcases/kernel/io/ltp-aiodio/aio-stress.c
index 5cce92dfa..8f596bf2d 100644
--- a/testcases/kernel/io/ltp-aiodio/aio-stress.c
+++ b/testcases/kernel/io/ltp-aiodio/aio-stress.c
@@ -1166,7 +1166,7 @@ static void setup(void)
 
 	page_size_mask = getpagesize() - 1;
 
-	SAFE_FILE_SCANF("/proc/sys/fs/aio-max-nr", "%d", &maxaio);
+	SAFE_FILE_SCANF(PATH_FS_NR_AIO_MAX_NR, "%d", &maxaio);
 	tst_res(TINFO, "Maximum AIO blocks: %d", maxaio);
 
 	if (tst_parse_int(str_num_files, &num_files, 1, INT_MAX))
diff --git a/testcases/kernel/io/ltp-aiodio/aiodio_append.c b/testcases/kernel/io/ltp-aiodio/aiodio_append.c
index f1e7025fe..f9cf2df47 100644
--- a/testcases/kernel/io/ltp-aiodio/aiodio_append.c
+++ b/testcases/kernel/io/ltp-aiodio/aiodio_append.c
@@ -106,7 +106,7 @@ static void setup(void)
 	if (tst_parse_int(str_numaio, &numaio, 1, INT_MAX))
 		tst_brk(TBROK, "Number of async IO blocks '%s'", str_numaio);
 
-	SAFE_FILE_SCANF("/proc/sys/fs/aio-max-nr", "%d", &maxaio);
+	SAFE_FILE_SCANF(PATH_FS_NR_AIO_MAX_NR, "%d", &maxaio);
 	tst_res(TINFO, "Maximum AIO blocks: %d", maxaio);
 
 	if (numaio > maxaio)
diff --git a/testcases/kernel/lib/ksm_helper.c b/testcases/kernel/lib/ksm_helper.c
index 586a0d1ee..b489aaa68 100644
--- a/testcases/kernel/lib/ksm_helper.c
+++ b/testcases/kernel/lib/ksm_helper.c
@@ -15,7 +15,7 @@ void wait_ksmd_full_scan(void)
 	unsigned long full_scans, at_least_one_full_scan;
 	int count = 0;
 
-	SAFE_FILE_SCANF(PATH_KSM "full_scans", "%lu", &full_scans);
+	SAFE_FILE_SCANF(PATH_MM_KSM_FULL_SCANS, "%lu", &full_scans);
 	/*
 	 * The current scan is already in progress so we can't guarantee that
 	 * the get_user_pages() is called on every existing rmap_item if we
@@ -30,7 +30,7 @@ void wait_ksmd_full_scan(void)
 	while (full_scans < at_least_one_full_scan) {
 		sleep(1);
 		count++;
-		SAFE_FILE_SCANF(PATH_KSM "full_scans", "%lu", &full_scans);
+		SAFE_FILE_SCANF(PATH_MM_KSM_FULL_SCANS, "%lu", &full_scans);
 	}
 
 	tst_res(TINFO, "ksm daemon takes %ds to run two full scans", count);
diff --git a/testcases/kernel/logging/kmsg/kmsg01.c b/testcases/kernel/logging/kmsg/kmsg01.c
index ba8179d5a..14c6b0080 100644
--- a/testcases/kernel/logging/kmsg/kmsg01.c
+++ b/testcases/kernel/logging/kmsg/kmsg01.c
@@ -32,8 +32,7 @@
 #define NUM_READ_MSGS 3
 #define NUM_READ_RETRY 10
 #define NUM_OVERWRITE_MSGS 1024
-#define PRINTK "/proc/sys/kernel/printk"
-#define CONSOLE_LOGLEVEL_QUIET   4
+#define CONSOLE_LOGLEVEL_QUIET  4
 
 static int console_loglevel = -1;
 
@@ -556,16 +555,16 @@ static void test_kmsg(void)
 
 static void setup(void)
 {
-	if (access(PRINTK, F_OK) == 0) {
-		SAFE_FILE_SCANF(PRINTK, "%d", &console_loglevel);
-		SAFE_FILE_PRINTF(PRINTK, "%d", CONSOLE_LOGLEVEL_QUIET);
+	if (access(PATH_KERN_PRINTK, F_OK) == 0) {
+		SAFE_FILE_SCANF(PATH_KERN_PRINTK, "%d", &console_loglevel);
+		SAFE_FILE_PRINTF(PATH_KERN_PRINTK, "%d", CONSOLE_LOGLEVEL_QUIET);
 	}
 }
 
 static void cleanup(void)
 {
 	if (console_loglevel != -1)
-		SAFE_FILE_PRINTF(PRINTK, "%d", console_loglevel);
+		SAFE_FILE_PRINTF(PATH_KERN_PRINTK, "%d", console_loglevel);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap05.c
index 75f28102d..526eacb2f 100644
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
@@ -171,7 +167,7 @@ static void cleanup(void)
 		tst_umount(MOUNT_DIR);
 
 	if (restore_shmmax)
-		SAFE_FILE_PRINTF(PATH_SHMMAX, "%llu", shmmax);
+		SAFE_FILE_PRINTF(PATH_KERN_SHMMAX, "%llu", shmmax);
 
 	if (restore_overcomm_hgpgs) {
 		tst_res(TINFO, "restore nr_overcommit_hugepages to %ld.",
@@ -191,8 +187,8 @@ static void setup(void)
 		path = path_sys_sz_huge;
 		pathover = path_sys_sz_over;
 	} else {
-		path = PATH_PROC_HUGE;
-		pathover = PATH_PROC_OVER;
+		path = PATH_VM_NR_HPAGES;
+		pathover = PATH_VM_OVERCOMMIT_HPAGES;
 	}
 
 	if (opt_alloc) {
@@ -201,10 +197,10 @@ static void setup(void)
 	}
 
 	if (opt_shmid) {
-		SAFE_FILE_SCANF(PATH_SHMMAX, "%llu", &shmmax);
+		SAFE_FILE_SCANF(PATH_KERN_SHMMAX, "%llu", &shmmax);
 		if (shmmax < (unsigned long long)(length / 2 * hugepagesize)) {
 			restore_shmmax = 1;
-			SAFE_FILE_PRINTF(PATH_SHMMAX, "%ld",
+			SAFE_FILE_PRINTF(PATH_KERN_SHMMAX, "%ld",
 					(length / 2 * hugepagesize));
 		}
 	}
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c
index b9d61dd66..07fd70b43 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap08.c
@@ -102,11 +102,11 @@ static void run_test(unsigned int test_type)
 	switch (test_type) {
 	case WITHOUT_OVERCOMMIT:
 		tst_res(TINFO, "Without overcommit testing...");
-		SAFE_FILE_PRINTF(PATH_OC_HPAGES, "%d", 0);
+		SAFE_FILE_PRINTF(PATH_VM_OVERCOMMIT_HPAGES, "%d", 0);
 		break;
 	case WITH_OVERCOMMIT:
 		tst_res(TINFO, "With overcommit testing...");
-		SAFE_FILE_PRINTF(PATH_OC_HPAGES, "%d", 2);
+		SAFE_FILE_PRINTF(PATH_VM_OVERCOMMIT_HPAGES, "%d", 2);
 		break;
 	}
 	test_chunk_overcommit();
@@ -129,7 +129,7 @@ static struct tst_test test = {
 	.needs_hugetlbfs = 1,
 	.forks_child = 1,
 	.save_restore = (const struct tst_path_val[]) {
-		{PATH_OC_HPAGES, NULL, TST_SR_TCONF},
+		{PATH_VM_OVERCOMMIT_HPAGES, NULL, TST_SR_TCONF},
 		{}
 	},
 	.tcnt = 2,
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c
index e1795153d..5b5577a0e 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c
@@ -134,7 +134,7 @@ static int set_nr_hugepages_(long count, char *desc, int line)
 	long min_size;
 	long et, ef, er, es;
 
-	SAFE_FILE_PRINTF(PATH_NR_HPAGES, "%lu", count);
+	SAFE_FILE_PRINTF(PATH_VM_NR_HPAGES, "%lu", count);
 
 	/* The code below is based on set_max_huge_pages in mm/hugetlb.c */
 	es = prev_surp;
@@ -433,7 +433,7 @@ static void run_test(void)
 static void setup(void)
 {
 	hpage_size = SAFE_READ_MEMINFO(MEMINFO_HPAGE_SIZE)*1024;
-	SAFE_FILE_PRINTF(PATH_OC_HPAGES, "%lu", tst_hugepages);
+	SAFE_FILE_PRINTF(PATH_VM_OVERCOMMIT_HPAGES, "%lu", tst_hugepages);
 	private_resv = kernel_has_private_reservations();
 }
 
@@ -447,8 +447,8 @@ static struct tst_test test = {
 	.mntpoint = MNTPOINT,
 	.needs_hugetlbfs = 1,
 	.save_restore = (const struct tst_path_val[]) {
-		{PATH_OC_HPAGES, NULL, TST_SR_TCONF},
-		{PATH_NR_HPAGES, NULL, TST_SR_TCONF},
+		{PATH_VM_OVERCOMMIT_HPAGES, NULL, TST_SR_TCONF},
+		{PATH_VM_NR_HPAGES, NULL, TST_SR_TCONF},
 		{}
 	},
 	.setup = setup,
diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap32.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap32.c
index 188ee2176..b8636cbbd 100644
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
+	if (access(PATH_MM_HUGEPAGES, F_OK))
 		tst_brk(TCONF, "hugetlbfs is not supported");
 
-	dir = SAFE_OPENDIR(PATH_HUGEPAGE);
+	dir = SAFE_OPENDIR(PATH_MM_HUGEPAGES);
 	while ((ent = SAFE_READDIR(dir))) {
 		if ((sscanf(ent->d_name, "hugepages-%lukB", &hpage_size) == 1) &&
 			is_hugetlb_gigantic(hpage_size * 1024)) {
-			sprintf(g_hpage_path, "%s/%s/%s", PATH_HUGEPAGE,
+			sprintf(g_hpage_path, "%s/%s/%s", PATH_MM_HUGEPAGES,
 					ent->d_name, "nr_hugepages");
 			break;
 		}
@@ -62,8 +61,8 @@ static void setup(void)
 
 	SAFE_CLOSEDIR(dir);
 
-	SAFE_FILE_PRINTF("/proc/sys/vm/drop_caches", "3");
-	SAFE_FILE_PRINTF("/proc/sys/vm/compact_memory", "1");
+	SAFE_FILE_PRINTF(PATH_VM_DROP_CACHES, "3");
+	SAFE_FILE_PRINTF(PATH_VM_COMPACT_MEMORY, "1");
 
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
index 9f877fd07..6686e1460 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
@@ -82,8 +82,8 @@ static void setup(void)
 	long hpage_size, orig_hugepages;
 	unsigned long new_shmmax;
 
-	orig_hugepages = TST_SYS_CONF_LONG_GET("/proc/sys/vm/nr_hugepages");
-	SAFE_FILE_SCANF(PATH_SHMMAX, "%lu", &new_shmmax);
+	orig_hugepages = TST_SYS_CONF_LONG_GET(PATH_VM_NR_HPAGES);
+	SAFE_FILE_SCANF(PATH_KERN_SHMMAX, "%lu", &new_shmmax);
 
 	if (new_shmmax < SIZE)
 		tst_brk(TCONF,	"shmmax too low, have: %lu", new_shmmax);
@@ -108,7 +108,7 @@ static struct tst_test test = {
 	.setup = setup,
 	.hugepages = {1, TST_NEEDS},
 	.save_restore = (const struct tst_path_val[]) {
-		{PATH_SHMMAX, "1073741824", TST_SR_TCONF_MISSING | TST_SR_TBROK_RO},
+		{PATH_KERN_SHMMAX, "1073741824", TST_SR_TCONF_MISSING | TST_SR_TBROK_RO},
 		{}
 	},
 };
diff --git a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
index 625761f6e..0e9c7d5f0 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmget/hugeshmget03.c
@@ -19,7 +19,6 @@
  * depending on the system being tested.
  */
 #define MAXIDS	8192
-#define PATH_SHMMNI	"/proc/sys/kernel/shmmni"
 
 static size_t shm_size;
 static int shm_id_1 = -1;
@@ -49,8 +48,8 @@ static void setup(void)
 	if (tst_hugepages == 0)
 		tst_brk(TCONF, "No enough hugepages for testing.");
 
-	SAFE_FILE_SCANF(PATH_SHMMNI, "%ld", &orig_shmmni);
-	SAFE_FILE_PRINTF(PATH_SHMMNI, "%ld", tst_hugepages / 2);
+	SAFE_FILE_SCANF(PATH_KERN_SHMMNI, "%ld", &orig_shmmni);
+	SAFE_FILE_PRINTF(PATH_KERN_SHMMNI, "%ld", tst_hugepages / 2);
 
 	hpage_size = SAFE_READ_MEMINFO("Hugepagesize:") * 1024;
 	shm_size = hpage_size;
@@ -84,7 +83,7 @@ static void cleanup(void)
 		rm_shm(shm_id_arr[i]);
 
 	if (orig_shmmni != -1)
-		SAFE_FILE_PRINTF(PATH_SHMMNI, "%ld", orig_shmmni);
+		SAFE_FILE_PRINTF(PATH_KERN_SHMMNI, "%ld", orig_shmmni);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/mem/hugetlb/lib/hugetlb.c b/testcases/kernel/mem/hugetlb/lib/hugetlb.c
index 92b484d4a..ac97a0693 100644
--- a/testcases/kernel/mem/hugetlb/lib/hugetlb.c
+++ b/testcases/kernel/mem/hugetlb/lib/hugetlb.c
@@ -103,7 +103,7 @@ void update_shm_size(size_t * shm_size)
 {
 	size_t shmmax;
 
-	SAFE_FILE_SCANF(PATH_SHMMAX, "%zu", &shmmax);
+	SAFE_FILE_SCANF(PATH_KERN_SHMMAX, "%zu", &shmmax);
 	if (*shm_size > shmmax) {
 		tst_res(TINFO, "Set shm_size to shmmax: %zu", shmmax);
 		*shm_size = shmmax;
diff --git a/testcases/kernel/mem/hugetlb/lib/hugetlb.h b/testcases/kernel/mem/hugetlb/lib/hugetlb.h
index fa742eb8d..6b5d3a00b 100644
--- a/testcases/kernel/mem/hugetlb/lib/hugetlb.h
+++ b/testcases/kernel/mem/hugetlb/lib/hugetlb.h
@@ -29,8 +29,6 @@
 #define SHM_HUGETLB	04000	/* segment is mapped via hugetlb */
 #endif
 
-#define PATH_SHMMAX "/proc/sys/kernel/shmmax"
-
 #ifndef barrier
 # ifdef mb
 	/* Redefining the mb() */
diff --git a/testcases/kernel/mem/ksm/ksm01.c b/testcases/kernel/mem/ksm/ksm01.c
index be03f943f..a3e671549 100644
--- a/testcases/kernel/mem/ksm/ksm01.c
+++ b/testcases/kernel/mem/ksm/ksm01.c
@@ -74,13 +74,13 @@ static struct tst_test test = {
 	},
 	.setup = setup,
 	.save_restore = (const struct tst_path_val[]) {
-		{"/sys/kernel/mm/ksm/run", NULL, TST_SR_TBROK},
-		{"/sys/kernel/mm/ksm/sleep_millisecs", NULL, TST_SR_TBROK},
-		{"/sys/kernel/mm/ksm/max_page_sharing", NULL,
+		{PATH_MM_KSM_RUN, NULL, TST_SR_TBROK},
+		{PATH_MM_KSM_SLEEP_MILLISECS, NULL, TST_SR_TBROK},
+		{PATH_MM_KSM_MAX_PAGE_SHARING, NULL,
 			TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},
-		{"/sys/kernel/mm/ksm/merge_across_nodes", "1",
+		{PATH_MM_KSM_MERGE_ACROSS_NODES, "1",
 			TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},
-		{"/sys/kernel/mm/ksm/smart_scan", "0",
+		{PATH_MM_KSM_SMART_SCAN, "0",
 			TST_SR_SKIP_MISSING | TST_SR_TBROK_RO},
 		{}
 	},
diff --git a/testcases/kernel/mem/ksm/ksm02.c b/testcases/kernel/mem/ksm/ksm02.c
index 147e7e834..9b1b67523 100644
--- a/testcases/kernel/mem/ksm/ksm02.c
+++ b/testcases/kernel/mem/ksm/ksm02.c
@@ -97,13 +97,13 @@ static struct tst_test test = {
 	},
 	.setup = setup,
 	.save_restore = (const struct tst_path_val[]) {
-		{"/sys/kernel/mm/ksm/run", NULL, TST_SR_TBROK},
-		{"/sys/kernel/mm/ksm/sleep_millisecs", NULL, TST_SR_TBROK},
-		{"/sys/kernel/mm/ksm/max_page_sharing", NULL,
+		{PATH_MM_KSM_RUN, NULL, TST_SR_TBROK},
+		{PATH_MM_KSM_SLEEP_MILLISECS, NULL, TST_SR_TBROK},
+		{PATH_MM_KSM_MAX_PAGE_SHARING, NULL,
 			TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},
-		{"/sys/kernel/mm/ksm/merge_across_nodes", "1",
+		{PATH_MM_KSM_MERGE_ACROSS_NODES, "1",
 			TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},
-		{"/sys/kernel/mm/ksm/smart_scan", "0",
+		{PATH_MM_KSM_SMART_SCAN, "0",
 			TST_SR_SKIP_MISSING | TST_SR_TBROK_RO},
 		{}
 	},
diff --git a/testcases/kernel/mem/ksm/ksm03.c b/testcases/kernel/mem/ksm/ksm03.c
index 34a086ae7..7011875fd 100644
--- a/testcases/kernel/mem/ksm/ksm03.c
+++ b/testcases/kernel/mem/ksm/ksm03.c
@@ -79,13 +79,13 @@ static struct tst_test test = {
 	},
 	.setup = setup,
 	.save_restore = (const struct tst_path_val[]) {
-		{"/sys/kernel/mm/ksm/run", NULL, TST_SR_TBROK},
-		{"/sys/kernel/mm/ksm/sleep_millisecs", NULL, TST_SR_TBROK},
-		{"/sys/kernel/mm/ksm/max_page_sharing", NULL,
+		{PATH_MM_KSM_RUN, NULL, TST_SR_TBROK},
+		{PATH_MM_KSM_SLEEP_MILLISECS, NULL, TST_SR_TBROK},
+		{PATH_MM_KSM_MAX_PAGE_SHARING, NULL,
 			TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},
-		{"/sys/kernel/mm/ksm/merge_across_nodes", "1",
+		{PATH_MM_KSM_MERGE_ACROSS_NODES, "1",
 			TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},
-		{"/sys/kernel/mm/ksm/smart_scan", "0",
+		{PATH_MM_KSM_SMART_SCAN, "0",
 			TST_SR_SKIP_MISSING | TST_SR_TBROK_RO},
 		{}
 	},
diff --git a/testcases/kernel/mem/ksm/ksm04.c b/testcases/kernel/mem/ksm/ksm04.c
index a9a06be40..0b08c6c60 100644
--- a/testcases/kernel/mem/ksm/ksm04.c
+++ b/testcases/kernel/mem/ksm/ksm04.c
@@ -86,13 +86,13 @@ static struct tst_test test = {
 	},
 	.setup = setup,
 	.save_restore = (const struct tst_path_val[]) {
-		{"/sys/kernel/mm/ksm/run", NULL, TST_SR_TBROK},
-		{"/sys/kernel/mm/ksm/sleep_millisecs", NULL, TST_SR_TBROK},
-		{"/sys/kernel/mm/ksm/max_page_sharing", NULL,
+		{PATH_MM_KSM_RUN, NULL, TST_SR_TBROK},
+		{PATH_MM_KSM_SLEEP_MILLISECS, NULL, TST_SR_TBROK},
+		{PATH_MM_KSM_MAX_PAGE_SHARING, NULL,
 			TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},
-		{"/sys/kernel/mm/ksm/merge_across_nodes", "1",
+		{PATH_MM_KSM_MERGE_ACROSS_NODES, "1",
 			TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},
-		{"/sys/kernel/mm/ksm/smart_scan", "0",
+		{PATH_MM_KSM_SMART_SCAN, "0",
 			TST_SR_SKIP_MISSING | TST_SR_TBROK_RO},
 		{}
 	},
diff --git a/testcases/kernel/mem/ksm/ksm05.c b/testcases/kernel/mem/ksm/ksm05.c
index 96ffad511..35197914e 100644
--- a/testcases/kernel/mem/ksm/ksm05.c
+++ b/testcases/kernel/mem/ksm/ksm05.c
@@ -93,8 +93,8 @@ static struct tst_test test = {
 	.forks_child = 1,
 	.test_all = test_ksm,
 	.save_restore = (const struct tst_path_val[]) {
-		{"/sys/kernel/mm/ksm/run", "1", TST_SR_TBROK},
-		{"/sys/kernel/mm/ksm/smart_scan", "0",
+		{PATH_MM_KSM_RUN, "1", TST_SR_TBROK},
+		{PATH_MM_KSM_SMART_SCAN, "0",
 			TST_SR_SKIP_MISSING | TST_SR_TBROK_RO},
 		{}
 	},
diff --git a/testcases/kernel/mem/ksm/ksm06.c b/testcases/kernel/mem/ksm/ksm06.c
index 22371ea53..551bbb9d5 100644
--- a/testcases/kernel/mem/ksm/ksm06.c
+++ b/testcases/kernel/mem/ksm/ksm06.c
@@ -78,8 +78,8 @@ static void test_ksm(void)
 
 	numa_free_nodemask(bm);
 
-	SAFE_FILE_PRINTF(PATH_KSM "sleep_millisecs", "0");
-	SAFE_FILE_PRINTF(PATH_KSM "pages_to_scan", "%ld",
+	SAFE_FILE_PRINTF(PATH_MM_KSM_SLEEP_MILLISECS, "0");
+	SAFE_FILE_PRINTF(PATH_MM_KSM_PAGES_TO_SCAN, "%ld",
 			 nr_pages * nodes->cnt);
 	/*
 	 * merge_across_nodes and max_page_sharing setting can be changed
@@ -87,24 +87,24 @@ static void test_ksm(void)
 	 * to unmerge pages first, then to 1 after changing merge_across_nodes,
 	 * to remerge according to the new setting.
 	 */
-	SAFE_FILE_PRINTF(PATH_KSM "run", "2");
-	if (access(PATH_KSM "max_page_sharing", F_OK) == 0)
-		SAFE_FILE_PRINTF(PATH_KSM "max_page_sharing",
+	SAFE_FILE_PRINTF(PATH_MM_KSM_RUN, "2");
+	if (access(PATH_MM_KSM_MAX_PAGE_SHARING, F_OK) == 0)
+		SAFE_FILE_PRINTF(PATH_MM_KSM_MAX_PAGE_SHARING,
 			"%ld", nr_pages * nodes->cnt);
 	tst_res(TINFO, "Start to test KSM with merge_across_nodes=1");
-	SAFE_FILE_PRINTF(PATH_KSM "merge_across_nodes", "1");
-	SAFE_FILE_PRINTF(PATH_KSM "run", "1");
+	SAFE_FILE_PRINTF(PATH_MM_KSM_MERGE_ACROSS_NODES, "1");
+	SAFE_FILE_PRINTF(PATH_MM_KSM_RUN, "1");
 	ksm_group_check(1, 1, nr_pages * nodes->cnt - 1, 0, 0, 0,
 			nr_pages * nodes->cnt);
 
-	SAFE_FILE_PRINTF(PATH_KSM "run", "2");
+	SAFE_FILE_PRINTF(PATH_MM_KSM_RUN, "2");
 	tst_res(TINFO, "Start to test KSM with merge_across_nodes=0");
-	SAFE_FILE_PRINTF(PATH_KSM "merge_across_nodes", "0");
-	SAFE_FILE_PRINTF(PATH_KSM "run", "1");
+	SAFE_FILE_PRINTF(PATH_MM_KSM_MERGE_ACROSS_NODES, "0");
+	SAFE_FILE_PRINTF(PATH_MM_KSM_RUN, "1");
 	ksm_group_check(1, nodes->cnt, nr_pages * nodes->cnt - nodes->cnt,
 			0, 0, 0, nr_pages * nodes->cnt);
 
-	SAFE_FILE_PRINTF(PATH_KSM "run", "2");
+	SAFE_FILE_PRINTF(PATH_MM_KSM_RUN, "2");
 
 	for (i = 0; i < nodes->cnt; i++)
 		SAFE_MUNMAP(memory[i], length);
@@ -132,12 +132,12 @@ static struct tst_test test = {
 	},
 	.setup = setup,
 	.save_restore = (const struct tst_path_val[]) {
-		{"/sys/kernel/mm/ksm/max_page_sharing", NULL,
+		{PATH_MM_KSM_MAX_PAGE_SHARING, NULL,
 			TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},
-		{"/sys/kernel/mm/ksm/run", NULL, TST_SR_TBROK},
-		{"/sys/kernel/mm/ksm/sleep_millisecs", NULL, TST_SR_TBROK},
-		{"/sys/kernel/mm/ksm/merge_across_nodes", NULL, TST_SR_TCONF},
-		{"/sys/kernel/mm/ksm/smart_scan", "0",
+		{PATH_MM_KSM_RUN, NULL, TST_SR_TBROK},
+		{PATH_MM_KSM_SLEEP_MILLISECS, NULL, TST_SR_TBROK},
+		{PATH_MM_KSM_MERGE_ACROSS_NODES, NULL, TST_SR_TCONF},
+		{PATH_MM_KSM_SMART_SCAN, "0",
 			TST_SR_SKIP_MISSING | TST_SR_TBROK_RO},
 		{}
 	},
diff --git a/testcases/kernel/mem/ksm/ksm07.c b/testcases/kernel/mem/ksm/ksm07.c
index 6b97b4591..161544b96 100644
--- a/testcases/kernel/mem/ksm/ksm07.c
+++ b/testcases/kernel/mem/ksm/ksm07.c
@@ -57,24 +57,24 @@ static void verify_ksm(void)
 
 	tst_res(TINFO, "KSM merging");
 
-	if (access(PATH_KSM "max_page_sharing", F_OK) == 0)
-		SAFE_FILE_PRINTF(PATH_KSM "run", "2");
+	if (access(PATH_MM_KSM_MAX_PAGE_SHARING, F_OK) == 0)
+		SAFE_FILE_PRINTF(PATH_MM_KSM_RUN, "2");
 
 	/* Set defalut ksm scan values. */
-	SAFE_FILE_PRINTF(PATH_KSM "run", "1");
-	SAFE_FILE_PRINTF(PATH_KSM "pages_to_scan", "%ld", 100l);
-	SAFE_FILE_PRINTF(PATH_KSM "sleep_millisecs", "0");
+	SAFE_FILE_PRINTF(PATH_MM_KSM_RUN, "1");
+	SAFE_FILE_PRINTF(PATH_MM_KSM_PAGES_TO_SCAN, "%ld", 100l);
+	SAFE_FILE_PRINTF(PATH_MM_KSM_SLEEP_MILLISECS, "0");
 
 	/* Measure pages skipped aka "smart scan". */
-	SAFE_FILE_SCANF(PATH_KSM "full_scans", "%d", &full_scans_begin);
-	SAFE_FILE_SCANF(PATH_KSM "pages_skipped", "%d", &pages_skipped_begin);
+	SAFE_FILE_SCANF(PATH_MM_KSM_FULL_SCANS, "%d", &full_scans_begin);
+	SAFE_FILE_SCANF(PATH_MM_KSM_PAGES_SKIPPED, "%d", &pages_skipped_begin);
 	wait_ksmd_full_scan();
 
 	tst_res(TINFO, "stop KSM");
-	SAFE_FILE_PRINTF(PATH_KSM "run", "0");
+	SAFE_FILE_PRINTF(PATH_MM_KSM_RUN, "0");
 
-	SAFE_FILE_SCANF(PATH_KSM "full_scans", "%d", &full_scans_end);
-	SAFE_FILE_SCANF(PATH_KSM "pages_skipped", "%d", &pages_skipped_end);
+	SAFE_FILE_SCANF(PATH_MM_KSM_FULL_SCANS, "%d", &full_scans_end);
+	SAFE_FILE_SCANF(PATH_MM_KSM_PAGES_SKIPPED, "%d", &pages_skipped_end);
 	diff_pages = pages_skipped_end - pages_skipped_begin;
 	diff_scans = full_scans_end - full_scans_begin;
 
@@ -98,10 +98,10 @@ static struct tst_test test = {
 		{}
 	},
 	.save_restore = (const struct tst_path_val[]) {
-		{PATH_KSM "pages_skipped", NULL, TST_SR_TCONF},
-		{PATH_KSM "run", NULL, TST_SR_TCONF},
-		{PATH_KSM "sleep_millisecs", NULL, TST_SR_TCONF},
-		{PATH_KSM "smart_scan", "1",
+		{PATH_MM_KSM_PAGES_SKIPPED, NULL, TST_SR_TCONF},
+		{PATH_MM_KSM_RUN, NULL, TST_SR_TCONF},
+		{PATH_MM_KSM_SLEEP_MILLISECS, NULL, TST_SR_TCONF},
+		{PATH_MM_KSM_SMART_SCAN, "1",
 			TST_SR_SKIP_MISSING | TST_SR_TCONF},
 		{}
 	},
diff --git a/testcases/kernel/mem/ksm/ksm_test.h b/testcases/kernel/mem/ksm/ksm_test.h
index cbad147d4..d04aa8e2b 100644
--- a/testcases/kernel/mem/ksm/ksm_test.h
+++ b/testcases/kernel/mem/ksm/ksm_test.h
@@ -13,7 +13,7 @@ static inline void check(char *path, long int value)
 	char fullpath[BUFSIZ];
 	long actual_val;
 
-	snprintf(fullpath, BUFSIZ, PATH_KSM "%s", path);
+	snprintf(fullpath, BUFSIZ, PATH_MM_KSM "%s", path);
 	SAFE_FILE_SCANF(fullpath, "%ld", &actual_val);
 
 	if (actual_val != value)
@@ -41,8 +41,8 @@ static inline void final_group_check(int run, int pages_shared, int pages_sharin
 	 * can lead to unexpected false positives where page_volatile
 	 * is elevated and page_unshared is recessed.
 	 */
-	SAFE_FILE_SCANF(PATH_KSM "run", "%d", &ksm_run_orig);
-	SAFE_FILE_PRINTF(PATH_KSM "run", "0");
+	SAFE_FILE_SCANF(PATH_MM_KSM_RUN, "%d", &ksm_run_orig);
+	SAFE_FILE_PRINTF(PATH_MM_KSM_RUN, "0");
 
 	check("pages_shared", pages_shared);
 	check("pages_sharing", pages_sharing);
@@ -51,7 +51,7 @@ static inline void final_group_check(int run, int pages_shared, int pages_sharin
 	check("sleep_millisecs", sleep_millisecs);
 	check("pages_to_scan", pages_to_scan);
 
-	SAFE_FILE_PRINTF(PATH_KSM "run", "%d", ksm_run_orig);
+	SAFE_FILE_PRINTF(PATH_MM_KSM_RUN, "%d", ksm_run_orig);
 }
 
 static inline void ksm_group_check(int run, int pages_shared, int pages_sharing,
@@ -251,14 +251,14 @@ static inline void create_same_memory(unsigned int size, int num, unsigned int u
 	stop_ksm_children(child, num);
 
 	tst_res(TINFO, "KSM merging...");
-	if (access(PATH_KSM "max_page_sharing", F_OK) == 0) {
-		SAFE_FILE_PRINTF(PATH_KSM "run", "2");
-		SAFE_FILE_PRINTF(PATH_KSM "max_page_sharing", "%ld", size * pages * num);
+	if (access(PATH_MM_KSM_MAX_PAGE_SHARING, F_OK) == 0) {
+		SAFE_FILE_PRINTF(PATH_MM_KSM_RUN, "2");
+		SAFE_FILE_PRINTF(PATH_MM_KSM_MAX_PAGE_SHARING, "%ld", size * pages * num);
 	}
 
-	SAFE_FILE_PRINTF(PATH_KSM "run", "1");
-	SAFE_FILE_PRINTF(PATH_KSM "pages_to_scan", "%ld", size * pages * num);
-	SAFE_FILE_PRINTF(PATH_KSM "sleep_millisecs", "0");
+	SAFE_FILE_PRINTF(PATH_MM_KSM_RUN, "1");
+	SAFE_FILE_PRINTF(PATH_MM_KSM_PAGES_TO_SCAN, "%ld", size * pages * num);
+	SAFE_FILE_PRINTF(PATH_MM_KSM_SLEEP_MILLISECS, "0");
 
 	resume_ksm_children(child, num);
 	stop_ksm_children(child, num);
@@ -277,13 +277,13 @@ static inline void create_same_memory(unsigned int size, int num, unsigned int u
 	ksm_group_check(1, 1, size * num * pages - 2, 0, 1, 0, size * pages * num);
 
 	tst_res(TINFO, "KSM unmerging...");
-	SAFE_FILE_PRINTF(PATH_KSM "run", "2");
+	SAFE_FILE_PRINTF(PATH_MM_KSM_RUN, "2");
 
 	resume_ksm_children(child, num);
 	final_group_check(2, 0, 0, 0, 0, 0, size * pages * num);
 
 	tst_res(TINFO, "stop KSM.");
-	SAFE_FILE_PRINTF(PATH_KSM "run", "0");
+	SAFE_FILE_PRINTF(PATH_MM_KSM_RUN, "0");
 	final_group_check(0, 0, 0, 0, 0, 0, size * pages * num);
 
 	while (waitpid(-1, &status, 0) > 0)
diff --git a/testcases/kernel/mem/oom/oom.h b/testcases/kernel/mem/oom/oom.h
index 42ed181b0..0c01e9426 100644
--- a/testcases/kernel/mem/oom/oom.h
+++ b/testcases/kernel/mem/oom/oom.h
@@ -7,11 +7,10 @@
 #define OOM_H_
 
 #include <pthread.h>
+#include "tst_path_defs.h"
 #include "config.h"
 #include "numa_helper.h"
 
-#define PATH_KSM        "/sys/kernel/mm/ksm/"
-
 #define LENGTH			(3UL<<30)
 #define NORMAL			1
 #define MLOCK			2
@@ -217,15 +216,15 @@ static inline void testoom(int mempolicy, int lite, int retcode, int allow_sigki
 	 * Skip oom(KSM) if lite == 1, since limit_in_bytes may vary from
 	 * run to run, which isn't reliable for oom03 cgroup test.
 	 */
-	if (access(PATH_KSM, F_OK) == -1 || lite == 1) {
+	if (access(PATH_MM_KSM, F_OK) == -1 || lite == 1) {
 		tst_res(TINFO, "KSM is not configed or lite == 1, "
 			 "skip OOM test for KSM pags");
 	} else {
 		tst_res(TINFO, "start OOM testing for KSM pages.");
-		SAFE_FILE_SCANF(PATH_KSM "run", "%d", &ksm_run_orig);
-		SAFE_FILE_PRINTF(PATH_KSM "run", "1");
+		SAFE_FILE_SCANF(PATH_MM_KSM_RUN, "%d", &ksm_run_orig);
+		SAFE_FILE_PRINTF(PATH_MM_KSM_RUN, "1");
 		oom(KSM, lite, retcode, allow_sigkill);
-		SAFE_FILE_PRINTF(PATH_KSM "run", "%d", ksm_run_orig);
+		SAFE_FILE_PRINTF(PATH_MM_KSM_RUN, "%d", ksm_run_orig);
 	}
 }
 
diff --git a/testcases/kernel/mem/oom/oom01.c b/testcases/kernel/mem/oom/oom01.c
index 48fe85849..ebf604ab6 100644
--- a/testcases/kernel/mem/oom/oom01.c
+++ b/testcases/kernel/mem/oom/oom01.c
@@ -17,20 +17,18 @@
 #include "tst_test.h"
 #include "oom.h"
 
-#define OVERCOMMIT_MEMORY "/proc/sys/vm/overcommit_memory"
-
 static void verify_oom(void)
 {
 	/* we expect mmap to fail before OOM is hit */
-	TST_SYS_CONF_LONG_SET(OVERCOMMIT_MEMORY, 2, 1);
+	TST_SYS_CONF_LONG_SET(PATH_VM_OVERCOMMIT_MEMORY, 2, 1);
 	oom(NORMAL, 0, ENOMEM, 0);
 
 	/* with overcommit_memory set to 0 or 1 there's no
 	 * guarantee that mmap fails before OOM */
-	TST_SYS_CONF_LONG_SET(OVERCOMMIT_MEMORY, 0, 1);
+	TST_SYS_CONF_LONG_SET(PATH_VM_OVERCOMMIT_MEMORY, 0, 1);
 	oom(NORMAL, 0, ENOMEM, 1);
 
-	TST_SYS_CONF_LONG_SET(OVERCOMMIT_MEMORY, 1, 1);
+	TST_SYS_CONF_LONG_SET(PATH_VM_OVERCOMMIT_MEMORY, 1, 1);
 	testoom(0, 0, ENOMEM, 1);
 }
 
@@ -41,7 +39,7 @@ static struct tst_test test = {
 	.test_all = verify_oom,
 	.skip_in_compat = 1,
 	.save_restore = (const struct tst_path_val[]) {
-		{OVERCOMMIT_MEMORY, NULL, TST_SR_TBROK},
+		{PATH_VM_OVERCOMMIT_MEMORY, NULL, TST_SR_TBROK},
 		{}
 	},
 };
diff --git a/testcases/kernel/mem/oom/oom02.c b/testcases/kernel/mem/oom/oom02.c
index 01a405ec1..cec51b3c3 100644
--- a/testcases/kernel/mem/oom/oom02.c
+++ b/testcases/kernel/mem/oom/oom02.c
@@ -49,7 +49,7 @@ static struct tst_test test = {
 	.test_all = verify_oom,
 	.skip_in_compat = 1,
 	.save_restore = (const struct tst_path_val[]) {
-		{"/proc/sys/vm/overcommit_memory", "1", TST_SR_TBROK},
+		{PATH_VM_OVERCOMMIT_MEMORY, "1", TST_SR_TBROK},
 		{}
 	},
 };
diff --git a/testcases/kernel/mem/oom/oom03.c b/testcases/kernel/mem/oom/oom03.c
index f218b8130..6cede83ce 100644
--- a/testcases/kernel/mem/oom/oom03.c
+++ b/testcases/kernel/mem/oom/oom03.c
@@ -76,7 +76,7 @@ static struct tst_test test = {
 	.needs_cgroup_ctrls = (const char *const []){ "memory", NULL },
 	.skip_in_compat = 1,
 	.save_restore = (const struct tst_path_val[]) {
-		{"/proc/sys/vm/overcommit_memory", "1", TST_SR_TBROK},
+		{PATH_VM_OVERCOMMIT_MEMORY, "1", TST_SR_TBROK},
 		{}
 	},
 };
diff --git a/testcases/kernel/mem/oom/oom04.c b/testcases/kernel/mem/oom/oom04.c
index d4beb12c7..b879e68a3 100644
--- a/testcases/kernel/mem/oom/oom04.c
+++ b/testcases/kernel/mem/oom/oom04.c
@@ -72,7 +72,7 @@ static struct tst_test test = {
 	.needs_cgroup_ctrls = (const char *const []){ "cpuset", NULL },
 	.skip_in_compat = 1,
 	.save_restore = (const struct tst_path_val[]) {
-		{"/proc/sys/vm/overcommit_memory", "1", TST_SR_TBROK},
+		{PATH_VM_OVERCOMMIT_MEMORY, "1", TST_SR_TBROK},
 		{}
 	},
 };
diff --git a/testcases/kernel/mem/oom/oom05.c b/testcases/kernel/mem/oom/oom05.c
index 6b8d436d1..998bd866d 100644
--- a/testcases/kernel/mem/oom/oom05.c
+++ b/testcases/kernel/mem/oom/oom05.c
@@ -95,7 +95,7 @@ static struct tst_test test = {
 	},
 	.skip_in_compat = 1,
 	.save_restore = (const struct tst_path_val[]) {
-		{"/proc/sys/vm/overcommit_memory", "1", TST_SR_TBROK},
+		{PATH_VM_OVERCOMMIT_MEMORY, "1", TST_SR_TBROK},
 		{}
 	},
 };
diff --git a/testcases/kernel/mem/thp/thp.h b/testcases/kernel/mem/thp/thp.h
index 7723bedc2..fe986ec25 100644
--- a/testcases/kernel/mem/thp/thp.h
+++ b/testcases/kernel/mem/thp/thp.h
@@ -6,11 +6,11 @@
 #ifndef THP_H
 #define THP_H
 
-#define PATH_THP "/sys/kernel/mm/transparent_hugepage/"
+#include "tst_path_defs.h"
 
 static inline void check_hugepage(void)
 {
-        if (access(PATH_HUGEPAGES, F_OK))
+        if (access(PATH_MM_HUGEPAGES, F_OK))
                 tst_brk(TCONF, "Huge page is not supported.");
 }
 
diff --git a/testcases/kernel/mem/thp/thp02.c b/testcases/kernel/mem/thp/thp02.c
index 4bfe37a20..89b49848c 100644
--- a/testcases/kernel/mem/thp/thp02.c
+++ b/testcases/kernel/mem/thp/thp02.c
@@ -97,7 +97,7 @@ static void setup(void)
 {
 	long memfree;
 
-	if (access(PATH_THP, F_OK) == -1)
+	if (access(PATH_MM_THP, F_OK) == -1)
 		tst_brk(TCONF, "THP not enabled in kernel?");
 
 	check_hugepage();
diff --git a/testcases/kernel/mem/thp/thp03.c b/testcases/kernel/mem/thp/thp03.c
index e8d22669e..8cd8e5f9c 100644
--- a/testcases/kernel/mem/thp/thp03.c
+++ b/testcases/kernel/mem/thp/thp03.c
@@ -79,7 +79,7 @@ static void thp_test(void)
 
 static void setup(void)
 {
-	if (access(PATH_THP, F_OK) == -1)
+	if (access(PATH_MM_THP, F_OK) == -1)
 		tst_brk(TCONF, "THP not enabled in kernel?");
 
 	check_hugepage();
diff --git a/testcases/kernel/mem/tunable/min_free_kbytes.c b/testcases/kernel/mem/tunable/min_free_kbytes.c
index 7882c6072..bdc9126c2 100644
--- a/testcases/kernel/mem/tunable/min_free_kbytes.c
+++ b/testcases/kernel/mem/tunable/min_free_kbytes.c
@@ -35,10 +35,6 @@
 
 #define MAP_SIZE (1UL<<20)
 
-#define OVERCOMMIT_MEMORY "/proc/sys/vm/overcommit_memory"
-#define MIN_FREE_KBYTES "/proc/sys/vm/min_free_kbytes"
-#define PANIC_ON_OOM "/proc/sys/vm/panic_on_oom"
-
 volatile int end;
 static long default_tune = -1;
 static unsigned long total_mem;
@@ -86,13 +82,13 @@ static void test_tune(unsigned long overcommit_policy)
 	int ret, i;
 	unsigned long tune, memfree, memtotal;
 
-	TST_SYS_CONF_LONG_SET(OVERCOMMIT_MEMORY, overcommit_policy, 1);
+	TST_SYS_CONF_LONG_SET(PATH_VM_OVERCOMMIT_MEMORY, overcommit_policy, 1);
 
 	for (i = 0; i < 3; i++) {
 		if (i == 0)
-			TST_SYS_CONF_LONG_SET(MIN_FREE_KBYTES, default_tune, 1);
+			TST_SYS_CONF_LONG_SET(PATH_VM_MIN_FREE_KBYTES, default_tune, 1);
 		else if (i == 1) {
-			TST_SYS_CONF_LONG_SET(MIN_FREE_KBYTES, 2 * default_tune, 1);
+			TST_SYS_CONF_LONG_SET(PATH_VM_MIN_FREE_KBYTES, 2 * default_tune, 1);
 		} else {
 			memfree = SAFE_READ_MEMINFO("MemFree:");
 			memtotal = SAFE_READ_MEMINFO("MemTotal:");
@@ -100,7 +96,7 @@ static void test_tune(unsigned long overcommit_policy)
 			if (tune > (memtotal / 50))
 				tune = memtotal / 50;
 
-			TST_SYS_CONF_LONG_SET(MIN_FREE_KBYTES, tune, 1);
+			TST_SYS_CONF_LONG_SET(PATH_VM_MIN_FREE_KBYTES, tune, 1);
 		}
 
 		fflush(stdout);
@@ -182,7 +178,7 @@ static void check_monitor(void)
 
 	while (!end) {
 		memfree = SAFE_READ_MEMINFO("MemFree:");
-		tune = TST_SYS_CONF_LONG_GET(MIN_FREE_KBYTES);
+		tune = TST_SYS_CONF_LONG_GET(PATH_VM_MIN_FREE_KBYTES);
 
 		if (memfree < tune) {
 			tst_res(TINFO, "MemFree is %lu kB, "
@@ -201,14 +197,14 @@ static void sighandler(int signo LTP_ATTRIBUTE_UNUSED)
 
 static void setup(void)
 {
-	if (TST_SYS_CONF_LONG_GET(PANIC_ON_OOM)) {
+	if (TST_SYS_CONF_LONG_GET(PATH_VM_PANIC_ON_OOM)) {
 		tst_brk(TCONF,
 			"panic_on_oom is set, disable it to run these testcases");
 	}
 
 	total_mem = SAFE_READ_MEMINFO("MemTotal:") + SAFE_READ_MEMINFO("SwapTotal:");
 
-	default_tune = TST_SYS_CONF_LONG_GET(MIN_FREE_KBYTES);
+	default_tune = TST_SYS_CONF_LONG_GET(PATH_VM_MIN_FREE_KBYTES);
 }
 
 static struct tst_test test = {
@@ -218,8 +214,8 @@ static struct tst_test test = {
 	.setup = setup,
 	.test_all = min_free_kbytes_test,
 	.save_restore = (const struct tst_path_val[]) {
-		{OVERCOMMIT_MEMORY, NULL, TST_SR_TBROK},
-		{MIN_FREE_KBYTES, NULL, TST_SR_TBROK},
+		{PATH_VM_OVERCOMMIT_MEMORY, NULL, TST_SR_TBROK},
+		{PATH_VM_MIN_FREE_KBYTES, NULL, TST_SR_TBROK},
 		{}
 	},
 };
diff --git a/testcases/kernel/mem/tunable/overcommit_memory.c b/testcases/kernel/mem/tunable/overcommit_memory.c
index 663e31522..9fa50818f 100644
--- a/testcases/kernel/mem/tunable/overcommit_memory.c
+++ b/testcases/kernel/mem/tunable/overcommit_memory.c
@@ -82,9 +82,6 @@
 #define EXPECT_PASS		0
 #define EXPECT_FAIL		1
 
-#define OVERCOMMIT_MEMORY "/proc/sys/vm/overcommit_memory"
-#define OVERCOMMIT_RATIO "/proc/sys/vm/overcommit_ratio"
-
 static char *R_opt;
 static long old_overcommit_ratio = -1;
 static long overcommit_ratio;
@@ -110,7 +107,7 @@ static void setup(void)
 	else
 		overcommit_ratio = DEFAULT_OVER_RATIO;
 
-	old_overcommit_ratio = TST_SYS_CONF_LONG_GET(OVERCOMMIT_RATIO);
+	old_overcommit_ratio = TST_SYS_CONF_LONG_GET(PATH_VM_OVERCOMMIT_RATIO);
 
 	mem_total = SAFE_READ_MEMINFO("MemTotal:");
 	tst_res(TINFO, "MemTotal is %ld kB", mem_total);
@@ -132,7 +129,7 @@ static void setup(void)
 		SAFE_SETRLIMIT(RLIMIT_AS, &lim);
 	}
 
-	TST_SYS_CONF_LONG_SET(OVERCOMMIT_RATIO, overcommit_ratio, 1);
+	TST_SYS_CONF_LONG_SET(PATH_VM_OVERCOMMIT_RATIO, overcommit_ratio, 1);
 
 	calculate_total_batch_size();
 	tst_res(TINFO, "TotalBatchSize is %ld kB", total_batch_size);
@@ -141,7 +138,7 @@ static void setup(void)
 static void overcommit_memory_test(void)
 {
 	/* start to test overcommit_memory=2 */
-	TST_SYS_CONF_LONG_SET(OVERCOMMIT_MEMORY, 2, 1);
+	TST_SYS_CONF_LONG_SET(PATH_VM_OVERCOMMIT_MEMORY, 2, 1);
 
 	update_mem_commit();
 	/* Skip tests that would overflow or exceed 32-bit address space */
@@ -155,7 +152,7 @@ static void overcommit_memory_test(void)
 	}
 
 	/* start to test overcommit_memory=0 */
-	TST_SYS_CONF_LONG_SET(OVERCOMMIT_MEMORY, 0, 1);
+	TST_SYS_CONF_LONG_SET(PATH_VM_OVERCOMMIT_MEMORY, 0, 1);
 
 	update_mem();
 	alloc_and_check(free_total / 2, EXPECT_PASS);
@@ -170,7 +167,7 @@ static void overcommit_memory_test(void)
 	}
 
 	/* start to test overcommit_memory=1 */
-	TST_SYS_CONF_LONG_SET(OVERCOMMIT_MEMORY, 1, 1);
+	TST_SYS_CONF_LONG_SET(PATH_VM_OVERCOMMIT_MEMORY, 1, 1);
 
 	alloc_and_check(sum_total / 2, EXPECT_PASS);
 	if (tst_kernel_bits() == 64 || (unsigned long)sum_total <= TST_GB / TST_KB) {
@@ -287,8 +284,8 @@ static struct tst_test test = {
 	.test_all = overcommit_memory_test,
 	.skip_in_compat = 1,
 	.save_restore = (const struct tst_path_val[]) {
-		{OVERCOMMIT_MEMORY, NULL, TST_SR_TBROK},
-		{OVERCOMMIT_RATIO, NULL, TST_SR_TBROK},
+		{PATH_VM_OVERCOMMIT_MEMORY, NULL, TST_SR_TBROK},
+		{PATH_VM_OVERCOMMIT_RATIO, NULL, TST_SR_TBROK},
 		{}
 	},
 };
diff --git a/testcases/kernel/sched/sysctl/proc_sched_rt01.c b/testcases/kernel/sched/sysctl/proc_sched_rt01.c
index df57ebcde..70b2927f7 100644
--- a/testcases/kernel/sched/sysctl/proc_sched_rt01.c
+++ b/testcases/kernel/sched/sysctl/proc_sched_rt01.c
@@ -26,10 +26,6 @@
 #include <stdio.h>
 #include "tst_test.h"
 
-#define RT_PERIOD_US "/proc/sys/kernel/sched_rt_period_us"
-#define RT_RUNTIME_US "/proc/sys/kernel/sched_rt_runtime_us"
-#define RR_TIMESLICE_MS "/proc/sys/kernel/sched_rr_timeslice_ms"
-
 static int period_fd;
 static int runtime_fd;
 
@@ -37,8 +33,8 @@ static void rr_timeslice_ms_reset(void)
 {
 	long timeslice_ms;
 
-	SAFE_FILE_PRINTF(RR_TIMESLICE_MS, "-1");
-	SAFE_FILE_SCANF(RR_TIMESLICE_MS, "%li", &timeslice_ms);
+	SAFE_FILE_PRINTF(PATH_KERN_SCHED_RR_TIMESLICE_MS, "-1");
+	SAFE_FILE_SCANF(PATH_KERN_SCHED_RR_TIMESLICE_MS, "%li", &timeslice_ms);
 
 	TST_EXP_EXPR(timeslice_ms > 0,
 		"timeslice_ms > 0 after reset to default");
@@ -47,15 +43,15 @@ static void rr_timeslice_ms_reset(void)
 static void rt_period_us_einval(void)
 {
 	TST_EXP_FAIL(write(period_fd, "0", 2), EINVAL,
-		"echo 0 > "RT_PERIOD_US);
+		"echo 0 > "PATH_KERN_SCHED_RT_PERIOD_US);
 	TST_EXP_FAIL(write(period_fd, "-1", 2), EINVAL,
-		"echo -1 > "RT_PERIOD_US);
+		"echo -1 > "PATH_KERN_SCHED_RT_PERIOD_US);
 }
 
 static void rt_runtime_us_einval(void)
 {
 	TST_EXP_FAIL(write(runtime_fd, "-2", 2), EINVAL,
-		"echo -2 > "RT_RUNTIME_US);
+		"echo -2 > "PATH_KERN_SCHED_RT_RUNTIME_US);
 }
 
 static void rt_runtime_us_le_period_us(void)
@@ -63,12 +59,12 @@ static void rt_runtime_us_le_period_us(void)
 	int period_us;
 	char buf[32];
 
-	SAFE_FILE_SCANF(RT_PERIOD_US, "%i", &period_us);
+	SAFE_FILE_SCANF(PATH_KERN_SCHED_RT_PERIOD_US, "%i", &period_us);
 
 	sprintf(buf, "%i", period_us+1);
 
 	TST_EXP_FAIL(write(runtime_fd, buf, strlen(buf)), EINVAL,
-		"echo rt_period_us+1 > "RT_RUNTIME_US);
+		"echo rt_period_us+1 > "PATH_KERN_SCHED_RT_RUNTIME_US);
 }
 
 static void verify_sched_proc(void)
@@ -81,8 +77,8 @@ static void verify_sched_proc(void)
 
 static void setup(void)
 {
-	period_fd = open(RT_PERIOD_US, O_RDWR);
-	runtime_fd = open(RT_RUNTIME_US, O_RDWR);
+	period_fd = open(PATH_KERN_SCHED_RT_PERIOD_US, O_RDWR);
+	runtime_fd = open(PATH_KERN_SCHED_RT_RUNTIME_US, O_RDWR);
 }
 
 static void cleanup(void)
diff --git a/testcases/kernel/syscalls/bind/bind06.c b/testcases/kernel/syscalls/bind/bind06.c
index 988574a80..2408fe9be 100644
--- a/testcases/kernel/syscalls/bind/bind06.c
+++ b/testcases/kernel/syscalls/bind/bind06.c
@@ -100,7 +100,7 @@ static struct tst_test test = {
 		NULL
 	},
 	.save_restore = (const struct tst_path_val[]) {
-		{"/proc/sys/user/max_user_namespaces", "1024", TST_SR_SKIP},
+		{PATH_USER_MAX_USER_NAMESPACES, "1024", TST_SR_SKIP},
 		{}
 	},
 	.tags = (const struct tst_tag[]) {
diff --git a/testcases/kernel/syscalls/fanotify/fanotify10.c b/testcases/kernel/syscalls/fanotify/fanotify10.c
index 41f13408a..c42d9247f 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify10.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify10.c
@@ -99,9 +99,6 @@ static int ignore_mark_unsupported;
 #define FILE_EXEC_PATH2 MNT2_PATH"/"TEST_APP
 #define FILE2_EXEC_PATH2 MNT2_PATH"/"TEST_APP2
 
-#define DROP_CACHES_FILE "/proc/sys/vm/drop_caches"
-#define CACHE_PRESSURE_FILE "/proc/sys/vm/vfs_cache_pressure"
-
 static pid_t child_pid;
 static int bind_mount_created;
 static unsigned int num_classes = NUM_CLASSES;
@@ -517,9 +514,9 @@ static void drop_caches(void)
 	 * In order to ensure that the inode can be released in the two-tier
 	 * directory structure, drop_cache is required three times.
 	 */
-	SAFE_FILE_PRINTF(DROP_CACHES_FILE, "3");
-	SAFE_FILE_PRINTF(DROP_CACHES_FILE, "3");
-	SAFE_FILE_PRINTF(DROP_CACHES_FILE, "3");
+	SAFE_FILE_PRINTF(PATH_VM_DROP_CACHES, "3");
+	SAFE_FILE_PRINTF(PATH_VM_DROP_CACHES, "3");
+	SAFE_FILE_PRINTF(PATH_VM_DROP_CACHES, "3");
 }
 
 static int create_fanotify_groups(unsigned int n)
@@ -925,7 +922,7 @@ static void setup(void)
 	mount_cycle();
 
 	/* Set high priority for evicting inodes */
-	SAFE_FILE_PRINTF(CACHE_PRESSURE_FILE, "500");
+	SAFE_FILE_PRINTF(PATH_VM_VFS_CACHE_PRESSURE, "500");
 }
 
 static void cleanup(void)
@@ -969,7 +966,7 @@ static struct tst_test test = {
 		NULL
 	},
 	.save_restore = (const struct tst_path_val[]) {
-		{CACHE_PRESSURE_FILE, NULL, TST_SR_TCONF},
+		{PATH_VM_VFS_CACHE_PRESSURE, NULL, TST_SR_TCONF},
 		{}
 	},
 	.tags = (const struct tst_tag[]) {
diff --git a/testcases/kernel/syscalls/fanotify/fanotify17.c b/testcases/kernel/syscalls/fanotify/fanotify17.c
index fa563a3ca..d5495d679 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify17.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify17.c
@@ -30,14 +30,9 @@
 #define MOUNT_PATH	"fs_mnt"
 #define TEST_FILE	MOUNT_PATH "/testfile"
 #define SELF_USERNS	"/proc/self/ns/user"
-#define MAX_USERNS	"/proc/sys/user/max_user_namespaces"
+#define MAX_USERNS	PATH_USER_MAX_USER_NAMESPACES
 #define UID_MAP		"/proc/self/uid_map"
 
-#define GLOBAL_MAX_GROUPS "/proc/sys/fs/fanotify/max_user_groups"
-#define GLOBAL_MAX_MARKS  "/proc/sys/fs/fanotify/max_user_marks"
-#define USERNS_MAX_GROUPS "/proc/sys/user/max_fanotify_groups"
-#define USERNS_MAX_MARKS  "/proc/sys/user/max_fanotify_marks"
-
 /*
  * In older kernels those limits were fixed in kernel.
  * The fanotify_init() man page documents the max groups limit is 128, but the
@@ -185,12 +180,12 @@ static void test_fanotify(unsigned int n)
 			if (tc->max_user_groups && tc->max_user_groups < groups) {
 				/* Further limit user ns groups */
 				marks = groups = tc->max_user_groups;
-				SAFE_FILE_PRINTF(USERNS_MAX_GROUPS, "%d", groups);
+				SAFE_FILE_PRINTF(PATH_USER_MAX_FANOTIFY_GROUPS, "%d", groups);
 			}
 			if (tc->max_user_marks && tc->max_user_marks < marks) {
 				/* Further limit user ns marks */
 				marks = tc->max_user_marks;
-				SAFE_FILE_PRINTF(USERNS_MAX_MARKS, "%d", marks);
+				SAFE_FILE_PRINTF(PATH_USER_MAX_FANOTIFY_MARKS, "%d", marks);
 			}
 		}
 		verify_user_limits(tc->init_flags, groups, marks);
@@ -230,11 +225,11 @@ static void setup(void)
 	 * In older kernels those limits were fixed in kernel and fanotify is
 	 * not permitted inside user ns.
 	 */
-	if (access(GLOBAL_MAX_GROUPS, F_OK) && errno == ENOENT) {
+	if (access(PATH_FS_MAX_USER_GROUPS, F_OK) && errno == ENOENT) {
 		user_ns_supported = 0;
 	} else {
-		SAFE_FILE_SCANF(GLOBAL_MAX_GROUPS, "%d", &max_groups);
-		SAFE_FILE_SCANF(GLOBAL_MAX_MARKS, "%d", &max_marks);
+		SAFE_FILE_SCANF(PATH_FS_MAX_USER_GROUPS, "%d", &max_groups);
+		SAFE_FILE_SCANF(PATH_FS_MAX_USER_MARKS, "%d", &max_marks);
 	}
 	tst_res(TINFO, "max_fanotify_groups=%d max_fanotify_marks=%d",
 		max_groups, max_marks);
diff --git a/testcases/kernel/syscalls/fcntl/fcntl30.c b/testcases/kernel/syscalls/fcntl/fcntl30.c
index 4d1b7e627..c803a04b0 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl30.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl30.c
@@ -34,7 +34,7 @@ static void run(void)
 
 static void setup(void)
 {
-	SAFE_FILE_SCANF("/proc/sys/fs/pipe-max-size", "%d", &max_size_unpriv);
+	SAFE_FILE_SCANF(PATH_FS_PIPE_MAX_SIZE, "%d", &max_size_unpriv);
 }
 
 static void cleanup(void)
diff --git a/testcases/kernel/syscalls/fcntl/fcntl35.c b/testcases/kernel/syscalls/fcntl/fcntl35.c
index 2d730377b..1662e5a4e 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl35.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl35.c
@@ -49,13 +49,11 @@ static void setup(void)
 	test_max_unpriv = getpagesize();
 	test_max_priv = test_max_unpriv * 16;
 
-	if (!access("/proc/sys/fs/pipe-max-size", F_OK)) {
-		SAFE_FILE_SCANF("/proc/sys/fs/pipe-max-size", "%d",
-				&pipe_max_unpriv);
-		SAFE_FILE_PRINTF("/proc/sys/fs/pipe-max-size", "%d",
-				test_max_unpriv);
+	if (!access(PATH_FS_PIPE_MAX_SIZE, F_OK)) {
+		SAFE_FILE_SCANF(PATH_FS_PIPE_MAX_SIZE, "%d", &pipe_max_unpriv);
+		SAFE_FILE_PRINTF(PATH_FS_PIPE_MAX_SIZE, "%d", test_max_unpriv);
 	} else {
-		tst_brk(TCONF, "/proc/sys/fs/pipe-max-size doesn't exist");
+		tst_brk(TCONF, "%s doesn't exist", PATH_FS_PIPE_MAX_SIZE);
 	}
 
 	pw = SAFE_GETPWNAM("nobody");
@@ -63,7 +61,7 @@ static void setup(void)
 
 static void cleanup(void)
 {
-	SAFE_FILE_PRINTF("/proc/sys/fs/pipe-max-size", "%d", pipe_max_unpriv);
+	SAFE_FILE_PRINTF(PATH_FS_PIPE_MAX_SIZE, "%d", pipe_max_unpriv);
 }
 
 static int verify_pipe_size(int exp_pip_sz, char *desp)
diff --git a/testcases/kernel/syscalls/fcntl/fcntl37.c b/testcases/kernel/syscalls/fcntl/fcntl37.c
index 36f462954..ed7dbcba8 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl37.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl37.c
@@ -70,7 +70,7 @@ static void setup(void)
 	SAFE_WRITE(SAFE_WRITE_ALL, fds[1], wrbuf, orig_value);
 	free(wrbuf);
 
-	SAFE_FILE_SCANF("/proc/sys/fs/pipe-max-size", "%d", &sys_value);
+	SAFE_FILE_SCANF(PATH_FS_PIPE_MAX_SIZE, "%d", &sys_value);
 	sys_value++;
 
 	half_value = orig_value / 2;
diff --git a/testcases/kernel/syscalls/fork/fork13.c b/testcases/kernel/syscalls/fork/fork13.c
index 415e9404d..4f29beec3 100644
--- a/testcases/kernel/syscalls/fork/fork13.c
+++ b/testcases/kernel/syscalls/fork/fork13.c
@@ -111,7 +111,7 @@ static struct tst_test test = {
 	.runtime = 600,
 	.test_all = check,
 	.save_restore = (const struct tst_path_val[]) {
-		{"/proc/sys/kernel/pid_max", PID_MAX_STR, TST_SR_TBROK},
+		{PATH_KERN_PID_MAX, PID_MAX_STR, TST_SR_TBROK},
 		{}
 	},
 	.tags = (const struct tst_tag[]) {
diff --git a/testcases/kernel/syscalls/getpid/getpid01.c b/testcases/kernel/syscalls/getpid/getpid01.c
index 8fcd351d6..81c08e004 100644
--- a/testcases/kernel/syscalls/getpid/getpid01.c
+++ b/testcases/kernel/syscalls/getpid/getpid01.c
@@ -15,7 +15,7 @@ static pid_t pid_max;
 
 static void setup(void)
 {
-	SAFE_FILE_SCANF("/proc/sys/kernel/pid_max", "%d\n", &pid_max);
+	SAFE_FILE_SCANF(PATH_KERN_PID_MAX, "%d\n", &pid_max);
 }
 
 static void verify_getpid(void)
diff --git a/testcases/kernel/syscalls/getppid/getppid01.c b/testcases/kernel/syscalls/getppid/getppid01.c
index 3f05aed37..ec15b5336 100644
--- a/testcases/kernel/syscalls/getppid/getppid01.c
+++ b/testcases/kernel/syscalls/getppid/getppid01.c
@@ -15,7 +15,7 @@ static pid_t pid_max;
 
 static void setup(void)
 {
-	SAFE_FILE_SCANF("/proc/sys/kernel/pid_max", "%d\n", &pid_max);
+	SAFE_FILE_SCANF(PATH_KERN_PID_MAX, "%d\n", &pid_max);
 }
 
 static void verify_getppid(void)
diff --git a/testcases/kernel/syscalls/getxattr/getxattr05.c b/testcases/kernel/syscalls/getxattr/getxattr05.c
index 5f0aac51d..7ceec22c6 100644
--- a/testcases/kernel/syscalls/getxattr/getxattr05.c
+++ b/testcases/kernel/syscalls/getxattr/getxattr05.c
@@ -38,7 +38,6 @@
 
 #define TEST_FILE	"testfile"
 #define SELF_USERNS	"/proc/self/ns/user"
-#define MAX_USERNS	"/proc/sys/user/max_user_namespaces"
 #define UID_MAP	"/proc/self/uid_map"
 
 static acl_t acl;
@@ -152,9 +151,9 @@ static void setup(void)
 	 */
 	if (access(SELF_USERNS, F_OK) != 0) {
 		user_ns_supported = 0;
-	} else if (!access(MAX_USERNS, F_OK)) {
-		SAFE_FILE_SCANF(MAX_USERNS, "%d", &orig_max_userns);
-		SAFE_FILE_PRINTF(MAX_USERNS, "%d", 10);
+	} else if (!access(PATH_USER_MAX_USER_NAMESPACES, F_OK)) {
+		SAFE_FILE_SCANF(PATH_USER_MAX_USER_NAMESPACES, "%d", &orig_max_userns);
+		SAFE_FILE_PRINTF(PATH_USER_MAX_USER_NAMESPACES, "%d", 10);
 	}
 
 }
@@ -162,7 +161,7 @@ static void setup(void)
 static void cleanup(void)
 {
 	if (orig_max_userns != -1)
-		SAFE_FILE_PRINTF(MAX_USERNS, "%d", orig_max_userns);
+		SAFE_FILE_PRINTF(PATH_USER_MAX_USER_NAMESPACES, "%d", orig_max_userns);
 
 	if (acl)
 		acl_free(acl);
diff --git a/testcases/kernel/syscalls/inotify/inotify07.c b/testcases/kernel/syscalls/inotify/inotify07.c
index 9cadbf656..6f45e0dbf 100644
--- a/testcases/kernel/syscalls/inotify/inotify07.c
+++ b/testcases/kernel/syscalls/inotify/inotify07.c
@@ -153,7 +153,7 @@ static void setup(void)
 	tst_res(TINFO, DIR_PATH " ino=%lu", buf.st_ino);
 
 	/* Drop dentry caches, so overlayfs will allocate a new dentry */
-	SAFE_FILE_PRINTF("/proc/sys/vm/drop_caches", "2");
+	SAFE_FILE_PRINTF(PATH_VM_DROP_CACHES, "2");
 
 	/* Copy up directory to make it a merge directory */
 	SAFE_CHMOD(DIR_PATH, 0700);
diff --git a/testcases/kernel/syscalls/inotify/inotify08.c b/testcases/kernel/syscalls/inotify/inotify08.c
index 23d3c5a65..4e4b2e387 100644
--- a/testcases/kernel/syscalls/inotify/inotify08.c
+++ b/testcases/kernel/syscalls/inotify/inotify08.c
@@ -146,7 +146,7 @@ static void setup(void)
 			major(buf.st_dev), minor(buf.st_dev));
 
 	/* Drop dentry caches, so overlayfs will allocate a new dentry */
-	SAFE_FILE_PRINTF("/proc/sys/vm/drop_caches", "2");
+	SAFE_FILE_PRINTF(PATH_VM_DROP_CACHES, "2");
 
 	/* Copy up file */
 	SAFE_CHMOD(FILE_PATH, 0600);
diff --git a/testcases/kernel/syscalls/io_setup/io_setup01.c b/testcases/kernel/syscalls/io_setup/io_setup01.c
index 3536b068f..f52c95046 100644
--- a/testcases/kernel/syscalls/io_setup/io_setup01.c
+++ b/testcases/kernel/syscalls/io_setup/io_setup01.c
@@ -75,11 +75,11 @@ static void verify_io_setup(void)
 	verify_failure(-1, &ctx, 0, EINVAL);
 	verify_failure(1, NULL, 0, EFAULT);
 
-	if (!access("/proc/sys/fs/aio-max-nr", F_OK)) {
-		SAFE_FILE_SCANF("/proc/sys/fs/aio-max-nr", "%u", &aio_max);
+	if (!access(PATH_FS_NR_AIO_MAX_NR, F_OK)) {
+		SAFE_FILE_SCANF(PATH_FS_NR_AIO_MAX_NR, "%u", &aio_max);
 		verify_failure(aio_max + 1, &ctx, 0, EAGAIN);
 	} else {
-		tst_res(TCONF, "the aio-max-nr file did not exist");
+		tst_res(TCONF, "the %s file did not exist", PATH_FS_NR_AIO_MAX_NR);
 	}
 }
 
diff --git a/testcases/kernel/syscalls/io_setup/io_setup02.c b/testcases/kernel/syscalls/io_setup/io_setup02.c
index 14a89d602..805960f84 100644
--- a/testcases/kernel/syscalls/io_setup/io_setup02.c
+++ b/testcases/kernel/syscalls/io_setup/io_setup02.c
@@ -40,8 +40,8 @@ static void run(void)
 		     "io_setup() when nr_events is -1");
 
 	unsigned aio_max = 0;
-	if (!access("/proc/sys/fs/aio-max-nr", F_OK)) {
-		SAFE_FILE_SCANF("/proc/sys/fs/aio-max-nr", "%u", &aio_max);
+	if (!access(PATH_FS_NR_AIO_MAX_NR, F_OK)) {
+		SAFE_FILE_SCANF(PATH_FS_NR_AIO_MAX_NR, "%u", &aio_max);
 		TST_EXP_FAIL(tst_syscall(__NR_io_setup, aio_max + 1, &ctx), EAGAIN,
 			     "io_setup() when nr_events exceeds the limit");
 	} else {
diff --git a/testcases/kernel/syscalls/io_uring/io_uring01.c b/testcases/kernel/syscalls/io_uring/io_uring01.c
index 4c64e562b..1d2029fdf 100644
--- a/testcases/kernel/syscalls/io_uring/io_uring01.c
+++ b/testcases/kernel/syscalls/io_uring/io_uring01.c
@@ -165,7 +165,7 @@ static struct tst_test test = {
 		{}
 	},
 	.save_restore = (const struct tst_path_val[]) {
-		{"/proc/sys/kernel/io_uring_disabled", "0",
+		{PATH_KERN_IO_URING_DISABLED, "0",
 			TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},
 		{}
 	}
diff --git a/testcases/kernel/syscalls/io_uring/io_uring02.c b/testcases/kernel/syscalls/io_uring/io_uring02.c
index 50206cf1f..6d3d584dc 100644
--- a/testcases/kernel/syscalls/io_uring/io_uring02.c
+++ b/testcases/kernel/syscalls/io_uring/io_uring02.c
@@ -255,7 +255,7 @@ static struct tst_test test = {
 		{}
 	},
 	.save_restore = (const struct tst_path_val[]) {
-		{"/proc/sys/kernel/io_uring_disabled", "0",
+		{PATH_KERN_IO_URING_DISABLED, "0",
 			TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},
 		{}
 	},
diff --git a/testcases/kernel/syscalls/io_uring/io_uring03.c b/testcases/kernel/syscalls/io_uring/io_uring03.c
index 645c96b02..d3b9cff82 100644
--- a/testcases/kernel/syscalls/io_uring/io_uring03.c
+++ b/testcases/kernel/syscalls/io_uring/io_uring03.c
@@ -133,7 +133,7 @@ static struct tst_test test = {
 		{}
 	},
 	.save_restore = (const struct tst_path_val[]) {
-		{"/proc/sys/kernel/io_uring_disabled", "0",
+		{PATH_KERN_IO_URING_DISABLED, "0",
 			TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},
 		{}
 	}
diff --git a/testcases/kernel/syscalls/ipc/msgget/msgget03.c b/testcases/kernel/syscalls/ipc/msgget/msgget03.c
index f3d7579a3..ee63854f7 100644
--- a/testcases/kernel/syscalls/ipc/msgget/msgget03.c
+++ b/testcases/kernel/syscalls/ipc/msgget/msgget03.c
@@ -40,7 +40,7 @@ static void setup(void)
 		used_cnt);
 
 	maxmsgs = used_cnt + 32;
-	SAFE_FILE_PRINTF("/proc/sys/kernel/msgmni", "%i", maxmsgs);
+	SAFE_FILE_PRINTF(PATH_KERN_MSGMNI, "%i", maxmsgs);
 
 	queues = SAFE_MALLOC((maxmsgs - used_cnt) * sizeof(int));
 
@@ -74,7 +74,7 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.test_all = verify_msgget,
 	.save_restore = (const struct tst_path_val[]){
-		{"/proc/sys/kernel/msgmni", NULL, TST_SR_TCONF},
+		{PATH_KERN_MSGMNI, NULL, TST_SR_TCONF},
 		{}
 	}
 };
diff --git a/testcases/kernel/syscalls/ipc/msgget/msgget04.c b/testcases/kernel/syscalls/ipc/msgget/msgget04.c
index 7f8f2ed9e..562c7af17 100644
--- a/testcases/kernel/syscalls/ipc/msgget/msgget04.c
+++ b/testcases/kernel/syscalls/ipc/msgget/msgget04.c
@@ -22,7 +22,7 @@
 #include "tst_safe_sysv_ipc.h"
 #include "tse_newipc.h"
 
-#define NEXT_ID_PATH "/proc/sys/kernel/msg_next_id"
+#define NEXT_ID_PATH PATH_KERN_MSG_NEXT_ID
 static int queue_id, pid;
 static key_t msgkey;
 
diff --git a/testcases/kernel/syscalls/ipc/msgget/msgget05.c b/testcases/kernel/syscalls/ipc/msgget/msgget05.c
index c683142f5..0e6b97785 100644
--- a/testcases/kernel/syscalls/ipc/msgget/msgget05.c
+++ b/testcases/kernel/syscalls/ipc/msgget/msgget05.c
@@ -20,7 +20,7 @@
 #include "tst_safe_sysv_ipc.h"
 #include "tse_newipc.h"
 
-#define NEXT_ID_PATH "/proc/sys/kernel/msg_next_id"
+#define NEXT_ID_PATH PATH_KERN_MSG_NEXT_ID
 
 static int queue_id[2], pid;
 static key_t msgkey[2];
diff --git a/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c b/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c
index 10c9adcb0..696a72b10 100644
--- a/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c
+++ b/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c
@@ -22,7 +22,7 @@
 #include "tst_safe_stdio.h"
 #include "tst_test.h"
 
-#define SYSVIPC_TOTAL "/proc/sys/kernel/msgmni"
+#define SYSVIPC_TOTAL PATH_KERN_MSGMNI
 #define SYSVIPC_USED "/proc/sysvipc/msg"
 #define MSGTYPE 10
 #define MAXNREPS 100000
diff --git a/testcases/kernel/syscalls/ipc/semget/semget05.c b/testcases/kernel/syscalls/ipc/semget/semget05.c
index 57a65dbdd..7bff44eb0 100644
--- a/testcases/kernel/syscalls/ipc/semget/semget05.c
+++ b/testcases/kernel/syscalls/ipc/semget/semget05.c
@@ -38,7 +38,7 @@ static void setup(void)
 	used_cnt = GET_USED_ARRAYS();
 	tst_res(TINFO, "Current environment %d semaphore arrays are already in use",
 		used_cnt);
-	SAFE_FILE_SCANF("/proc/sys/kernel/sem", "%*d %*d %*d %d", &maxsems);
+	SAFE_FILE_SCANF(PATH_KERN_SEM, "%*d %*d %*d %d", &maxsems);
 
 	/* Prevent timeout due to high semaphore array limit */
 	tst_set_runtime(maxsems / 200);
@@ -74,7 +74,7 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.test_all = verify_semget,
 	.save_restore = (const struct tst_path_val[]){
-		{"/proc/sys/kernel/sem", NULL,
+		{PATH_KERN_SEM, NULL,
 			TST_SR_TCONF_MISSING | TST_SR_SKIP_RO},
 		{}
 	}
diff --git a/testcases/kernel/syscalls/ipc/shmctl/shmctl03.c b/testcases/kernel/syscalls/ipc/shmctl/shmctl03.c
index a1f53e7c1..9e1c2f099 100644
--- a/testcases/kernel/syscalls/ipc/shmctl/shmctl03.c
+++ b/testcases/kernel/syscalls/ipc/shmctl/shmctl03.c
@@ -30,9 +30,9 @@ static void verify_ipcinfo(void)
 	else
 		tst_res(TPASS, "shmmin = 1");
 
-	TST_ASSERT_ULONG("/proc/sys/kernel/shmmax", info.shmmax);
-	TST_ASSERT_ULONG("/proc/sys/kernel/shmmni", info.shmmni);
-	TST_ASSERT_ULONG("/proc/sys/kernel/shmall", info.shmall);
+	TST_ASSERT_ULONG(PATH_KERN_SHMMAX, info.shmmax);
+	TST_ASSERT_ULONG(PATH_KERN_SHMMNI, info.shmmni);
+	TST_ASSERT_ULONG(PATH_KERN_SHMALL, info.shmall);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/ipc/shmget/shmget02.c b/testcases/kernel/syscalls/ipc/shmget/shmget02.c
index 5c77d47d8..e7b2f90be 100644
--- a/testcases/kernel/syscalls/ipc/shmget/shmget02.c
+++ b/testcases/kernel/syscalls/ipc/shmget/shmget02.c
@@ -143,7 +143,7 @@ static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(tcases),
 	.hugepages = {TST_NO_HUGEPAGES},
 	.save_restore = (const struct tst_path_val[]) {
-		{"/proc/sys/kernel/shmmax", "8192", TST_SR_TCONF_MISSING | TST_SR_TBROK_RO},
+		{PATH_KERN_SHMMAX, "8192", TST_SR_TCONF_MISSING | TST_SR_TBROK_RO},
 		{}
 	},
 };
diff --git a/testcases/kernel/syscalls/ipc/shmget/shmget03.c b/testcases/kernel/syscalls/ipc/shmget/shmget03.c
index a54540d58..03eb1fcb7 100644
--- a/testcases/kernel/syscalls/ipc/shmget/shmget03.c
+++ b/testcases/kernel/syscalls/ipc/shmget/shmget03.c
@@ -37,7 +37,7 @@ static void setup(void)
 	used_cnt = GET_USED_SEGMENTS();
 	tst_res(TINFO, "Current environment %d shared memory segments are already in use",
 		used_cnt);
-	SAFE_FILE_SCANF("/proc/sys/kernel/shmmni", "%i", &maxshms);
+	SAFE_FILE_SCANF(PATH_KERN_SHMMNI, "%i", &maxshms);
 
 	queues = SAFE_MALLOC((maxshms - used_cnt) * sizeof(int));
 	for (num = 0; num < maxshms - used_cnt; num++) {
diff --git a/testcases/kernel/syscalls/ipc/shmget/shmget05.c b/testcases/kernel/syscalls/ipc/shmget/shmget05.c
index 246674938..a8b54dd47 100644
--- a/testcases/kernel/syscalls/ipc/shmget/shmget05.c
+++ b/testcases/kernel/syscalls/ipc/shmget/shmget05.c
@@ -23,13 +23,12 @@
 #include "tst_safe_sysv_ipc.h"
 #include "tse_newipc.h"
 
-#define NEXT_ID_PATH "/proc/sys/kernel/shm_next_id"
 static int shm_id, pid;
 static key_t shmkey;
 
 static void verify_shmget(void)
 {
-	SAFE_FILE_PRINTF(NEXT_ID_PATH, "%d", pid);
+	SAFE_FILE_PRINTF(PATH_KERN_SHM_NEXT_ID, "%d", pid);
 
 	shm_id = SAFE_SHMGET(shmkey, SHM_SIZE, SHM_RW | IPC_CREAT);
 	if (shm_id == pid)
@@ -37,7 +36,7 @@ static void verify_shmget(void)
 	else
 		tst_res(TFAIL, "shm_next_id failed, expected id %d, but got %d", pid, shm_id);
 
-	TST_ASSERT_INT(NEXT_ID_PATH, -1);
+	TST_ASSERT_INT(PATH_KERN_SHM_NEXT_ID, -1);
 	SAFE_SHMCTL(shm_id, IPC_RMID, NULL);
 	pid++;
 }
diff --git a/testcases/kernel/syscalls/ipc/shmget/shmget06.c b/testcases/kernel/syscalls/ipc/shmget/shmget06.c
index 420844f0a..8f98930ba 100644
--- a/testcases/kernel/syscalls/ipc/shmget/shmget06.c
+++ b/testcases/kernel/syscalls/ipc/shmget/shmget06.c
@@ -21,14 +21,12 @@
 #include "tst_safe_sysv_ipc.h"
 #include "tse_newipc.h"
 
-#define NEXT_ID_PATH "/proc/sys/kernel/shm_next_id"
-
 static int shm_id[2], pid;
 static key_t shmkey[2];
 
 static void verify_shmget(void)
 {
-	SAFE_FILE_PRINTF(NEXT_ID_PATH, "%d", shm_id[0]);
+	SAFE_FILE_PRINTF(PATH_KERN_SHM_NEXT_ID, "%d", shm_id[0]);
 
 	shm_id[1] = SAFE_SHMGET(shmkey[1], SHM_SIZE, IPC_CREAT | SHM_RW);
 	if (shm_id[1] == shm_id[0])
@@ -46,7 +44,7 @@ static void setup(void)
 	shmkey[0] = GETIPCKEY();
 	shmkey[1] = GETIPCKEY();
 	pid = getpid();
-	SAFE_FILE_PRINTF(NEXT_ID_PATH, "%d", pid);
+	SAFE_FILE_PRINTF(PATH_KERN_SHM_NEXT_ID, "%d", pid);
 	shm_id[0] = SAFE_SHMGET(shmkey[0], SHM_SIZE, IPC_CREAT | SHM_RW);
 }
 
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
index cc3faf5cf..a55385040 100644
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
+			if (access(PATH_MM_KSM, F_OK) == 0)
 				tc->skip = 1;
 		break;
 		case MADV_WILLNEED:
diff --git a/testcases/kernel/syscalls/madvise/madvise06.c b/testcases/kernel/syscalls/madvise/madvise06.c
index 969b24984..799e5398a 100644
--- a/testcases/kernel/syscalls/madvise/madvise06.c
+++ b/testcases/kernel/syscalls/madvise/madvise06.c
@@ -47,7 +47,7 @@
 #define PASS_THRESHOLD (CHUNK_SZ / 4)
 #define PASS_THRESHOLD_KB (PASS_THRESHOLD / 1024)
 
-static const char drop_caches_fname[] = "/proc/sys/vm/drop_caches";
+static const char drop_caches_fname[] = PATH_VM_DROP_CACHES;
 static int pg_sz, stat_refresh_sup;
 
 static long init_swap, init_swap_cached, init_cached;
diff --git a/testcases/kernel/syscalls/madvise/madvise08.c b/testcases/kernel/syscalls/madvise/madvise08.c
index 96bcaf159..0fe270fb9 100644
--- a/testcases/kernel/syscalls/madvise/madvise08.c
+++ b/testcases/kernel/syscalls/madvise/madvise08.c
@@ -33,7 +33,6 @@
 #include "tst_test.h"
 #include "lapi/mmap.h"
 
-#define CORE_PATTERN "/proc/sys/kernel/core_pattern"
 #define CORE_FILTER "/proc/self/coredump_filter"
 #define YCOUNT 0x500L
 #define FMEMSIZE (YCOUNT + 0x2L)
@@ -71,7 +70,7 @@ static void setup(void)
 	SAFE_GETCWD(cwd, sizeof(cwd));
 	snprintf(tmpcpattern, sizeof(tmpcpattern), "%s/dump-%%p", cwd);
 	tst_res(TINFO, "Temporary core pattern is '%s'", tmpcpattern);
-	SAFE_FILE_PRINTF(CORE_PATTERN, "%s", tmpcpattern);
+	SAFE_FILE_PRINTF(PATH_KERN_CORE_PATTERN, "%s", tmpcpattern);
 
 	fmem = SAFE_MMAP(NULL,
 			 FMEMSIZE,
@@ -212,7 +211,7 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.forks_child = 1,
 	.save_restore = (const struct tst_path_val[]) {
-		{CORE_PATTERN, NULL, TST_SR_TCONF},
+		{PATH_KERN_CORE_PATTERN, NULL, TST_SR_TCONF},
 		{}
 	},
 };
diff --git a/testcases/kernel/syscalls/memfd_create/memfd_create04.c b/testcases/kernel/syscalls/memfd_create/memfd_create04.c
index 8a12a72ff..3114f87b4 100644
--- a/testcases/kernel/syscalls/memfd_create/memfd_create04.c
+++ b/testcases/kernel/syscalls/memfd_create/memfd_create04.c
@@ -46,7 +46,7 @@ static void check_hugepage_support(struct test_flag *test_flags)
 {
 	char pattern[64];
 
-	sprintf(pattern, PATH_HUGEPAGES);
+	sprintf(pattern, PATH_MM_HUGEPAGES);
 	strcat(pattern, "hugepages-");
 	strcat(pattern, test_flags->h_size);
 
@@ -84,7 +84,7 @@ static void memfd_huge_x_controller(unsigned int n)
 
 static void setup(void)
 {
-	if (access(PATH_HUGEPAGES, F_OK))
+	if (access(PATH_MM_HUGEPAGES, F_OK))
 		tst_brk(TCONF, "Huge page is not supported");
 }
 
diff --git a/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c b/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
index 780aae1b5..c17f9cfdf 100644
--- a/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
+++ b/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
@@ -324,7 +324,7 @@ static struct tst_test test = {
 	.test_all = run,
 	.setup = setup,
 	.save_restore = (const struct tst_path_val[]) {
-		{"/proc/sys/kernel/numa_balancing", "0",
+		{PATH_KERN_NUMA_BALANCING, "0",
 			TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},
 		{}
 	},
diff --git a/testcases/kernel/syscalls/migrate_pages/migrate_pages03.c b/testcases/kernel/syscalls/migrate_pages/migrate_pages03.c
index 59d7e79db..b639b557e 100644
--- a/testcases/kernel/syscalls/migrate_pages/migrate_pages03.c
+++ b/testcases/kernel/syscalls/migrate_pages/migrate_pages03.c
@@ -49,7 +49,7 @@ static void setup(void)
 	int n;
 	unsigned long nodemask_size;
 
-	if (access(PATH_KSM, F_OK))
+	if (access(PATH_MM_KSM, F_OK))
 		tst_brk(TCONF, "KSM configuration was not enabled");
 
 	if (get_allowed_nodes_arr(NH_MEMS, &num_nodes, &nodes) < 0)
@@ -93,8 +93,8 @@ static void setup(void)
 		memset(test_pages[n], 0, page_size);
 	}
 
-	SAFE_FILE_SCANF(PATH_KSM "run", "%d", &orig_ksm_run);
-	SAFE_FILE_PRINTF(PATH_KSM "run", "%d", 1);
+	SAFE_FILE_SCANF(PATH_MM_KSM_RUN, "%d", &orig_ksm_run);
+	SAFE_FILE_PRINTF(PATH_MM_KSM_RUN, "%d", 1);
 	wait_ksmd_full_scan();
 }
 
@@ -111,7 +111,7 @@ static void cleanup(void)
 	free(new_nodes[1]);
 
 	if (orig_ksm_run != -1)
-		SAFE_FILE_PRINTF(PATH_KSM "run", "%d", orig_ksm_run);
+		SAFE_FILE_PRINTF(PATH_MM_KSM_RUN, "%d", orig_ksm_run);
 }
 
 static void migrate_test(void)
diff --git a/testcases/kernel/syscalls/mmap/mmap10.c b/testcases/kernel/syscalls/mmap/mmap10.c
index fb5543899..bac50045b 100644
--- a/testcases/kernel/syscalls/mmap/mmap10.c
+++ b/testcases/kernel/syscalls/mmap/mmap10.c
@@ -40,7 +40,6 @@
 #include "tst_test.h"
 
 #define SIZE (5 * TST_MB)
-#define PATH_KSM "/sys/kernel/mm/ksm/"
 
 static size_t page_sz;
 static char *memory;
@@ -60,7 +59,7 @@ static void run(unsigned int i)
 	int fd = -1;
 
 	if (tc->add_ksm) {
-		if (access(PATH_KSM, F_OK) == -1)
+		if (access(PATH_MM_KSM, F_OK) == -1)
 			tst_brk(TCONF, "KSM configuration is not enabled");
 		else
 			tst_res(TINFO, "Add to KSM regions");
diff --git a/testcases/kernel/syscalls/move_pages/move_pages12.c b/testcases/kernel/syscalls/move_pages/move_pages12.c
index 440773a38..b2ec0e70f 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages12.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages12.c
@@ -76,8 +76,6 @@
 
 #define LOOPS	10000
 #define PATH_MEMINFO	"/proc/meminfo"
-#define PATH_NR_HUGEPAGES	"/proc/sys/vm/nr_hugepages"
-#define PATH_HUGEPAGES	"/sys/kernel/mm/hugepages/"
 #define TEST_NODES	2
 
 static struct tcase {
@@ -259,7 +257,7 @@ static void setup(void)
 
 	check_config(TEST_NODES);
 
-	if (access(PATH_HUGEPAGES, F_OK))
+	if (access(PATH_MM_HUGEPAGES, F_OK))
 		tst_brk(TCONF, "Huge page not supported");
 
 	ret = get_allowed_nodes(NH_MEMS, TEST_NODES, &node1, &node2);
@@ -269,7 +267,7 @@ static void setup(void)
 	pgsz = (int)get_page_size();
 	SAFE_FILE_LINES_SCANF(PATH_MEMINFO, "Hugepagesize: %d", &hpsz);
 
-	SAFE_FILE_PRINTF("/proc/sys/vm/drop_caches", "3");
+	SAFE_FILE_PRINTF(PATH_VM_DROP_CACHES, "3");
 	SAFE_FILE_LINES_SCANF(PATH_MEMINFO, "MemFree: %ld", &memfree);
 	tst_res(TINFO, "Free RAM %ld kB", memfree);
 
@@ -307,10 +305,10 @@ static void setup(void)
 	hpsz *= 1024;
 
 	if (orig_hugepages_node1 == -1 || orig_hugepages_node2 == -1) {
-		SAFE_FILE_SCANF(PATH_NR_HUGEPAGES, "%ld", &orig_hugepages);
+		SAFE_FILE_SCANF(PATH_VM_NR_HPAGES, "%ld", &orig_hugepages);
 		tst_res(TINFO, "Increasing global hugepages pool to %ld",
 			orig_hugepages + 8);
-		SAFE_FILE_PRINTF(PATH_NR_HUGEPAGES, "%ld", orig_hugepages + 8);
+		SAFE_FILE_PRINTF(PATH_VM_NR_HPAGES, "%ld", orig_hugepages + 8);
 	}
 
 	alloc_free_huge_on_node(node1, 4L * hpsz);
@@ -320,7 +318,7 @@ static void setup(void)
 static void cleanup(void)
 {
 	if (orig_hugepages != -1)
-		SAFE_FILE_PRINTF(PATH_NR_HUGEPAGES, "%ld", orig_hugepages);
+		SAFE_FILE_PRINTF(PATH_VM_NR_HPAGES, "%ld", orig_hugepages);
 
 	if (orig_hugepages_node1 != -1) {
 		SAFE_FILE_PRINTF(path_hugepages_node1,
diff --git a/testcases/kernel/syscalls/newuname/newuname01.c b/testcases/kernel/syscalls/newuname/newuname01.c
index 995ea978e..82f2ce6f9 100644
--- a/testcases/kernel/syscalls/newuname/newuname01.c
+++ b/testcases/kernel/syscalls/newuname/newuname01.c
@@ -31,16 +31,16 @@ static void run(void)
 
 	TST_EXP_EQ_STR(name->sysname, "Linux");
 
-	SAFE_FILE_READ_STR("/proc/sys/kernel/hostname", proc_val, sizeof(proc_val));
+	SAFE_FILE_READ_STR(PATH_KERN_HOSTNAME, proc_val, sizeof(proc_val));
 	TST_EXP_EQ_STR(name->nodename, proc_val);
 
-	SAFE_FILE_READ_STR("/proc/sys/kernel/osrelease", proc_val, sizeof(proc_val));
+	SAFE_FILE_READ_STR(PATH_KERN_OSRELEASE, proc_val, sizeof(proc_val));
 	TST_EXP_EQ_STR(name->release, proc_val);
 
-	SAFE_FILE_READ_STR("/proc/sys/kernel/version", proc_val, sizeof(proc_val));
+	SAFE_FILE_READ_STR(PATH_KERN_VERSION, proc_val, sizeof(proc_val));
 	TST_EXP_EQ_STR(name->version, proc_val);
 
-	SAFE_FILE_READ_STR("/proc/sys/kernel/domainname", proc_val, sizeof(proc_val));
+	SAFE_FILE_READ_STR(PATH_KERN_DOMAINNAME, proc_val, sizeof(proc_val));
 	TST_EXP_EQ_STR(name->domainname, proc_val);
 }
 
diff --git a/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c b/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c
index 7306ecf51..e38c3f133 100644
--- a/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c
+++ b/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c
@@ -211,7 +211,7 @@ static void setup(void)
 	 * knowing if perf_event_open() support is enabled is checking for
 	 * the existence of the file /proc/sys/kernel/perf_event_paranoid.
 	 */
-	if (access("/proc/sys/kernel/perf_event_paranoid", F_OK) == -1)
+	if (access(PATH_KERN_PERF_EVENT_PARANOID, F_OK) == -1)
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
index 472543e5c..96f14ff32 100644
--- a/testcases/kernel/syscalls/preadv2/preadv203.c
+++ b/testcases/kernel/syscalls/preadv2/preadv203.c
@@ -58,7 +58,7 @@ static volatile int stop;
 
 static void drop_caches(void)
 {
-	SAFE_FILE_PRINTF("/proc/sys/vm/drop_caches", "3");
+	SAFE_FILE_PRINTF(PATH_VM_DROP_CACHES, "3");
 }
 
 /*
diff --git a/testcases/kernel/syscalls/readahead/readahead02.c b/testcases/kernel/syscalls/readahead/readahead02.c
index 5ebc43278..5e1d2350c 100644
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
+	SAFE_FILE_PRINTF(PATH_VM_DROP_CACHES, "1");
 }
 
 static unsigned long get_bytes_read(void)
@@ -430,7 +429,7 @@ static void setup(void)
 	if (access(PROC_IO_FNAME, F_OK))
 		tst_brk(TCONF, "Requires " PROC_IO_FNAME);
 
-	has_file(DROP_CACHES_FNAME, 1);
+	has_file(PATH_VM_DROP_CACHES, 1);
 
 	/* check if readahead is supported */
 	tst_syscall(__NR_readahead, 0, 0, 0);
diff --git a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c
index 6dbf5af89..98aae1e55 100644
--- a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c
+++ b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c
@@ -13,11 +13,11 @@
  * - c7fcb99877f9 ( sched/rt: Fix sysctl_sched_rr_timeslice intial value)
  */
 
+#include "tst_test.h"
 #include "time64_variants.h"
 #include "tst_timer.h"
 #include "tst_sched.h"
 
-#define PROC_SCHED_RR_TIMESLICE_MS	"/proc/sys/kernel/sched_rr_timeslice_ms"
 static int proc_flag;
 
 struct tst_ts tp;
@@ -48,7 +48,7 @@ static void setup(void)
 	if ((sys_sched_setscheduler(0, SCHED_RR, &p)) == -1)
 		tst_res(TFAIL | TERRNO, "sched_setscheduler() failed");
 
-	proc_flag = !access(PROC_SCHED_RR_TIMESLICE_MS, F_OK);
+	proc_flag = !access(PATH_KERN_SCHED_RR_TIMESLICE_MS, F_OK);
 }
 
 static void run(void)
@@ -73,7 +73,7 @@ static void run(void)
 	}
 
 	if (proc_flag)
-		TST_ASSERT_INT(PROC_SCHED_RR_TIMESLICE_MS, tst_ts_to_ms(tp));
+		TST_ASSERT_INT(PATH_KERN_SCHED_RR_TIMESLICE_MS, tst_ts_to_ms(tp));
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/sendmsg/sendmsg03.c b/testcases/kernel/syscalls/sendmsg/sendmsg03.c
index 34ebc7e95..21bad13a8 100644
--- a/testcases/kernel/syscalls/sendmsg/sendmsg03.c
+++ b/testcases/kernel/syscalls/sendmsg/sendmsg03.c
@@ -111,7 +111,7 @@ static struct tst_test test = {
 		NULL
 	},
 	.save_restore = (const struct tst_path_val[]) {
-		{"/proc/sys/user/max_user_namespaces", "1024", TST_SR_SKIP},
+		{PATH_USER_MAX_USER_NAMESPACES, "1024", TST_SR_SKIP},
 		{}
 	},
 	.tags = (const struct tst_tag[]) {
diff --git a/testcases/kernel/syscalls/sendto/sendto03.c b/testcases/kernel/syscalls/sendto/sendto03.c
index 622de6474..5fffd7909 100644
--- a/testcases/kernel/syscalls/sendto/sendto03.c
+++ b/testcases/kernel/syscalls/sendto/sendto03.c
@@ -205,7 +205,7 @@ static struct tst_test test = {
 		NULL
 	},
 	.save_restore = (const struct tst_path_val[]) {
-		{"/proc/sys/user/max_user_namespaces", "1024", TST_SR_SKIP},
+		{PATH_USER_MAX_USER_NAMESPACES, "1024", TST_SR_SKIP},
 		{}
 	},
 	.tags = (const struct tst_tag[]) {
diff --git a/testcases/kernel/syscalls/setpgid/setpgid02.c b/testcases/kernel/syscalls/setpgid/setpgid02.c
index 978d255e5..a50283ca3 100644
--- a/testcases/kernel/syscalls/setpgid/setpgid02.c
+++ b/testcases/kernel/syscalls/setpgid/setpgid02.c
@@ -42,7 +42,7 @@ static void setup(void)
 	 * pid_max would not be in use by another process and guarantees that
 	 * it corresponds to an invalid PGID, generating EPERM.
 	 */
-	SAFE_FILE_SCANF("/proc/sys/kernel/pid_max", "%d\n", &inval_pgid);
+	SAFE_FILE_SCANF(PATH_KERN_PID_MAX, "%d\n", &inval_pgid);
 }
 
 static void run(unsigned int n)
diff --git a/testcases/kernel/syscalls/setrlimit/setrlimit03.c b/testcases/kernel/syscalls/setrlimit/setrlimit03.c
index 0e1f83a1e..621b89317 100644
--- a/testcases/kernel/syscalls/setrlimit/setrlimit03.c
+++ b/testcases/kernel/syscalls/setrlimit/setrlimit03.c
@@ -23,8 +23,6 @@
 # define NR_OPEN (1024*1024)
 #endif
 
-#define NR_OPEN_PATH "/proc/sys/fs/nr_open"
-
 static struct rlimit rlim1, rlim2;
 static unsigned int nr_open = NR_OPEN;
 
@@ -59,8 +57,8 @@ static void verify_setrlimit(unsigned int n)
 
 static void setup(void)
 {
-	if (!access(NR_OPEN_PATH, F_OK))
-		SAFE_FILE_SCANF(NR_OPEN_PATH, "%u", &nr_open);
+	if (!access(PATH_FS_NR_OPEN, F_OK))
+		SAFE_FILE_SCANF(PATH_FS_NR_OPEN, "%u", &nr_open);
 
 	SAFE_GETRLIMIT(RLIMIT_NOFILE, &rlim1);
 	rlim2.rlim_max = rlim1.rlim_cur;
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt05.c b/testcases/kernel/syscalls/setsockopt/setsockopt05.c
index 35a3d1bd3..85f3ef34e 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt05.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt05.c
@@ -88,7 +88,7 @@ static struct tst_test test = {
 		NULL
 	},
 	.save_restore = (const struct tst_path_val[]) {
-		{"/proc/sys/user/max_user_namespaces", "1024", TST_SR_SKIP},
+		{PATH_USER_MAX_USER_NAMESPACES, "1024", TST_SR_SKIP},
 		{}
 	},
 	.tags = (const struct tst_tag[]) {
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt06.c b/testcases/kernel/syscalls/setsockopt/setsockopt06.c
index 2160b29e7..d73097aa0 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt06.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt06.c
@@ -116,7 +116,7 @@ static struct tst_test test = {
 		NULL
 	},
 	.save_restore = (const struct tst_path_val[]) {
-		{"/proc/sys/user/max_user_namespaces", "1024", TST_SR_SKIP},
+		{PATH_USER_MAX_USER_NAMESPACES, "1024", TST_SR_SKIP},
 		{}
 	},
 	.tags = (const struct tst_tag[]) {
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt07.c b/testcases/kernel/syscalls/setsockopt/setsockopt07.c
index 6eeec8a6f..93f283de2 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt07.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt07.c
@@ -128,7 +128,7 @@ static struct tst_test test = {
 		NULL
 	},
 	.save_restore = (const struct tst_path_val[]) {
-		{"/proc/sys/user/max_user_namespaces", "1024", TST_SR_SKIP},
+		{PATH_USER_MAX_USER_NAMESPACES, "1024", TST_SR_SKIP},
 		{}
 	},
 	.tags = (const struct tst_tag[]) {
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt08.c b/testcases/kernel/syscalls/setsockopt/setsockopt08.c
index 76ec1054e..2578638df 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt08.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt08.c
@@ -158,7 +158,7 @@ static struct tst_test test = {
 		NULL
 	},
 	.save_restore = (const struct tst_path_val[]) {
-		{"/proc/sys/user/max_user_namespaces", "1024", TST_SR_SKIP},
+		{PATH_USER_MAX_USER_NAMESPACES, "1024", TST_SR_SKIP},
 		{}
 	},
 	.tags = (const struct tst_tag[]) {
diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt09.c b/testcases/kernel/syscalls/setsockopt/setsockopt09.c
index a4b6b9315..d29381129 100644
--- a/testcases/kernel/syscalls/setsockopt/setsockopt09.c
+++ b/testcases/kernel/syscalls/setsockopt/setsockopt09.c
@@ -111,7 +111,7 @@ static struct tst_test test = {
 		NULL
 	},
 	.save_restore = (const struct tst_path_val[]) {
-		{"/proc/sys/user/max_user_namespaces", "1024", TST_SR_SKIP},
+		{PATH_USER_MAX_USER_NAMESPACES, "1024", TST_SR_SKIP},
 		{}
 	},
 	.tags = (const struct tst_tag[]) {
diff --git a/testcases/kernel/syscalls/splice/splice.h b/testcases/kernel/syscalls/splice/splice.h
index 16e4c98ed..1c30f2d68 100644
--- a/testcases/kernel/syscalls/splice/splice.h
+++ b/testcases/kernel/syscalls/splice/splice.h
@@ -26,13 +26,13 @@ static inline int get_max_limit(int default_len_data)
 {
 	int pipe_max_unpriv;
 
-	if (!access("/proc/sys/fs/pipe-max-size", F_OK)) {
-		SAFE_FILE_SCANF("/proc/sys/fs/pipe-max-size", "%d", &pipe_max_unpriv);
+	if (!access(PATH_FS_PIPE_MAX_SIZE, F_OK)) {
+		SAFE_FILE_SCANF(PATH_FS_PIPE_MAX_SIZE, "%d", &pipe_max_unpriv);
 		return MIN(pipe_max_unpriv, default_len_data);
 	}
 
-	if (!access("/proc/sys/fs/pipe-max-pages", F_OK)) {
-		SAFE_FILE_SCANF("/proc/sys/fs/pipe-max-pages", "%d", &pipe_max_unpriv);
+	if (!access(PATH_FS_PIPE_MAX_PAGES, F_OK)) {
+		SAFE_FILE_SCANF(PATH_FS_PIPE_MAX_PAGES, "%d", &pipe_max_unpriv);
 		return MIN(pipe_max_unpriv * getpagesize(), default_len_data);
 	}
 
diff --git a/testcases/kernel/syscalls/splice/splice06.c b/testcases/kernel/syscalls/splice/splice06.c
index e64d32ded..c7434979b 100644
--- a/testcases/kernel/syscalls/splice/splice06.c
+++ b/testcases/kernel/syscalls/splice/splice06.c
@@ -25,8 +25,6 @@
 #define PIPE_MAX_INIT_SIZE 65536
 #define DOMAIN_INIT_NAME "LTP_INIT"
 #define DOMAIN_TEST_NAME "LTP_TEST"
-#define INTEGER_PROCFILE "/proc/sys/fs/pipe-max-size"
-#define STRING_PROCFILE "/proc/sys/kernel/domainname"
 static int pipe_max_test_size;
 
 static void format_str(char *str)
@@ -172,14 +170,14 @@ static void splice_test(void)
 	char buf_file[BUF_SIZE];
 	char buf_splice[BUF_SIZE];
 
-	if (file_read_num(INTEGER_PROCFILE) == splice_read_num(INTEGER_PROCFILE))
+	if (file_read_num(PATH_FS_PIPE_MAX_SIZE) == splice_read_num(PATH_FS_PIPE_MAX_SIZE))
 		tst_res(TPASS, "Read num through splice correctly");
 	else
 		tst_brk(TBROK | TERRNO, "Read num through splice failed");
 
-	splice_write_num(INTEGER_PROCFILE, pipe_max_test_size);
+	splice_write_num(PATH_FS_PIPE_MAX_SIZE, pipe_max_test_size);
 
-	if (file_read_num(INTEGER_PROCFILE) == pipe_max_test_size)
+	if (file_read_num(PATH_FS_PIPE_MAX_SIZE) == pipe_max_test_size)
 		tst_res(TPASS, "Write num through splice correctly");
 	else
 		tst_brk(TBROK | TERRNO, "Write num through splice failed");
@@ -187,8 +185,8 @@ static void splice_test(void)
 	memset(buf_file, '\0', sizeof(buf_file));
 	memset(buf_splice, '\0', sizeof(buf_splice));
 
-	file_read_str(STRING_PROCFILE, buf_file);
-	splice_read_str(STRING_PROCFILE, buf_splice);
+	file_read_str(PATH_KERN_DOMAINNAME, buf_file);
+	splice_read_str(PATH_KERN_DOMAINNAME, buf_splice);
 
 	if (!strncmp(buf_file, buf_splice, strlen(buf_file)))
 		tst_res(TPASS, "Read string through splice correctly");
@@ -197,8 +195,8 @@ static void splice_test(void)
 
 	memset(buf_file, '\0', sizeof(buf_file));
 
-	splice_write_str(STRING_PROCFILE, DOMAIN_TEST_NAME);
-	file_read_str(STRING_PROCFILE, buf_file);
+	splice_write_str(PATH_KERN_DOMAINNAME, DOMAIN_TEST_NAME);
+	file_read_str(PATH_KERN_DOMAINNAME, buf_file);
 
 	if (!strncmp(buf_file, DOMAIN_TEST_NAME, strlen(buf_file)))
 		tst_res(TPASS, "Write string through splice correctly");
@@ -209,8 +207,8 @@ static void splice_test(void)
 static void setup(void)
 {
 	pipe_max_test_size = getpagesize();
-	file_write_str(STRING_PROCFILE, DOMAIN_INIT_NAME);
-	file_write_num(STRING_PROCFILE, PIPE_MAX_INIT_SIZE);
+	file_write_str(PATH_KERN_DOMAINNAME, DOMAIN_INIT_NAME);
+	file_write_num(PATH_KERN_DOMAINNAME, PIPE_MAX_INIT_SIZE);
 }
 
 static struct tst_test test = {
@@ -219,8 +217,8 @@ static struct tst_test test = {
 	.test_all = splice_test,
 	.needs_tmpdir = 1,
 	.save_restore = (const struct tst_path_val[]) {
-		{INTEGER_PROCFILE, NULL, TST_SR_TCONF},
-		{STRING_PROCFILE, NULL, TST_SR_TCONF},
+		{PATH_FS_PIPE_MAX_SIZE, NULL, TST_SR_TCONF},
+		{PATH_KERN_DOMAINNAME, NULL, TST_SR_TCONF},
 		{}
 	},
 };
diff --git a/testcases/kernel/syscalls/syslog/syslog11.c b/testcases/kernel/syscalls/syslog/syslog11.c
index 28a6fdf49..cc6fbc186 100644
--- a/testcases/kernel/syscalls/syslog/syslog11.c
+++ b/testcases/kernel/syscalls/syslog/syslog11.c
@@ -56,7 +56,7 @@ static void run(unsigned int n)
 static struct tst_test test = {
 	.test = run,
 	.save_restore = (const struct tst_path_val[]) {
-		{"/proc/sys/kernel/printk", NULL, TST_SR_TBROK},
+		{PATH_KERN_PRINTK, NULL, TST_SR_TBROK},
 		{}
 	},
 	.needs_root = 1,
diff --git a/testcases/kernel/syscalls/unshare/unshare03.c b/testcases/kernel/syscalls/unshare/unshare03.c
index 7128b3b97..ca12070ee 100644
--- a/testcases/kernel/syscalls/unshare/unshare03.c
+++ b/testcases/kernel/syscalls/unshare/unshare03.c
@@ -16,8 +16,6 @@
 #include "config.h"
 #include "lapi/sched.h"
 
-#define FS_NR_OPEN "/proc/sys/fs/nr_open"
-
 #ifdef HAVE_UNSHARE
 
 static void run(void)
@@ -32,7 +30,7 @@ static void run(void)
 	SAFE_DUP2(2, nr_open + 1);
 
 	if (!SAFE_CLONE(&args)) {
-		SAFE_FILE_PRINTF(FS_NR_OPEN, "%d", nr_open);
+		SAFE_FILE_PRINTF(PATH_FS_NR_OPEN, "%d", nr_open);
 		TST_EXP_FAIL(unshare(CLONE_FILES), EMFILE);
 		exit(0);
 	}
@@ -49,7 +47,7 @@ static struct tst_test test = {
 	.test_all = run,
 	.setup = setup,
 	.save_restore = (const struct tst_path_val[]) {
-		{FS_NR_OPEN, NULL, TST_SR_TCONF},
+		{PATH_FS_NR_OPEN, NULL, TST_SR_TCONF},
 		{}
 	},
 };
diff --git a/testcases/kernel/syscalls/wait4/wait402.c b/testcases/kernel/syscalls/wait4/wait402.c
index 18ed0814f..d5ec10aa4 100644
--- a/testcases/kernel/syscalls/wait4/wait402.c
+++ b/testcases/kernel/syscalls/wait4/wait402.c
@@ -25,7 +25,7 @@ static void run(void)
 
 static void setup(void)
 {
-	SAFE_FILE_SCANF("/proc/sys/kernel/pid_max", "%d\n", &pid_max);
+	SAFE_FILE_SCANF(PATH_KERN_PID_MAX, "%d\n", &pid_max);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/waitid/waitid10.c b/testcases/kernel/syscalls/waitid/waitid10.c
index 14d4ba76b..f4a7b82ec 100644
--- a/testcases/kernel/syscalls/waitid/waitid10.c
+++ b/testcases/kernel/syscalls/waitid/waitid10.c
@@ -48,7 +48,7 @@ static void setup(void)
 	char c;
 
 	SAFE_GETRLIMIT(RLIMIT_CORE, &rlim);
-	SAFE_FILE_SCANF("/proc/sys/kernel/core_pattern", "%c", &c);
+	SAFE_FILE_SCANF(PATH_KERN_CORE_PATTERN, "%c", &c);
 
 	if (rlim.rlim_cur)
 		return;
diff --git a/testcases/network/iptables/nft02.c b/testcases/network/iptables/nft02.c
index 5f0671c5d..f6a3cdb59 100644
--- a/testcases/network/iptables/nft02.c
+++ b/testcases/network/iptables/nft02.c
@@ -203,7 +203,7 @@ static struct tst_test test = {
 		NULL
 	},
 	.save_restore = (const struct tst_path_val[]) {
-		{"/proc/sys/user/max_user_namespaces", "1024", TST_SR_SKIP},
+		{PATH_USER_MAX_USER_NAMESPACES, "1024", TST_SR_SKIP},
 		{}
 	},
 	.tags = (const struct tst_tag[]) {
diff --git a/testcases/network/packet/fanout01.c b/testcases/network/packet/fanout01.c
index dc1ff6ce5..3579696ff 100644
--- a/testcases/network/packet/fanout01.c
+++ b/testcases/network/packet/fanout01.c
@@ -96,7 +96,7 @@ static struct tst_test test = {
 		NULL
 	},
 	.save_restore = (const struct tst_path_val[]) {
-		{"/proc/sys/user/max_user_namespaces", "1024", TST_SR_SKIP},
+		{PATH_USER_MAX_USER_NAMESPACES, "1024", TST_SR_SKIP},
 		{}
 	},
 	.tags = (const struct tst_tag[]) {
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
