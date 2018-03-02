From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri,  2 Mar 2018 16:48:39 +0100
Subject: [LTP] [COMMITTED] [PATCH 5/7] syscalls/inotify05: Cleanup
In-Reply-To: <20180302154841.4093-1-chrubis@suse.cz>
References: <20180302154841.4093-1-chrubis@suse.cz>
Message-ID: <20180302154841.4093-5-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* Make use of SAFE_MACROS() in cleanup

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/inotify/inotify05.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/inotify/inotify05.c b/testcases/kernel/syscalls/inotify/inotify05.c
index 2d9b299f5..2d8897e5d 100644
--- a/testcases/kernel/syscalls/inotify/inotify05.c
+++ b/testcases/kernel/syscalls/inotify/inotify05.c
@@ -173,8 +173,8 @@ static void cleanup(void)
 
 	}
 
-	if (fd_notify > 0 && close(fd_notify) == -1)
-		tst_res(TWARN, "close(%d) failed", fd_notify);
+	if (fd_notify > 0)
+		SAFE_CLOSE(fd_notify);
 }
 
 static struct tst_test test = {
-- 
2.13.6

