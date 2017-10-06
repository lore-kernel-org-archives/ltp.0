From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri,  6 Oct 2017 12:38:39 +0200
Subject: [LTP] [RFC] [PATCH] syscalls/madvise09: Fix TCONF propagation,
	remove .min_kver
Message-ID: <20171006103839.24544-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

This patch fixes TCONF propagation from the child to parent, the parent
have to handle the TCONF exit value.

And it also removes the .min_kver in order to enable the test on
distribution kernels that backported the MADV_FREE. Older kernels are
handled by the runtime EINVAL detection or will TCONF at the check for
memory cgroup support, so there is no real need to keep the .min_kver in
the source code.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/madvise/madvise09.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/madvise/madvise09.c b/testcases/kernel/syscalls/madvise/madvise09.c
index 7ad76f795..fc284accf 100644
--- a/testcases/kernel/syscalls/madvise/madvise09.c
+++ b/testcases/kernel/syscalls/madvise/madvise09.c
@@ -305,8 +305,13 @@ retry:
 		goto retry;
 	}
 
-	if (WIFEXITED(status) && WEXITSTATUS(status))
-		tst_brk(TBROK, "Child exitted unexpectedly");
+	if (WIFEXITED(status)) {
+		if (WEXITSTATUS(status) == TCONF)
+			tst_brk(TCONF, "MADV_FREE is not supported");
+
+		if (WEXITSTATUS(status))
+			tst_brk(TBROK, "Child exitted unexpectedly");
+	}
 }
 
 static void setup(void)
@@ -334,7 +339,6 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.test_all = run,
-	.min_kver = "4.5",
 	.needs_root = 1,
 	.forks_child = 1,
 };
-- 
2.13.5

