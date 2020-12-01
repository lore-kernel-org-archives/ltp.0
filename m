From: Petr Vorel <pvorel@suse.cz>
Date: Tue,  1 Dec 2020 18:42:09 +0100
Subject: [LTP] [PATCH v5 05/10] fanotify16: Test also on FUSE
In-Reply-To: <20201201174214.24625-1-pvorel@suse.cz>
References: <20201201174214.24625-1-pvorel@suse.cz>
Message-ID: <20201201174214.24625-6-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

.dev_fs_flags = TST_FS_SKIP_FUSE flag was requested due missing
FAN_REPORT_FID support. But that's now covered (in previous commit).

It's better to not cast the filesystem when not needed (it might gain
the support later) + unify with other tests (fanotify13.c).

Suggested-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
New in v5.

 testcases/kernel/syscalls/fanotify/fanotify16.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify16.c b/testcases/kernel/syscalls/fanotify/fanotify16.c
index c02a57dcd..a379226f8 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify16.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify16.c
@@ -579,7 +579,6 @@ static void cleanup(void)
 static struct tst_test test = {
 	.test = do_test,
 	.tcnt = ARRAY_SIZE(test_cases),
-	.dev_fs_flags = TST_FS_SKIP_FUSE,
 	.setup = setup,
 	.cleanup = cleanup,
 	.mount_device = 1,
-- 
2.29.2

