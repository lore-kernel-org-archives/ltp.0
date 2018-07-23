From: Li Wang <liwang@redhat.com>
Date: Mon, 23 Jul 2018 13:40:00 +0800
Subject: [LTP] [PATCH] madvise: remove the min_kver check
Message-ID: <20180723054000.13760-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

For the reason that most of LTS enterprise linux distribution backport
this MADV_WIPEONFORK feature, here let's cancel the kernel limitation
to make madvise(..., MADV_WIPEONFORK) test more widely.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/syscalls/madvise/madvise10.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/madvise/madvise10.c b/testcases/kernel/syscalls/madvise/madvise10.c
index f040c2d..9cb3d2b 100644
--- a/testcases/kernel/syscalls/madvise/madvise10.c
+++ b/testcases/kernel/syscalls/madvise/madvise10.c
@@ -103,8 +103,13 @@ static int set_advice(char *addr, int size, int advise)
 	TEST(madvise(addr, size, advise));
 
 	if (TEST_RETURN == -1) {
-		tst_res(TFAIL | TTERRNO, "madvise(%p, %d, 0x%x)",
+		if (TEST_ERRNO == EINVAL) {
+			tst_res(TCONF, "madvise(%p, %d, 0x%x) is not supported",
 			addr, size, advise);
+		} else {
+			tst_res(TFAIL | TTERRNO, "madvise(%p, %d, 0x%x)",
+			addr, size, advise);
+		}
 
 		return 1;
 	}
@@ -175,5 +180,4 @@ static struct tst_test test = {
 	.forks_child = 1,
 	.test = test_madvise,
 	.setup = setup,
-	.min_kver = "4.14",
 };
-- 
2.9.5

