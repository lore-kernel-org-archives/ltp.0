From: zhanglianjie <zhanglianjie@uniontech.com>
Date: Tue, 30 Mar 2021 18:46:13 +0800
Subject: [LTP] [PATCH] Modify the test logic of mincore.
Message-ID: <20210330104613.1059-1-zhanglianjie@uniontech.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Currently mincore has a vulnerability and is easy to be attacked.
CVE has fixed the vulnerability.
Please see https://www.linuxkernelcves.com/cves/CVE-2019-5489

Signed-off-by: zhanglianjie <zhanglianjie@uniontech.com>
---
 testcases/kernel/syscalls/mincore/mincore04.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/syscalls/mincore/mincore04.c b/testcases/kernel/syscalls/mincore/mincore04.c
index ed0ab7dfa..345dedd9a 100644
--- a/testcases/kernel/syscalls/mincore/mincore04.c
+++ b/testcases/kernel/syscalls/mincore/mincore04.c
@@ -95,12 +95,12 @@ static void test_mincore(void)
 	locked_pages = count_pages_in_cache();
 	tst_reap_children();

-	if (locked_pages == NUM_PAGES)
-		tst_res(TPASS, "mincore reports all %d pages locked by child process "
-			"are resident", locked_pages);
-	else
-		tst_res(TFAIL, "mincore reports %d pages resident but %d pages "
+	if (locked_pages == 0)
+		tst_res(TPASS, "mincore reports %d pages resident but %d pages "
 			"locked by child process", locked_pages, NUM_PAGES);
+	else
+		tst_res(TFAIL, "mincore reports all %d pages locked by child process "
+			"are resident", locked_pages);
 }

 static struct tst_test test = {
@@ -109,4 +109,9 @@ static struct tst_test test = {
 	.forks_child = 1,
 	.test_all = test_mincore,
 	.needs_checkpoints = 1,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "574823bfab82"},
+		{"CVE", "2019-5489"},
+		{}
+	}
 };
--
2.20.1



