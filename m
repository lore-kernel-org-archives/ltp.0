From: Punit Agrawal <punit.agrawal@arm.com>
Date: Mon,  4 Dec 2017 16:36:50 +0000
Subject: [LTP] [PATCH v3 07/12] sigwaitinfo01: fix race between sending and
	dequeueing RT signals
In-Reply-To: <20171204163655.8838-1-punit.agrawal@arm.com>
References: <20171204163655.8838-1-punit.agrawal@arm.com>
Message-ID: <20171204163655.8838-8-punit.agrawal@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: Will Deacon <will.deacon@arm.com>

Although RT signals are dequeued in order, there is a race where only
the higher signal may have been sent and will therefore be dequeued
first, leading to a false failure.

This patch waits on the signal sending tasks so that we can be sure both
of the signals have been sent before dequeuing them.

Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
---
 testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo01.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo01.c b/testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo01.c
index 35acd67c4..16b5096b8 100644
--- a/testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo01.c
+++ b/testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo01.c
@@ -249,6 +249,7 @@ void test_masked_matching_rt(swi_func sigwaitinfo, int signo)
 	sigset_t sigs, oldmask;
 	siginfo_t si;
 	pid_t child[2];
+	int status;
 
 	signo = SIGRTMIN + 1;
 
@@ -268,6 +269,10 @@ void test_masked_matching_rt(swi_func sigwaitinfo, int signo)
 	child[0] = create_sig_proc(0, signo, 1);
 	child[1] = create_sig_proc(0, signo + 1, 1);
 
+	/* Ensure that the signals have been sent */
+	waitpid(child[0], &status, 0);
+	waitpid(child[1], &status, 0);
+
 	TEST(sigwaitinfo(&sigs, &si, NULL));
 	REPORT_SUCCESS_COND(signo, 0, si.si_pid == child[0]
 			    && si.si_code == SI_USER
-- 
2.15.0

