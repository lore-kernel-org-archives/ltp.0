From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 17 Apr 2020 13:39:48 +0200
Subject: [LTP] [COMMITTED] [PATCH] tst_cmd: Fix exit in search for program
 in $PATH
Message-ID: <20200417113948.12678-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The check is executed before fork() so we have to do return instead of
exit() otherwise we exit the library process.

Fixes: 105d283bc ("lib/tst_cmd_*(): Search for program in $PATH")

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 lib/tst_cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/tst_cmd.c b/lib/tst_cmd.c
index 3a90d1a5d..4b67d4b31 100644
--- a/lib/tst_cmd.c
+++ b/lib/tst_cmd.c
@@ -64,7 +64,7 @@ int tst_cmd_fds_(void (cleanup_fn)(void),
 			tst_brkm(TCONF, cleanup_fn, "Couldn't find '%s' in $PATH at %s:%d", argv[0],
 				 __FILE__, __LINE__);
 		else
-			_exit(255);
+			return 255;
 	}
 
 	pid_t pid = vfork();
-- 
2.24.1

