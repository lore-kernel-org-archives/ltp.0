From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  3 Oct 2017 17:40:49 +0200
Subject: [LTP] [COMMITTED] [PATCH 02/13] Make use of SAFE_DUP()
In-Reply-To: <20171003154100.807-1-chrubis@suse.cz>
References: <20171003154100.807-1-chrubis@suse.cz>
Message-ID: <20171003154100.807-2-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/fanotify/fanotify03.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify03.c b/testcases/kernel/syscalls/fanotify/fanotify03.c
index 1ab879843..ea5c02a7b 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify03.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify03.c
@@ -154,10 +154,7 @@ void test01(void)
 	int ret, len = 0, i = 0, test_num = 0;
 
 	if (fd_notify_backup == -1) {
-		fd_notify_backup = dup(fd_notify);
-		if (fd_notify_backup < 0)
-			tst_brk(TBROK | TERRNO,
-				 "dup(%d) failed", fd_notify);
+		fd_notify_backup = SAFE_DUP(fd_notify);
 	}
 	run_child();
 
-- 
2.13.5

