From: Joerg Vehlow <lkml@jv-coder.de>
Date: Wed,  1 Sep 2021 07:17:04 +0200
Subject: [LTP] [PATCH] tst_wallclock: Prevent fail on read-only
 /etc/localtime
Message-ID: <20210901051704.1672590-1-lkml@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Joerg Vehlow <joerg.vehlow@aox-tech.de>

If /etc/localtime is readonly, the time should not
have changed anyway.

Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>
---
 lib/tst_wallclock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/tst_wallclock.c b/lib/tst_wallclock.c
index 1244ea26b..ee53e2b7f 100644
--- a/lib/tst_wallclock.c
+++ b/lib/tst_wallclock.c
@@ -72,7 +72,7 @@ void tst_wallclock_restore(void)
 	 * might not be enough because the current access time might be far
 	 * in the future.
 	 */
-	ret = access(localtime, F_OK);
+	ret = access(localtime, F_OK | W_OK);
 	if (!ret)
 		SAFE_TOUCH(localtime, 0, NULL);
 }
-- 
2.25.1

