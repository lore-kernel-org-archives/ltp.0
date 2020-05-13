From: Yann Sionneau <ysionneau@kalray.eu>
Date: Wed, 13 May 2020 14:13:27 +0200
Subject: [LTP] [PATCH] Fix issue when running fcntl31 and fcntl31_64 over
 SSH as session leader
Message-ID: <20200513121327.16342-1-ysionneau@kalray.eu>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

If you run the test like this:
ssh localhost path/to/fcntl31

It will fail like this:
TBROK  :  fcntl31.c:121: setpgrp() failed: errno=EPERM(1): Operation not permitted

As man page for setpgrp says, it is indeed not permitted to change process group ID
when you are session leader (PID == SID).

Signed-off-by: Yann Sionneau <ysionneau@kalray.eu>
---
 testcases/kernel/syscalls/fcntl/fcntl31.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/fcntl/fcntl31.c b/testcases/kernel/syscalls/fcntl/fcntl31.c
index 52b4932fa..fd284fd7e 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl31.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl31.c
@@ -116,9 +116,12 @@ static void setup(void)
 
 	pid = getpid();
 
-	ret = setpgrp();
-	if (ret < 0)
-		tst_brkm(TBROK | TERRNO, cleanup, "setpgrp() failed");
+	/* Changing process group ID is forbidden when PID == SID i.e. we are session leader */
+	if (pid != getsid(0)) {
+		ret = setpgrp();
+		if (ret < 0)
+			tst_brkm(TBROK | TERRNO, cleanup, "setpgrp() failed");
+	}
 	pgrp_pid = getpgid(0);
 	if (pgrp_pid < 0)
 		tst_brkm(TBROK | TERRNO, cleanup, "getpgid() failed");
-- 
2.17.1

