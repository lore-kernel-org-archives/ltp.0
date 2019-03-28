From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 28 Mar 2019 11:50:06 +0100
Subject: [LTP] [PATCH 1/1] Remove break after return
Message-ID: <20190328105006.17337-1-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Reported-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/select/select_var.h       | 1 -
 testcases/kernel/syscalls/sigpending/sigpending02.c | 3 ---
 2 files changed, 4 deletions(-)

diff --git a/testcases/kernel/syscalls/select/select_var.h b/testcases/kernel/syscalls/select/select_var.h
index b19a1d1bf..29ebbc5ee 100644
--- a/testcases/kernel/syscalls/select/select_var.h
+++ b/testcases/kernel/syscalls/select/select_var.h
@@ -20,7 +20,6 @@ static int do_select(int nfds, fd_set *readfds, fd_set *writefds, fd_set *except
 	switch (tst_variant) {
 	case 0:
 		return select(nfds, readfds, writefds, exceptfds, timeout);
-	break;
 	case 1: {
 #ifdef __LP64__
 		return tst_syscall(__NR_select, nfds, readfds, writefds, exceptfds, timeout);
diff --git a/testcases/kernel/syscalls/sigpending/sigpending02.c b/testcases/kernel/syscalls/sigpending/sigpending02.c
index ce0d2ff79..d75807d77 100644
--- a/testcases/kernel/syscalls/sigpending/sigpending02.c
+++ b/testcases/kernel/syscalls/sigpending/sigpending02.c
@@ -37,13 +37,10 @@ static int tested_sigpending(sigset_t *sigset)
 	switch (tst_variant) {
 	case 0:
 		return sigpending(sigset);
-	break;
 	case 1:
 		return tst_syscall(__NR_sigpending, sigset);
-	break;
 	case 2:
 		return tst_syscall(__NR_rt_sigpending, sigset, SIGSETSIZE);
-	break;
 	}
 	return -1;
 }
-- 
2.20.1

