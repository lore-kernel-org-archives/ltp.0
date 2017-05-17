From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 17 May 2017 10:16:15 +0200
Subject: [LTP] [COMMITTED PATCH] move_pages12: fix int overflow on arm with
	512M huge pages
Message-ID: <f94e15863f9e119f07278bbe9e29932689fec3e2.1495008939.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/move_pages/move_pages12.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/move_pages/move_pages12.c b/testcases/kernel/syscalls/move_pages/move_pages12.c
index dda10d68468b..f2a035f7f92f 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages12.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages12.c
@@ -231,8 +231,8 @@ static void setup(void)
 		SAFE_FILE_PRINTF(PATH_NR_HUGEPAGES, "%ld", orig_hugepages + 8);
 	}
 
-	alloc_free_huge_on_node(node1, 4 * hpsz);
-	alloc_free_huge_on_node(node2, 4 * hpsz);
+	alloc_free_huge_on_node(node1, 4L * hpsz);
+	alloc_free_huge_on_node(node2, 4L * hpsz);
 }
 
 static void cleanup(void)
-- 
1.8.3.1

