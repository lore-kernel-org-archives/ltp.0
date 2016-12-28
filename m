From: Cui Bixuan <cuibixuan@huawei.com>
Date: Wed, 28 Dec 2016 20:14:45 +0800
Subject: [LTP]  [PATCH] rt_sigtimedwait01: fix probability of failure
In-Reply-To: <585201FA.9010508@huawei.com>
References: <584FBAE7.2010100@huawei.com> <20161213104352.GA750@rei.lan>
 <585201FA.9010508@huawei.com>
Message-ID: <5863ACB5.8000606@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

If child[0] of test_masked_matching_rt() haven't had chance to
finish until we get to the sigwaitinfo() call, the case will fail.

So we should add waitpid() to make sure that both children are finished.

Signed-off-by: Cui Bixuan <cuibixuan@huawei.com>
---
 testcases/kernel/syscalls/utils/common_j_h.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/kernel/syscalls/utils/common_j_h.c b/testcases/kernel/syscalls/utils/common_j_h.c
index 43165ca..784ca04 100644
--- a/testcases/kernel/syscalls/utils/common_j_h.c
+++ b/testcases/kernel/syscalls/utils/common_j_h.c
@@ -119,6 +119,7 @@ static void sigterm_handler(int sig)
 pid_t create_sig_proc(unsigned long usec, int sig, unsigned count)
 {
 	pid_t pid, cpid;
+	int status;

 	pid = getpid();
 	WITH_SIGNALS_BLOCKED(if ((cpid = fork()) == 0) {
@@ -138,6 +139,8 @@ pid_t create_sig_proc(unsigned long usec, int sig, unsigned count)
 		EPRINTF("fork failed.\n");
 		return cpid;
 	default:
+		/* wait cpid finish */
+		waitpid(cpid, &status, 0);
 		return cpid;
 	}
 }
-- 
1.8.3.4


