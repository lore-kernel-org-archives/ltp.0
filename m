From: Jan Stancek <jstancek@redhat.com>
Date: Mon,  3 Oct 2016 15:43:01 +0200
Subject: [LTP] [PATCH] move_pages04: fix zero page status code for kernels
	>= 4.3
Message-ID: <896d677024a4273f2d762aaef1a020c6b08e186b.1475501850.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

d899844e9c98 "mm: fix status code which move_pages() returns for zero
page" changed status code for zero pages (allocated but not written
to yet) from -ENOENT to -EFAULT.

This patch mirros the change for move_pages04 testcase.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../kernel/syscalls/move_pages/move_pages04.c      | 27 +++++++++++++++-------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/syscalls/move_pages/move_pages04.c b/testcases/kernel/syscalls/move_pages/move_pages04.c
index 1657beea4819..8c8b7de2d5a4 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages04.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages04.c
@@ -30,9 +30,14 @@
  *
  * ALGORITHM
  *
- *      1. Pass a page that does not exit as one of the page addresses
- *         to move_pages().
- *      2. Check if the corresponding status is set to -ENOENT.
+ *      1. Pass zero page (allocated, but not written to) as one of the
+ *         page addresses to move_pages().
+ *      2. Check if the corresponding status is set to:
+ *         -ENOENT for kernels < 4.3
+ *         -EFAULT for kernels >= 4.3 [1]
+ *
+ * [1]
+ * d899844e9c98 "mm: fix status code which move_pages() returns for zero page"
  *
  * USAGE:  <for command-line>
  *      move_pages04 [-c n] [-i n] [-I x] [-P x] [-t]
@@ -84,7 +89,12 @@ int main(int argc, char **argv)
 	int lc;
 	unsigned int from_node;
 	unsigned int to_node;
-	int ret;
+	int ret, exp_status;
+
+	if ((tst_kvercmp(4, 3, 0)) >= 0)
+		exp_status = -EFAULT;
+	else
+		exp_status = -ENOENT;
 
 	ret = get_allowed_nodes(NH_MEMS, 2, &from_node, &to_node);
 	if (ret < 0)
@@ -123,12 +133,13 @@ int main(int argc, char **argv)
 			goto err_free_pages;
 		}
 
-		if (status[UNTOUCHED_PAGE] == -ENOENT)
-			tst_resm(TPASS, "status[%d] set to expected -ENOENT",
+		if (status[UNTOUCHED_PAGE] == exp_status)
+			tst_resm(TPASS, "status[%d] has expected value",
 				 UNTOUCHED_PAGE);
 		else
-			tst_resm(TFAIL, "status[%d] is %d", UNTOUCHED_PAGE,
-				 status[UNTOUCHED_PAGE]);
+			tst_resm(TFAIL, "status[%d] is %d, expected %d",
+				UNTOUCHED_PAGE, status[UNTOUCHED_PAGE],
+				exp_status);
 
 err_free_pages:
 		/* This is capable of freeing both the touched and
-- 
1.8.3.1

