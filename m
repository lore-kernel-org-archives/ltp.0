From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon,  1 Jul 2019 13:08:57 +0200
Subject: [LTP] [COMMITTED] [PATCH] syscalls/acct01: Remove cleanup
Message-ID: <20190701110857.5895-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* There is no need to remove files in the temporary directory, it's
  deleted recursively on test exit anyways

* This fixes issue #540 where the test produced warnings on kernel with
  BSD_PROCESS_ACCT turned off

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/acct/acct01.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/testcases/kernel/syscalls/acct/acct01.c b/testcases/kernel/syscalls/acct/acct01.c
index f58e02584..ec570017b 100644
--- a/testcases/kernel/syscalls/acct/acct01.c
+++ b/testcases/kernel/syscalls/acct/acct01.c
@@ -91,12 +91,6 @@ static void setup(void)
 	memset(nametoolong, 'a', PATH_MAX+1);
 }
 
-static void cleanup(void)
-{
-	SAFE_UNLINK(TEST_TMPFILE);
-	SAFE_UNLINK(TEST_ELOOP);
-}
-
 static void verify_acct(unsigned int nr)
 {
 	struct test_case *tcase = &tcases[nr];
@@ -131,6 +125,5 @@ static struct tst_test test = {
 	.needs_rofs = 1,
 	.tcnt = ARRAY_SIZE(tcases),
 	.setup = setup,
-	.cleanup = cleanup,
 	.test = verify_acct,
 };
-- 
2.19.2

