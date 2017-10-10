From: Li Wang <liwang@redhat.com>
Date: Tue, 10 Oct 2017 15:56:56 +0800
Subject: [LTP] [PATCH] oom: fix oom04/5 Warning
Message-ID: <20171010075656.18796-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

To get rid of the warnings, do nothing in cleanup() if NUMA node is less than 1.

oom04.c:61: CONF: requires NUMA with at least 1 node
mem.c:854: INFO: set overcommit_memory to 0
mem.c:761: WARN: open /dev/cpuset/tasks: ENOENT
mem.c:766: WARN: fopen /dev/cpuset/1/tasks: ENOENT
mem.c:778: WARN: rmdir /dev/cpuset/1: ENOENT
mem.c:780: WARN: umount /dev/cpuset: ENOENT
mem.c:782: WARN: rmdir /dev/cpuset: ENOENT

oom05.c:84: CONF: requires NUMA with at least 1 node
mem.c:854: INFO: set overcommit_memory to 0
mem.c:761: WARN: open /dev/cpuset/tasks: ENOENT
mem.c:766: WARN: fopen /dev/cpuset/1/tasks: ENOENT
mem.c:778: WARN: rmdir /dev/cpuset/1: ENOENT
mem.c:780: WARN: umount /dev/cpuset: ENOENT
mem.c:782: WARN: rmdir /dev/cpuset: ENOENT
mem.c:761: WARN: open /dev/cgroup/tasks: ENOENT
mem.c:766: WARN: fopen /dev/cgroup/1/tasks: ENOENT
mem.c:778: WARN: rmdir /dev/cgroup/1: ENOENT
mem.c:780: WARN: umount /dev/cgroup: ENOENT
mem.c:782: WARN: rmdir /dev/cgroup: ENOENT

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/mem/oom/oom04.c | 3 +++
 testcases/kernel/mem/oom/oom05.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/testcases/kernel/mem/oom/oom04.c b/testcases/kernel/mem/oom/oom04.c
index e4e70e2..6da690a 100644
--- a/testcases/kernel/mem/oom/oom04.c
+++ b/testcases/kernel/mem/oom/oom04.c
@@ -80,6 +80,9 @@ static void setup(void)
 
 static void cleanup(void)
 {
+	if (!is_numa(NULL, NH_MEMS, 1))
+		return;
+
 	set_sys_tune("overcommit_memory", overcommit, 0);
 	umount_mem(CPATH, CPATH_NEW);
 }
diff --git a/testcases/kernel/mem/oom/oom05.c b/testcases/kernel/mem/oom/oom05.c
index bdf5d19..d874cc5 100644
--- a/testcases/kernel/mem/oom/oom05.c
+++ b/testcases/kernel/mem/oom/oom05.c
@@ -105,6 +105,9 @@ void setup(void)
 
 void cleanup(void)
 {
+	if (!is_numa(NULL, NH_MEMS, 1))
+		return;
+
 	set_sys_tune("overcommit_memory", overcommit, 0);
 	umount_mem(CPATH, CPATH_NEW);
 	umount_mem(MEMCG_PATH, MEMCG_PATH_NEW);
-- 
2.9.3

