From: Jan Stancek <jstancek@redhat.com>
Date: Mon,  5 Nov 2018 16:46:15 +0100
Subject: [LTP] [PATCH 2/4] syscalls/migrate_pages02: use a separate page for
	private memory
In-Reply-To: <4ab262666b5022a1f62a2e2967899dfecc56396d.1541431525.git.jstancek@redhat.com>
References: <4ab262666b5022a1f62a2e2967899dfecc56396d.1541431525.git.jstancek@redhat.com>
Message-ID: <566c1f2427bb4b1c0d52f3c23e6f528068c69cb4.1541431525.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Fixes: #407

Allocate private memory with mmap, to avoid sharing
pages with libc, which could potentially get locked.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../syscalls/migrate_pages/migrate_pages02.c       | 55 ++++++++++++----------
 1 file changed, 29 insertions(+), 26 deletions(-)

diff --git a/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c b/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
index aa9ade71f527..c9c057cf0b78 100644
--- a/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
+++ b/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
@@ -153,28 +153,30 @@ static int check_addr_on_node(void *addr, int exp_node)
 
 static void test_migrate_current_process(int node1, int node2, int cap_sys_nice)
 {
-	char *testp, *testp2;
+	char *private, *shared;
 	int ret, status;
 	pid_t child;
 
 	/* parent can migrate its non-shared memory */
 	tst_res(TINFO, "current_process, cap_sys_nice: %d", cap_sys_nice);
-	testp = SAFE_MALLOC(getpagesize());
-	testp[0] = 0;
-	tst_res(TINFO, "private anonymous: %p", testp);
+	private =  SAFE_MMAP(NULL, getpagesize(), PROT_READ | PROT_WRITE,
+		MAP_ANONYMOUS | MAP_PRIVATE, 0, 0);
+	private[0] = 0;
+	tst_res(TINFO, "private anonymous: %p", private);
+
 	migrate_to_node(0, node2);
-	check_addr_on_node(testp, node2);
+	check_addr_on_node(private, node2);
 	migrate_to_node(0, node1);
-	check_addr_on_node(testp, node1);
-	free(testp);
+	check_addr_on_node(private, node1);
+	SAFE_MUNMAP(private, getpagesize());
 
 	/* parent can migrate shared memory with CAP_SYS_NICE */
-	testp2 = SAFE_MMAP(NULL, getpagesize(), PROT_READ | PROT_WRITE,
+	shared = SAFE_MMAP(NULL, getpagesize(), PROT_READ | PROT_WRITE,
 		      MAP_ANONYMOUS | MAP_SHARED, 0, 0);
-	testp2[0] = 1;
-	tst_res(TINFO, "shared anonymous: %p", testp2);
+	shared[0] = 1;
+	tst_res(TINFO, "shared anonymous: %p", shared);
 	migrate_to_node(0, node2);
-	check_addr_on_node(testp2, node2);
+	check_addr_on_node(shared, node2);
 
 	/* shared mem is on node2, try to migrate in child to node1 */
 	fflush(stdout);
@@ -182,18 +184,18 @@ static void test_migrate_current_process(int node1, int node2, int cap_sys_nice)
 	if (child == 0) {
 		tst_res(TINFO, "child shared anonymous, cap_sys_nice: %d",
 			 cap_sys_nice);
-		testp = SAFE_MALLOC(getpagesize());
-		testp[0] = 1;
-		testp2[0] = 1;
+		private =  SAFE_MMAP(NULL, getpagesize(),
+			PROT_READ | PROT_WRITE,
+			MAP_ANONYMOUS | MAP_PRIVATE, 0, 0);
+		private[0] = 1;
+		shared[0] = 1;
 		if (!cap_sys_nice)
 			SAFE_SETEUID(ltpuser->pw_uid);
 
 		migrate_to_node(0, node1);
 		/* child can migrate non-shared memory */
-		ret = check_addr_on_node(testp, node1);
+		ret = check_addr_on_node(private, node1);
 
-		free(testp);
-		SAFE_MUNMAP(testp2, getpagesize());
 		exit(ret);
 	}
 
@@ -201,15 +203,15 @@ static void test_migrate_current_process(int node1, int node2, int cap_sys_nice)
 	if (cap_sys_nice)
 		/* child can migrate shared memory only
 		 * with CAP_SYS_NICE */
-		check_addr_on_node(testp2, node1);
+		check_addr_on_node(shared, node1);
 	else
-		check_addr_on_node(testp2, node2);
-	SAFE_MUNMAP(testp2, getpagesize());
+		check_addr_on_node(shared, node2);
+	SAFE_MUNMAP(shared, getpagesize());
 }
 
 static void test_migrate_other_process(int node1, int node2, int cap_sys_nice)
 {
-	char *testp;
+	char *private;
 	int ret, status;
 	pid_t child1, child2;
 
@@ -218,12 +220,14 @@ static void test_migrate_other_process(int node1, int node2, int cap_sys_nice)
 	fflush(stdout);
 	child1 = SAFE_FORK();
 	if (child1 == 0) {
-		testp = SAFE_MALLOC(getpagesize());
-		testp[0] = 0;
+		private =  SAFE_MMAP(NULL, getpagesize(),
+			PROT_READ | PROT_WRITE,
+			MAP_ANONYMOUS | MAP_PRIVATE, 0, 0);
+		private[0] = 0;
 
 		/* make sure we are on node1 */
 		migrate_to_node(0, node1);
-		check_addr_on_node(testp, node1);
+		check_addr_on_node(private, node1);
 
 		SAFE_SETUID(ltpuser->pw_uid);
 
@@ -237,9 +241,8 @@ static void test_migrate_other_process(int node1, int node2, int cap_sys_nice)
 
 		/* child2 can migrate child1 process if it's privileged */
 		/* child2 can migrate child1 process if it has same uid */
-		ret = check_addr_on_node(testp, node2);
+		ret = check_addr_on_node(private, node2);
 
-		free(testp);
 		exit(ret);
 	}
 
-- 
1.8.3.1

