Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <will.deacon@arm.com>) id 1PmS5P-0003bS-Pa
	for ltp-list@lists.sourceforge.net; Mon, 07 Feb 2011 14:29:03 +0000
Received: from service87.mimecast.com ([94.185.240.25])
	by sog-mx-3.v43.ch3.sourceforge.com with smtp (Exim 4.74)
	id 1PmS5O-00039c-IV
	for ltp-list@lists.sourceforge.net; Mon, 07 Feb 2011 14:29:03 +0000
From: Will Deacon <will.deacon@arm.com>
Date: Mon,  7 Feb 2011 14:28:46 +0000
Message-Id: <1297088926-21505-1-git-send-email-will.deacon@arm.com>
Subject: [LTP] [PATCH] Fix rt_sigtimedwait ordering test
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

The rt_sigtimedwait test invokes test_masked_matching_rt, which
spawns two children who send consecutive RT signals to the parent.
The test then checks (via sigwaitinfo) that the RT signals are
delivered in the correct order: namely that the lower signal is taken
first.

This test can fail due to a race condition where the parent issues
the sigwaitinfo syscall before the first child has signalled the
parent but after the second child has (due to context switching).
This results in the signals being received in the reverse order.

This patch inserts waitpid syscalls to the parent thread so that the
sigwaitinfo call is only issued after the children have exited.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 .../kernel/syscalls/sigwaitinfo/sigwaitinfo01.c    |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo01.c b/testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo01.c
index c0e0241..439dfb3 100644
--- a/testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo01.c
+++ b/testcases/kernel/syscalls/sigwaitinfo/sigwaitinfo01.c
@@ -232,6 +232,7 @@ void test_masked_matching_rt(swi_func sigwaitinfo, int signo)
 	sigset_t sigs, oldmask;
 	siginfo_t si;
 	pid_t child[2];
+	int status;
 
 	signo = SIGRTMIN+1;
 
@@ -250,6 +251,10 @@ void test_masked_matching_rt(swi_func sigwaitinfo, int signo)
 	child[0]=create_sig_proc(0, signo, 1);
 	child[1]=create_sig_proc(0, signo+1, 1);
 
+	/* Ensure that the signals have been sent */
+	waitpid(child[0], &status, 0);
+	waitpid(child[1], &status, 0);
+
 	TEST(sigwaitinfo(&sigs, &si, NULL));
 	REPORT_SUCCESS_COND(signo, 0, si.si_pid==child[0] && si.si_code==SI_USER && si.si_signo==signo, "Struct siginfo mismatch");
 
@@ -434,4 +439,4 @@ int main(int argc, char** argv)
 
 	cleanup();
 	tst_exit();
-}
\ No newline at end of file
+}
-- 
1.7.0.4



------------------------------------------------------------------------------
The modern datacenter depends on network connectivity to access resources
and provide services. The best practices for maximizing a physical server's
connectivity to a physical network are well understood - see how these
rules translate into the virtual world? 
http://p.sf.net/sfu/oracle-sfdevnlfb
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
