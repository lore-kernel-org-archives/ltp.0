From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 23 Jan 2017 15:23:11 +0100
Subject: [LTP] [PATCH v2 3/3] ipc/msgsnd0*: cleanup && convert to new API
In-Reply-To: <1485167476-18151-3-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20170119143903.GC9193@rei.lan>
 <1485167476-18151-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1485167476-18151-3-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20170123142311.GA25788@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/testcases/kernel/syscalls/ipc/msgsnd/.msgsnd02.c.swo b/testcases/kernel/syscalls/ipc/msgsnd/.msgsnd02.c.swo
> new file mode 100644

I've removed this file, as it was included in the commit by accident.

And I've also modified the SAFE_MSGCTL() to set the msqid to -1 on cmd
== IPC_RMID (similarily what we do for fd for SAFE_CLOSE()). Since with
that we can safely add a cleanup() to the msgsnd06 that removes the
queue if the test exits with TBROK somewhere between the queue being
created and removed.

Pushed with this diff:

diff --git a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd01.c b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd01.c
index 49aaf1f..7101bdb 100644
--- a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd01.c
+++ b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd01.c
@@ -26,6 +26,7 @@
 #include <sys/msg.h>
 
 #include "tst_test.h"
+#include "tst_safe_sysv_ipc.h"
 #include "libnewipc.h"
 
 static key_t msgkey;
diff --git a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd02.c b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd02.c
index 219d40f..5bdc6c8 100644
--- a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd02.c
+++ b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd02.c
@@ -39,6 +39,7 @@
 #include <pwd.h>
 
 #include "tst_test.h"
+#include "tst_safe_sysv_ipc.h"
 #include "libnewipc.h"
 
 static key_t msgkey;
diff --git a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd05.c b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd05.c
index 42c89a8..3d13f3e 100644
--- a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd05.c
+++ b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd05.c
@@ -31,6 +31,7 @@
 #include <sys/msg.h>
 
 #include "tst_test.h"
+#include "tst_safe_sysv_ipc.h"
 #include "libnewipc.h"
 
 static key_t msgkey;
@@ -86,6 +87,7 @@ static void do_test(unsigned int n)
 
 	pid = SAFE_FORK();
 	if (!pid) {
+		SAFE_SIGNAL(SIGHUP, sighandler);
 		verify_msgsnd(tc);
 		_exit(0);
 	}
@@ -97,8 +99,6 @@ static void do_test(unsigned int n)
 
 static void setup(void)
 {
-	SAFE_SIGNAL(SIGHUP, sighandler);
-
 	msgkey = GETIPCKEY();
 
 	queue_id = SAFE_MSGGET(msgkey, IPC_CREAT | IPC_EXCL | MSG_RW);
diff --git a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd06.c b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd06.c
index 2436481..787cf97 100644
--- a/testcases/kernel/syscalls/ipc/msgsnd/msgsnd06.c
+++ b/testcases/kernel/syscalls/ipc/msgsnd/msgsnd06.c
@@ -28,6 +28,7 @@
 #include <sys/msg.h>
 
 #include "tst_test.h"
+#include "tst_safe_sysv_ipc.h"
 #include "libnewipc.h"
 
 static key_t msgkey;
@@ -80,11 +81,20 @@ static void setup(void)
 	msgkey = GETIPCKEY();
 }
 
+static void cleanup(void)
+{
+	if (queue_id != -1 && msgctl(queue_id, IPC_RMID, NULL)) {
+		tst_res(TWARN | TERRNO, "failed to delete message queue %i",
+			queue_id);
+	}
+}
+
 static struct tst_test test = {
 	.tid = "msgsnd06",
 	.needs_tmpdir = 1,
 	.needs_root = 1,
 	.forks_child = 1,
 	.setup = setup,
+	.cleanup = cleanup,
 	.test_all = do_test
 };

Thanks!

-- 
Cyril Hrubis
chrubis@suse.cz
