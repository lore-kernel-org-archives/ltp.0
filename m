From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Wed, 24 Aug 2016 15:27:52 +0300
Subject: [LTP] [PATCH V2 04/11] syscalls/waitpid: call reap_children() via
	TST_TRACE()
In-Reply-To: <1472041679-29759-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1472041679-29759-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <1472041679-29759-5-git-send-email-stanislav.kholmanskikh@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

To make the tracing of the failed code path easier.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
This is a new patch in the series.

 testcases/kernel/syscalls/waitpid/waitpid06.c |    2 +-
 testcases/kernel/syscalls/waitpid/waitpid07.c |    2 +-
 testcases/kernel/syscalls/waitpid/waitpid08.c |    2 +-
 testcases/kernel/syscalls/waitpid/waitpid10.c |    4 ++--
 testcases/kernel/syscalls/waitpid/waitpid11.c |    5 +++--
 5 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/waitpid/waitpid06.c b/testcases/kernel/syscalls/waitpid/waitpid06.c
index 66d5ebc..20c30e1 100644
--- a/testcases/kernel/syscalls/waitpid/waitpid06.c
+++ b/testcases/kernel/syscalls/waitpid/waitpid06.c
@@ -48,7 +48,7 @@ static void do_child_1(void)
 
 	TST_CHECKPOINT_WAKE2(0, MAXKIDS);
 
-	if (reap_children(-1, 0, fork_kid_pid, MAXKIDS))
+	if (TST_TRACE(reap_children(-1, 0, fork_kid_pid, MAXKIDS)))
 		return;
 
 	tst_res(TPASS, "Test PASSED");
diff --git a/testcases/kernel/syscalls/waitpid/waitpid07.c b/testcases/kernel/syscalls/waitpid/waitpid07.c
index 74da914..47ebf9a 100644
--- a/testcases/kernel/syscalls/waitpid/waitpid07.c
+++ b/testcases/kernel/syscalls/waitpid/waitpid07.c
@@ -57,7 +57,7 @@ static void do_child_1(void)
 
 	TST_CHECKPOINT_WAKE2(0, MAXKIDS);
 
-	if (reap_children(-1, WNOHANG, fork_kid_pid, MAXKIDS))
+	if (TST_TRACE(reap_children(-1, WNOHANG, fork_kid_pid, MAXKIDS)))
 		return;
 
 	tst_res(TPASS, "Test PASSED");
diff --git a/testcases/kernel/syscalls/waitpid/waitpid08.c b/testcases/kernel/syscalls/waitpid/waitpid08.c
index 0f0ee9d..b95a308 100644
--- a/testcases/kernel/syscalls/waitpid/waitpid08.c
+++ b/testcases/kernel/syscalls/waitpid/waitpid08.c
@@ -61,7 +61,7 @@ static void do_child_1(void)
 
 	TST_CHECKPOINT_WAKE2(0, MAXKIDS);
 
-	if (reap_children(-1, WUNTRACED, fork_kid_pid, MAXKIDS))
+	if (TST_TRACE(reap_children(-1, WUNTRACED, fork_kid_pid, MAXKIDS)))
 		return;
 
 	/*
diff --git a/testcases/kernel/syscalls/waitpid/waitpid10.c b/testcases/kernel/syscalls/waitpid/waitpid10.c
index a505ade..90b3800 100644
--- a/testcases/kernel/syscalls/waitpid/waitpid10.c
+++ b/testcases/kernel/syscalls/waitpid/waitpid10.c
@@ -56,7 +56,7 @@ static void do_child_1(void)
 
 	TST_CHECKPOINT_WAKE2(0, MAXKIDS);
 
-	if (reap_children(0, 0, fork_kid_pid, MAXKIDS))
+	if (TST_TRACE(reap_children(0, 0, fork_kid_pid, MAXKIDS)))
 		return;
 
 	tst_res(TPASS, "Test PASSED");
@@ -94,7 +94,7 @@ static void do_fork(void)
 		if (fork_pid == 0)
 			exit(3);
 
-		if (reap_children(fork_pid, 0, &fork_pid, 1))
+		if (TST_TRACE(reap_children(fork_pid, 0, &fork_pid, 1)))
 			break;
 	}
 
diff --git a/testcases/kernel/syscalls/waitpid/waitpid11.c b/testcases/kernel/syscalls/waitpid/waitpid11.c
index 9b51e04..1067bca 100644
--- a/testcases/kernel/syscalls/waitpid/waitpid11.c
+++ b/testcases/kernel/syscalls/waitpid/waitpid11.c
@@ -50,11 +50,12 @@ static void do_child_1(void)
 
 	TST_CHECKPOINT_WAKE2(0, MAXKIDS);
 
-	if (reap_children(0, 0, fork_kid_pid + (MAXKIDS / 2), MAXKIDS / 2))
+	if (TST_TRACE(reap_children(0, 0, fork_kid_pid + (MAXKIDS / 2),
+				    MAXKIDS / 2)))
 		return;
 
 	/* Make sure can pickup children in a diff. process group */
-	if (reap_children(-group, 0, fork_kid_pid, MAXKIDS / 2))
+	if (TST_TRACE(reap_children(-group, 0, fork_kid_pid, MAXKIDS / 2)))
 		return;
 
 	tst_res(TPASS, "Test PASSED");
-- 
1.7.1

