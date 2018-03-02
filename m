From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri,  2 Mar 2018 16:48:40 +0100
Subject: [LTP] [COMMITTED] [PATCH 6/7] syscalls/inotify06: Cleanup
In-Reply-To: <20180302154841.4093-1-chrubis@suse.cz>
References: <20180302154841.4093-1-chrubis@suse.cz>
Message-ID: <20180302154841.4093-6-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

* Remove empty cleanup

* Make use of SAFE_MACROS()

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/inotify/inotify06.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/inotify/inotify06.c b/testcases/kernel/syscalls/inotify/inotify06.c
index aff07e84c..a3a60180a 100644
--- a/testcases/kernel/syscalls/inotify/inotify06.c
+++ b/testcases/kernel/syscalls/inotify/inotify06.c
@@ -55,10 +55,6 @@
 
 char names[FILES][PATH_MAX];
 
-static void cleanup(void)
-{
-}
-
 static void setup(void)
 {
 	int i;
@@ -105,15 +101,14 @@ static void verify_inotify(void)
 	tst_res(TPASS, "kernel survived inotify beating");
 
 	/* Kill the child creating / deleting files and wait for it */
-	kill(pid, SIGKILL);
-	wait(NULL);
+	SAFE_KILL(pid, SIGKILL);
+	SAFE_WAIT(NULL);
 }
 
 static struct tst_test test = {
 	.needs_tmpdir = 1,
 	.forks_child = 1,
 	.setup = setup,
-	.cleanup = cleanup,
 	.test_all = verify_inotify,
 };
 
-- 
2.13.6

