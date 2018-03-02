From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri,  2 Mar 2018 16:48:38 +0100
Subject: [LTP] [COMMITTED] [PATCH 4/7] syscalls/inotify04: Fix cleanup
In-Reply-To: <20180302154841.4093-1-chrubis@suse.cz>
References: <20180302154841.4093-1-chrubis@suse.cz>
Message-ID: <20180302154841.4093-4-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The cleanup attempted to close() the inotify watch descriptors however
these are _NOT_ file descriptors and are allocated from completely
distinct space.

So in this case the inotify watch descriptors we got were 1 and 2 so we
closed the stdout and stderr at the end of the test which still made the
test pass without any error just by a chance.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/inotify/inotify04.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/testcases/kernel/syscalls/inotify/inotify04.c b/testcases/kernel/syscalls/inotify/inotify04.c
index b78277c13..e7f862026 100644
--- a/testcases/kernel/syscalls/inotify/inotify04.c
+++ b/testcases/kernel/syscalls/inotify/inotify04.c
@@ -81,7 +81,6 @@ static struct tst_kern_exv kvers[] = {
 
 static void cleanup(void)
 {
-
 	if (reap_wd_dir && myinotify_rm_watch(fd_notify, wd_dir) == -1)
 		tst_res(TWARN,
 			"inotify_rm_watch(%d, %d) [1] failed", fd_notify,
@@ -94,12 +93,6 @@ static void cleanup(void)
 
 	if (fd_notify > 0 && close(fd_notify))
 		tst_res(TWARN, "close(%d) [1] failed", fd_notify);
-
-	if (wd_dir > 0 && close(wd_dir))
-		tst_res(TWARN, "close(%d) [2] failed", wd_dir);
-
-	if (wd_file > 0 && close(wd_file))
-		tst_res(TWARN, "close(%d) [3] failed", wd_file);
 }
 
 static void setup(void)
-- 
2.13.6

