From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 11 Sep 2017 13:32:18 +0200
Subject: [LTP] [PATCH] syscalls/shmat01: avoid dumping corefile for expected
	crash
Message-ID: <8df1dcaee102405b65fb575744323b3dfb348de1.1505129509.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/ipc/shmat/shmat01.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/ipc/shmat/shmat01.c b/testcases/kernel/syscalls/ipc/shmat/shmat01.c
index 0ea407530462..ad0410aac127 100644
--- a/testcases/kernel/syscalls/ipc/shmat/shmat01.c
+++ b/testcases/kernel/syscalls/ipc/shmat/shmat01.c
@@ -69,8 +69,16 @@ static void *expected_addr(void *in_addr, void *out_addr)
 	return ALIGN_DOWN(in_addr);
 }
 
-static void do_child(int *in_addr)
+static void do_child(int *in_addr, int expect_crash)
 {
+	if (expect_crash) {
+		/* crash is expected, avoid dumping corefile */
+		struct rlimit r;
+
+		r.rlim_cur = 1;
+		r.rlim_max = 1;
+		SAFE_SETRLIMIT(RLIMIT_CORE, &r);
+	}
 	*in_addr = 10;
 
 	exit(0);
@@ -121,7 +129,7 @@ static void verify_shmat(unsigned int n)
 
 	pid = SAFE_FORK();
 	if (!pid)
-		do_child(addr);
+		do_child(addr, tc->exp_status == SIGSEGV);
 	else
 		SAFE_WAITPID(pid, &status, 0);
 
-- 
1.8.3.1

