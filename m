From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Mon, 10 Dec 2018 17:58:41 +0800
Subject: [LTP] [PATCH] syscalls/fanotify09.c: Fix wrong group number
Message-ID: <1544435921-17431-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/fanotify/fanotify09.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify09.c b/testcases/kernel/syscalls/fanotify/fanotify09.c
index 625634a..0f926c4 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify09.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify09.c
@@ -216,7 +216,7 @@ static void test_fanotify(unsigned int n)
 		ret = read(fd_notify[i], event_buf, FAN_EVENT_METADATA_LEN);
 		if (ret > 0) {
 			tst_res(TFAIL, "group %d got event", i);
-			verify_event(0, event, FAN_CLOSE_NOWRITE);
+			verify_event(i, event, FAN_CLOSE_NOWRITE);
 			if (event->fd != FAN_NOFD)
 				SAFE_CLOSE(event->fd);
 			continue;
-- 
1.8.3.1



