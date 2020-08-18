From: Po-Hsu Lin <po-hsu.lin@canonical.com>
Date: Tue, 18 Aug 2020 18:04:22 +0800
Subject: [LTP] [PATCHv2 2/2] syscalls/utimensat01: add exception for Ubuntu
 4.4 kernel
In-Reply-To: <20200818100422.27775-1-po-hsu.lin@canonical.com>
References: <20200818100422.27775-1-po-hsu.lin@canonical.com>
Message-ID: <20200818100422.27775-3-po-hsu.lin@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Ubuntu 4.4 kernel got this patch (b3b4283) since 4.4.0-48.69,
therefore it will return EPERM instead of EACCES.

Without this fix, the test will fail on Ubuntu 4.4 kernel with:
  FAIL: 18: utimensat() failed with incorrect error, expected EACCES: EPERM (1)
  FAIL: 19: utimensat() failed with incorrect error, expected EACCES: EPERM (1)

Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 testcases/kernel/syscalls/utimensat/utimensat01.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/utimensat/utimensat01.c b/testcases/kernel/syscalls/utimensat/utimensat01.c
index 7dabfed6d..de4f0601b 100644
--- a/testcases/kernel/syscalls/utimensat/utimensat01.c
+++ b/testcases/kernel/syscalls/utimensat/utimensat01.c
@@ -158,6 +158,11 @@ static void tst_multi_set_time(enum tst_ts_type type, struct mytime *mytime)
 
 static void update_error(struct test_case *tc)
 {
+	// Special case for Ubuntu kernel, which has patch b3b4283 since 4.4.0-48.69
+	static struct tst_kern_exv kvers[] = {
+		{ "UBUNTU", "4.4.0-48.69" },
+	};
+
 	if (tc->exp_err != -1)
 		return;
 
@@ -167,7 +172,7 @@ static void update_error(struct test_case *tc)
 	 * This patch has also been merged to stable 4.4 with
 	 * b3b4283 ("vfs: move permission checking into notify_change() for utimes(NULL)")
 	 */
-	if (tst_kvercmp(4, 4, 27) < 0)
+	if (tst_kvercmp2(4, 4, 27, kvers) < 0)
 		tc->exp_err = EACCES;
 	else
 		tc->exp_err = EPERM;
-- 
2.25.1

