From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 15 Mar 2017 17:12:46 +0100
Subject: [LTP] [COMMITTED] [PATCH] keyctl02: Require root
Message-ID: <20170315161246.25162-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Otherwise add_key() fails with EDQUOT sooner or later.

+ Print errno when add_key() fails

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/keyctl/keyctl02.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/keyctl/keyctl02.c b/testcases/kernel/syscalls/keyctl/keyctl02.c
index 7145a5a..11d3af9 100644
--- a/testcases/kernel/syscalls/keyctl/keyctl02.c
+++ b/testcases/kernel/syscalls/keyctl/keyctl02.c
@@ -78,7 +78,7 @@ static void do_test(void)
 		key = add_key("user", "ltptestkey", "foo", 3,
 			KEY_SPEC_PROCESS_KEYRING);
 		if (key == -1)
-			tst_brk(TBROK, "Failed to add key");
+			tst_brk(TBROK | TERRNO, "Failed to add key");
 
 		SAFE_PTHREAD_CREATE(&pth[0], NULL, do_read,
 			(void *)(unsigned long)key);
@@ -100,6 +100,7 @@ static void do_test(void)
 
 static struct tst_test test = {
 	.tid = "keyctl02",
+	.needs_root = 1,
 	.test_all = do_test,
 };
 
-- 
2.10.2

