From: Li Wang <liwang@redhat.com>
Date: Mon, 10 Apr 2017 18:05:45 +0800
Subject: [LTP] [PATCH V2 03/14] mem/oom: fix the timeout issue
In-Reply-To: <20170410100556.4465-1-liwang@redhat.com>
References: <20170410100556.4465-1-liwang@redhat.com>
Message-ID: <20170410100556.4465-4-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

OOM spend time is depend on amount of RAM+Swap, it's hard to get a standard
to measure how long it takes, so that we cann't set tst_test->timeout easily.

In this patch, we divide the tests into two part:

1. OOM takes original way on small(mem_total <= 100G) RAM, and with setting
   the .timeout according to the worst spending on 100G system. Here gives
   double(.timeout = 1200) cost in order to make sure time is long enough.

2. If system RAM is larger than 100G, OOM goes to the cgroup limited way.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/mem/oom/oom01.c | 12 ++++++++++++
 testcases/kernel/mem/oom/oom02.c | 12 ++++++++++++
 testcases/kernel/mem/oom/oom03.c |  1 +
 testcases/kernel/mem/oom/oom04.c | 11 +++++++++++
 testcases/kernel/mem/oom/oom05.c |  1 +
 5 files changed, 37 insertions(+)

diff --git a/testcases/kernel/mem/oom/oom01.c b/testcases/kernel/mem/oom/oom01.c
index 64a368e..056e02a 100644
--- a/testcases/kernel/mem/oom/oom01.c
+++ b/testcases/kernel/mem/oom/oom01.c
@@ -29,6 +29,8 @@
 #include <unistd.h>
 #include "mem.h"
 
+static unsigned long mem_total;
+
 static void verify_oom(void)
 {
 #if __WORDSIZE == 32
@@ -50,11 +52,20 @@ static void verify_oom(void)
 
 static void setup(void)
 {
+	mem_total = SAFE_READ_MEMINFO("MemTotal:");
+	if (mem_total > TESTMEM/1024*100L) {
+		tst_res(TINFO, "System RAM is larger than 100G, test in memory cgroup");
+		mount_mem("memcg", "cgroup", "memory", MEMCG_PATH, MEMCG_PATH_NEW);
+		write_memcg();
+	}
+
 	overcommit = get_sys_tune("overcommit_memory");
 }
 
 static void cleanup(void)
 {
+	if (mem_total > TESTMEM/1024*100L)
+		umount_mem(MEMCG_PATH, MEMCG_PATH_NEW);
 	set_sys_tune("overcommit_memory", overcommit, 0);
 }
 
@@ -62,6 +73,7 @@ static struct tst_test test = {
 	.tid = "oom01",
 	.needs_root = 1,
 	.forks_child = 1,
+	.timeout = 1200,
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = verify_oom,
diff --git a/testcases/kernel/mem/oom/oom02.c b/testcases/kernel/mem/oom/oom02.c
index f315ee2..a1be806 100644
--- a/testcases/kernel/mem/oom/oom02.c
+++ b/testcases/kernel/mem/oom/oom02.c
@@ -32,6 +32,8 @@
 #if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
 	&& HAVE_MPOL_CONSTANTS
 
+static unsigned long mem_total;
+
 static void verify_oom(void)
 {
 #if __WORDSIZE == 32
@@ -50,6 +52,13 @@ static void verify_oom(void)
 
 static void setup(void)
 {
+	mem_total = SAFE_READ_MEMINFO("MemTotal:");
+	if (mem_total > TESTMEM/1024*100L) {
+		tst_res(TINFO, "System RAM is larger than 100G, test in memory cgroup");
+		mount_mem("memcg", "cgroup", "memory", MEMCG_PATH, MEMCG_PATH_NEW);
+		write_memcg();
+	}
+
 	if (!is_numa(NULL, NH_MEMS, 2))
 		tst_brk(TCONF, "The case need a NUMA system.");
 
@@ -59,6 +68,8 @@ static void setup(void)
 
 static void cleanup(void)
 {
+	if (mem_total > TESTMEM/1024*100L)
+		umount_mem(MEMCG_PATH, MEMCG_PATH_NEW);
 	set_sys_tune("overcommit_memory", overcommit, 0);
 }
 
@@ -66,6 +77,7 @@ static struct tst_test test = {
 	.tid = "oom02",
 	.needs_root = 1,
 	.forks_child = 1,
+	.timeout = 1200,
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = verify_oom,
diff --git a/testcases/kernel/mem/oom/oom03.c b/testcases/kernel/mem/oom/oom03.c
index d3aed60..48c1ea5 100644
--- a/testcases/kernel/mem/oom/oom03.c
+++ b/testcases/kernel/mem/oom/oom03.c
@@ -79,6 +79,7 @@ static struct tst_test test = {
 	.tid = "oom03",
 	.needs_root = 1,
 	.forks_child = 1,
+	.timeout = 1200,
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = verify_oom,
diff --git a/testcases/kernel/mem/oom/oom04.c b/testcases/kernel/mem/oom/oom04.c
index afe35b2..179a98a 100644
--- a/testcases/kernel/mem/oom/oom04.c
+++ b/testcases/kernel/mem/oom/oom04.c
@@ -32,6 +32,8 @@
 #if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
 	&& HAVE_MPOL_CONSTANTS
 
+static unsigned long mem_total;
+
 static void verify_oom(void)
 {
 #if __WORDSIZE == 32
@@ -63,6 +65,12 @@ static void setup(void)
 	overcommit = get_sys_tune("overcommit_memory");
 	set_sys_tune("overcommit_memory", 1, 1);
 
+	mem_total = SAFE_READ_MEMINFO("MemTotal:");
+	if (mem_total > TESTMEM/1024*100L) {
+		tst_res(TINFO, "System RAM is larger than 100G, test in memory cgroup");
+		mount_mem("memcg", "cgroup", "memory", MEMCG_PATH, MEMCG_PATH_NEW);
+		write_memcg();
+	}
 	mount_mem("cpuset", "cpuset", NULL, CPATH, CPATH_NEW);
 
 	/*
@@ -80,6 +88,8 @@ static void setup(void)
 
 static void cleanup(void)
 {
+	if (mem_total > TESTMEM/1024*100L)
+		umount_mem(MEMCG_PATH, MEMCG_PATH_NEW);
 	set_sys_tune("overcommit_memory", overcommit, 0);
 	umount_mem(CPATH, CPATH_NEW);
 }
@@ -88,6 +98,7 @@ static struct tst_test test = {
 	.tid = "oom04",
 	.needs_root = 1,
 	.forks_child = 1,
+	.timeout = 1200,
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = verify_oom,
diff --git a/testcases/kernel/mem/oom/oom05.c b/testcases/kernel/mem/oom/oom05.c
index d97fe7d..39361a9 100644
--- a/testcases/kernel/mem/oom/oom05.c
+++ b/testcases/kernel/mem/oom/oom05.c
@@ -116,6 +116,7 @@ static struct tst_test test = {
 	.tid = "oom05",
 	.needs_root = 1,
 	.forks_child = 1,
+	.timeout = 1200,
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = verify_oom,
-- 
2.9.3

