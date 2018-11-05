From: Jan Stancek <jstancek@redhat.com>
Date: Mon,  5 Nov 2018 16:46:16 +0100
Subject: [LTP] [PATCH 3/4] syscalls/migrate_pages02: print /proc stats only
	on failure
In-Reply-To: <4ab262666b5022a1f62a2e2967899dfecc56396d.1541431525.git.jstancek@redhat.com>
References: <4ab262666b5022a1f62a2e2967899dfecc56396d.1541431525.git.jstancek@redhat.com>
Message-ID: <a2022c57398c905e11e54b3de4694ff6cd815edf.1541431525.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/migrate_pages/migrate_pages02.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c b/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
index c9c057cf0b78..e11d52ba4400 100644
--- a/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
+++ b/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
@@ -107,13 +107,14 @@ static int migrate_to_node(pid_t pid, int node)
 	TEST(tst_syscall(__NR_migrate_pages, pid, max_node, old_nodes,
 		new_nodes));
 	if (TST_RET != 0) {
-		if (TST_RET < 0)
+		if (TST_RET < 0) {
 			tst_res(TFAIL | TERRNO, "migrate_pages failed "
 				 "ret: %ld, ", TST_RET);
-		else
+			print_mem_stats(pid, node);
+		} else {
 			tst_res(TINFO, "migrate_pages could not migrate all "
 				 "pages, not migrated: %ld", TST_RET);
-		print_mem_stats(pid, node);
+		}
 	}
 	free(old_nodes);
 	free(new_nodes);
-- 
1.8.3.1

