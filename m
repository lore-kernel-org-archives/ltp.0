From: Murphy Zhou <xzhou@redhat.com>
Date: Thu, 30 May 2019 16:58:34 +0800
Subject: [LTP] [PATCH] lib/tst_test: print INFO msg for test variants
Message-ID: <20190530085834.21432-1-xzhou@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Make the test output clearer about what's going on when we
run multiple variants.

Signed-off-by: Murphy Zhou <xzhou@redhat.com>
---
 lib/tst_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 2d88adbd7..fec6c9aba 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1201,6 +1201,7 @@ void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
 		test_variants = tst_test->test_variants;
 
 	for (tst_variant = 0; tst_variant < test_variants; tst_variant++) {
+		tst_res(TINFO, "Running tst_variant %d\n", tst_variant);
 		if (tst_test->all_filesystems)
 			ret |= run_tcases_per_fs();
 		else
-- 
2.21.0

