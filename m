From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 31 Mar 2020 13:21:31 +0200
Subject: [LTP] [COMMITTED] [PATCH] syscalls/clone301: Fix race between
 parent and child
Message-ID: <20200331112131.2837-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The signal handler has to be set up before we clone() the child,
otherwise the signal may be lost if the child manages to call exit()
before parent is able to continue.

Reported-by: Richard Palethorpe <rpalethorpe@suse.com>
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/clone3/clone301.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/clone3/clone301.c b/testcases/kernel/syscalls/clone3/clone301.c
index f6d5c5dda..456291b67 100644
--- a/testcases/kernel/syscalls/clone3/clone301.c
+++ b/testcases/kernel/syscalls/clone3/clone301.c
@@ -103,12 +103,12 @@ static void run(unsigned int n)
 		return;
 	}
 
-	if (!pid)
-		do_child(clone_pidfd, n);
-
 	parent_received_signal = 0;
 	SAFE_SIGACTION(tc->exit_signal, &psig_action, NULL);
 
+	if (!pid)
+		do_child(clone_pidfd, n);
+
 	/* Need to send signal to child process */
 	if (clone_pidfd) {
 		TST_CHECKPOINT_WAIT(0);
-- 
2.24.1

