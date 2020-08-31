From: Li Wang <liwang@redhat.com>
Date: Mon, 31 Aug 2020 06:35:52 +0000
Subject: [LTP] [COMMITTED] utimensat01: fix kvers arrary boundary
Message-ID: <20200831063552.11252-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

To get rid of errors:
   8 utimensat01.c:295: INFO: Testing variant: syscall with old kernel spec
   9 tst_test.c:1300: BROK: Test killed by SIGSEGV!

and,
  BROK: utimensat01.c:293: mkdir(test_dir,0700) failed: EEXIST (17)

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/syscalls/utimensat/utimensat01.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/utimensat/utimensat01.c b/testcases/kernel/syscalls/utimensat/utimensat01.c
index 5cc5f1d33..e2d4fee3e 100644
--- a/testcases/kernel/syscalls/utimensat/utimensat01.c
+++ b/testcases/kernel/syscalls/utimensat/utimensat01.c
@@ -161,6 +161,7 @@ static void update_error(struct test_case *tc)
 	static struct tst_kern_exv kvers[] = {
 		/* Ubuntu kernel has patch b3b4283 since 4.4.0-48.69 */
 		{ "UBUNTU", "4.4.0-48.69" },
+		{ NULL, NULL},
 	};
 
 	if (tc->exp_err != -1)
@@ -295,7 +296,8 @@ static void setup(void)
 	tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
 
 	bad_addr = tst_get_bad_addr(NULL);
-	SAFE_MKDIR(TEST_DIR, 0700);
+	if (access(TEST_DIR, R_OK))
+		SAFE_MKDIR(TEST_DIR, 0700);
 
 	for (i = 0; i < ARRAY_SIZE(tcase); i++)
 		update_error(&tcase[i]);
-- 
2.21.1

