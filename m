From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 10 Sep 2020 13:07:12 +0200
Subject: [LTP] [PATCH 1/1] syscalls/fanotify15: TCONF also on EOPNOTSUPP
Message-ID: <20200910110712.2181-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

instead of TBROK:
fanotify15.c:86: INFO: Test #0: FAN_REPORT_FID on filesystem including FAN_DELETE_SELF
fanotify15.c:96: BROK: fanotify_mark(3, FAN_MARK_ADD | FAN_MARK_FILESYSTEM, FAN_CREATE | FAN_DELETE | FAN_MOVE | FAN_MODIFY | FAN_ONDIR | 0x400, AT_FDCWD, mntpoint/test_dir) failed: EOPNOTSUPP (95)

is now reported:
fanotify15.c:86: INFO: Test #0: FAN_REPORT_FID on filesystem including FAN_DELETE_SELF
fanotify15.c:93: CONF: FAN_REPORT_FID not supported on exfat filesystem

fanotify15.c:86: INFO: Test #0: FAN_REPORT_FID on filesystem including FAN_DELETE_SELF
fanotify15.c:93: CONF: FAN_REPORT_FID not supported on ntfs filesystem

Found on 5.8.0 on openSUSE Tumbleweed.

Fixes: 403f11f3a ("syscalls/fanotify15: verify fid for dirent events")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

I suppose that EXDEV (in fanotify_test_fid()) is really error which
should be caught as TBROK (unlike ENODEV and EOPNOTSUPP). Am I correct?

Kind regards,
Petr

 testcases/kernel/syscalls/fanotify/fanotify15.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify15.c b/testcases/kernel/syscalls/fanotify/fanotify15.c
index cca6a5313..6cb1b4a2f 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify15.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify15.c
@@ -89,7 +89,7 @@ static void do_test(unsigned int number)
 				FAN_CREATE | FAN_DELETE | FAN_MOVE |
 				FAN_MODIFY | FAN_ONDIR,
 				AT_FDCWD, TEST_DIR) == -1) {
-		if (errno == ENODEV)
+		if (errno == ENODEV || errno == EOPNOTSUPP)
 			tst_brk(TCONF,
 				"FAN_REPORT_FID not supported on %s "
 				"filesystem", tst_device->fs_type);
-- 
2.28.0

