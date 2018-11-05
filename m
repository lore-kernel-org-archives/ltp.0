From: Jan Stancek <jstancek@redhat.com>
Date: Mon,  5 Nov 2018 16:46:17 +0100
Subject: [LTP] [PATCH 4/4] syscalls/migrate_pages02: run with numa balancing
	disabled
In-Reply-To: <4ab262666b5022a1f62a2e2967899dfecc56396d.1541431525.git.jstancek@redhat.com>
References: <4ab262666b5022a1f62a2e2967899dfecc56396d.1541431525.git.jstancek@redhat.com>
Message-ID: <775b030997cb22f90d812bb798311b46b3ab3217.1541431525.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Fixes: #407

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/migrate_pages/migrate_pages02.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c b/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
index e11d52ba4400..99b6623a703f 100644
--- a/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
+++ b/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
@@ -63,6 +63,11 @@ static struct passwd *ltpuser;
 static int *nodes, nodeA, nodeB;
 static int num_nodes;
 
+static const char * const save_restore[] = {
+	"?/proc/sys/kernel/numa_balancing",
+	NULL,
+};
+
 static void print_mem_stats(pid_t pid, int node)
 {
 	char s[64];
@@ -295,6 +300,7 @@ static void setup(void)
 	else if (tst_kvercmp(2, 6, 18) < 0)
 		tst_brk(TCONF, "2.6.18 or greater kernel required");
 
+	FILE_PRINTF("/proc/sys/kernel/numa_balancing", "0");
 	/*
 	 * find 2 nodes, which can hold NODE_MIN_FREEMEM bytes
 	 * The reason is that:
@@ -345,6 +351,7 @@ static struct tst_test test = {
 	.forks_child = 1,
 	.test_all = run,
 	.setup = setup,
+	.save_restore = save_restore,
 };
 #else
 TST_TEST_TCONF(NUMA_ERROR_MSG);
-- 
1.8.3.1

