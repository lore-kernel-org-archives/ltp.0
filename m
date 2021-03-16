From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Tue, 16 Mar 2021 17:50:54 +0800
Subject: [LTP] [PATCH] pidns13: Use getpid syscall directly instead of glibc
 wrapper
Message-ID: <1615888254-31940-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

As clone(2) man-pages said "GNU C library versions 2.3.4 up to and including
2.24 contained a wrapper function for getpid(2) that performed caching of PIDs.
This caching relied on support in the glibc wrapper for clone(), but limitations
in the implementation meant that the cache was not up to date in some circumstances".

Because of the stale-cache problem, as well as other problems noted in getpid(2), the
PID caching feature was removed in glibc 2.25

To get the truth, always use getpid syscall instead of getting value from cache.
It fixes failure on centos7.

Reported-by: Feiyu Zhu <zhufy.jy@cn.fujitsu.com>
Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 testcases/kernel/containers/pidns/pidns13.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/containers/pidns/pidns13.c b/testcases/kernel/containers/pidns/pidns13.c
index 12aee917b..c27ef51b4 100644
--- a/testcases/kernel/containers/pidns/pidns13.c
+++ b/testcases/kernel/containers/pidns/pidns13.c
@@ -54,7 +54,7 @@ static void child_fn(unsigned int cinit_no)
 	pid_t pid, ppid;
 	int flags;
 
-	pid = getpid();
+	pid = tst_syscall(__NR_getpid);
 	ppid = getppid();
 	if (pid != CHILD_PID || ppid != PARENT_PID)
 		tst_brk(TBROK, "cinit%u: pidns not created.", cinit_no);
-- 
2.23.0



