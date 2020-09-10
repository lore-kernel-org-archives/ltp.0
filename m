From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 10 Sep 2020 14:16:28 +0200
Subject: [LTP] [PATCH 1/1] fanotify10: Treat ignore mask bug as TCONF for <
 v5.9
Message-ID: <20200910121628.18505-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Suggested-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi Amir,

based on suggestion http://lists.linux.it/pipermail/ltp/2020-September/018891.html,
but not really sure if it should be applied, because we loose warning:

HINT: You _MAY_ be missing kernel fixes, see:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9bdda4e9cf2d
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2f02fd3fa13e
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=497b0c5a7c06

Kind regards,
Petr


 testcases/kernel/syscalls/fanotify/fanotify10.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify10.c b/testcases/kernel/syscalls/fanotify/fanotify10.c
index 2c4401f61..5b4591b4a 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify10.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify10.c
@@ -508,8 +508,8 @@ static void test_fanotify(unsigned int n)
 					"zero length read from fanotify fd");
 			}
 			if (ret > 0) {
-				tst_res(TFAIL, "group %d (%x) with %s and "
-					"%s ignore mask got event",
+				tst_res((tst_kvercmp(5, 9, 0)) < 0 ? TCONF : TFAIL,
+					"group %d (%x) with %s and %s ignore mask got event",
 					i, fanotify_class[p], mark->name, ignore_mark->name);
 				if (event->fd != FAN_NOFD)
 					SAFE_CLOSE(event->fd);
-- 
2.28.0

