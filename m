From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 27 Aug 2018 15:37:12 +0200
Subject: [LTP] [PATCH] syscalls/move_pages: move_pages() can return positive
	value
Message-ID: <15602db6c7187069f12f06cac46d06e1b715bbb9.1535376449.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Since the rework done in a49bd4d71637 ("mm, numa: rework do_pages_move"),
move_pages() can return also positive value.

This is similar to how migrate_pages() behaves. Current man page
does not reflect commit above, man-page thread can be followed here:
  https://marc.info/?t=153511369900003&r=1&w=2

This patch only changes immediate test condition after syscall,
so they don't treat positive value as FAIL. Test can still
fail on subsequent checks.

Fixes: #388

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/move_pages/move_pages01.c | 4 +++-
 testcases/kernel/syscalls/move_pages/move_pages02.c | 4 +++-
 testcases/kernel/syscalls/move_pages/move_pages03.c | 4 +++-
 testcases/kernel/syscalls/move_pages/move_pages04.c | 2 ++
 testcases/kernel/syscalls/move_pages/move_pages05.c | 2 ++
 testcases/kernel/syscalls/move_pages/move_pages09.c | 2 +-
 testcases/kernel/syscalls/move_pages/move_pages12.c | 2 +-
 7 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/syscalls/move_pages/move_pages01.c b/testcases/kernel/syscalls/move_pages/move_pages01.c
index f541e9f227c1..0e83106454fc 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages01.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages01.c
@@ -89,10 +89,12 @@ int main(int argc, char **argv)
 			continue;
 
 		ret = numa_move_pages(0, TEST_PAGES, pages, NULL, status, 0);
-		if (ret != 0) {
+		if (ret == -1) {
 			tst_resm(TFAIL|TERRNO, "move_pages failed");
 			free_pages(pages, TEST_PAGES);
 			continue;
+		} else if (ret > 0) {
+			tst_resm(TINFO, "move_pages() returned %d\n", ret);
 		}
 
 		verify_pages_linear(pages, status, TEST_PAGES);
diff --git a/testcases/kernel/syscalls/move_pages/move_pages02.c b/testcases/kernel/syscalls/move_pages/move_pages02.c
index 728f88f5ad2e..827a152cf14c 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages02.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages02.c
@@ -103,10 +103,12 @@ int main(int argc, char **argv)
 		ret =
 		    numa_move_pages(0, TEST_PAGES, pages, nodes, status,
 				    MPOL_MF_MOVE);
-		if (ret != 0) {
+		if (ret == -1) {
 			tst_resm(TFAIL|TERRNO, "move_pages failed");
 			free_pages(pages, TEST_PAGES);
 			continue;
+		} else if (ret > 0) {
+			tst_resm(TINFO, "move_pages() returned %d\n", ret);
 		}
 
 		for (i = 0; i < TEST_PAGES; i++)
diff --git a/testcases/kernel/syscalls/move_pages/move_pages03.c b/testcases/kernel/syscalls/move_pages/move_pages03.c
index 88a94d92dd9e..c65597c1d36d 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages03.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages03.c
@@ -164,9 +164,11 @@ int main(int argc, char **argv)
 
 		ret = numa_move_pages(0, TEST_PAGES, pages, nodes,
 				      status, MPOL_MF_MOVE_ALL);
-		if (ret != 0) {
+		if (ret == -1) {
 			tst_resm(TFAIL|TERRNO, "move_pages failed");
 			goto err_kill_child;
+		} else if (ret > 0) {
+			tst_resm(TINFO, "move_pages() returned %d\n", ret);
 		}
 
 		verify_pages_on_node(pages, status, TEST_PAGES, to_node);
diff --git a/testcases/kernel/syscalls/move_pages/move_pages04.c b/testcases/kernel/syscalls/move_pages/move_pages04.c
index bf24a0895261..df5e334e23e3 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages04.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages04.c
@@ -131,6 +131,8 @@ int main(int argc, char **argv)
 			tst_resm(TFAIL | TERRNO,
 				 "move_pages unexpectedly failed");
 			goto err_free_pages;
+		} else if (ret > 0) {
+			tst_resm(TINFO, "move_pages() returned %d\n", ret);
 		}
 
 		if (status[UNTOUCHED_PAGE] == exp_status) {
diff --git a/testcases/kernel/syscalls/move_pages/move_pages05.c b/testcases/kernel/syscalls/move_pages/move_pages05.c
index 51ac058e058b..7db3c47a9fb4 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages05.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages05.c
@@ -175,6 +175,8 @@ int main(int argc, char **argv)
 			tst_resm(TFAIL | TERRNO,
 				 "move_pages unexpectedly failed");
 			goto err_kill_child;
+		} else if (ret > 0) {
+			tst_resm(TINFO, "move_pages() returned %d\n", ret);
 		}
 
 		if (status[SHARED_PAGE] == -EACCES)
diff --git a/testcases/kernel/syscalls/move_pages/move_pages09.c b/testcases/kernel/syscalls/move_pages/move_pages09.c
index 273c750ff8f9..5c2d8d320d12 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages09.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages09.c
@@ -109,7 +109,7 @@ int main(int argc, char **argv)
 		 *     mm: stop returning -ENOENT from sys_move_pages() if nothing got migrated
 		 */
 		if ((tst_kvercmp(2, 6, 28)) >= 0) {
-			if (ret == 0)
+			if (ret >= 0)
 				tst_resm(TPASS, "move_pages succeeded");
 			else
 				tst_resm(TFAIL | TERRNO, "move_pages");
diff --git a/testcases/kernel/syscalls/move_pages/move_pages12.c b/testcases/kernel/syscalls/move_pages/move_pages12.c
index b1187e307559..c0ff27114110 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages12.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages12.c
@@ -87,7 +87,7 @@ static void do_child(void)
 
 		TEST(numa_move_pages(ppid, test_pages,
 			pages, nodes, status, MPOL_MF_MOVE_ALL));
-		if (TST_RET) {
+		if (TST_RET == -1) {
 			tst_res(TFAIL | TTERRNO, "move_pages failed");
 			break;
 		}
-- 
1.8.3.1

